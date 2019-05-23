/// <author>cxg 2017-12-21</author>
/// https.sys server  JSON数据序列
/// modified by cxg 2018-1-15 增加下载文件
/// UrlDecode()，遇到#0会切断字符串

unit uHTTPSSYS;

interface

uses
  SysUtils, SynCommons, SynDB, SynCrtSock, uAuthentication, SynZip, Classes,
  uCmd, uLog, Forms, StrUtils;

type
  THttpsSys = class
  private
    fHttpApiServer: THttpApiServer;
    fProps: TSQLDBConnectionProperties;
    fHttpPort, fHttpsPort: SockString;
    fThreadNum: integer;
    fAuthentication: TAuthentication;
    /// <summary>
    /// 处理HTTP请求
    /// </summary>
    /// <param name="Ctxt">请求对象</param>
    /// <returns>200-成功，其它-失败</returns>
    function Process(Ctxt: THttpServerRequest): cardinal;
    // function getStr(const source, sbegin, send: SockString): SockString;
    /// <summary>
    /// 下载文件
    /// </summary>
    /// <param name="list"></param>
    /// <param name="Ctxt"></param>
    function DownloadFile(list: TStringList; Ctxt: THttpServerRequest): Cardinal;
    /// <summary>
    /// 上传文件
    /// </summary>
    /// <param name="list"></param>
    /// <param name="Ctxt"></param>
    /// <returns></returns>
    function UploadFile(list: TStringList; Ctxt: THttpServerRequest): Cardinal;
    /// <summary>
    /// 查询SQL
    /// </summary>
    /// <param name="list"></param>
    /// <param name="Ctxt"></param>
    /// <returns></returns>
    function Query(list: TStringList; Ctxt: THttpServerRequest): Cardinal;
    /// <summary>
    /// 执行事物SQL
    /// </summary>
    /// <param name="list"></param>
    /// <param name="Ctxt"></param>
    /// <returns></returns>
    function Execute(list: TStringList): Cardinal;
    /// <summary>
    /// 客户端退出
    /// </summary>
    /// <param name="list"></param>
    /// <param name="Ctxt"></param>
    /// <returns></returns>
    function Quit(list: TStringList): Cardinal;
  public
    /// <summary>
    /// 创建者方法
    /// </summary>
    /// <param name="prop">数据库连接</param>
    /// <param name="httpPort">http绑定端口</param>
    /// <param name="httpsPort">https绑定端口</param>
    /// <param name="threadnum">开启线程数量</param>
    /// <param name="Authentication">验证SESSION</param>
    constructor Create(props: TSQLDBConnectionProperties; const httpPort, httpsPort: SockString; threadnum: Integer; Authentication: TAuthentication = nil);
    /// <summary>
    /// 释放
    /// </summary>
    destructor Destroy; override;
    property HttpApiServer: THttpApiServer read fHttpApiServer;
  end;

implementation

{ THttpsSys }

constructor THttpsSys.Create(props: TSQLDBConnectionProperties; const httpPort, httpsPort: SockString; threadnum: Integer; Authentication: TAuthentication);
begin
  fProps := props;
  fHttpPort := httpPort;
  fHttpsPort := httpsPort;
  fThreadNum := threadnum;
  fAuthentication := Authentication;

  fHttpApiServer := THttpApiServer.Create(True);  // https.sys rest server
  fHttpApiServer.RegisterCompress(CompressGZip);   // 压缩
  fHttpApiServer.Clone(fThreadNum);           // 创建N个工作线程
  fHttpApiServer.AddUrl('', fHttpPort, False, '+', True);  // 注册http URL
  fHttpApiServer.AddUrl('', fHttpsPort, True, '+', True); // 注册https url
  fHttpApiServer.OnRequest := Process;                       // 处理通信事件
  fHttpApiServer.Start;
end;

destructor THttpsSys.Destroy;
begin
  fHttpApiServer.Shutdown;
  fHttpApiServer.Free;
  fHttpApiServer := nil;

  inherited;
end;

function split(src, dec: string): TStringList;
var
  i: integer;
  str: string;
begin
  result := TStringList.Create;
  repeat
    i := pos(dec, src);
    str := copy(src, 1, i - 1);
    if (str = '') and (i > 0) then
    begin
      delete(src, 1, length(dec));
      continue;
    end;
    if i > 0 then
    begin
      result.Add(str);
      delete(src, 1, i + length(dec) - 1);
    end;
  until i <= 0;
  if src <> '' then
    result.Add(src);
end;

{function THttpsSys.getStr(const source, sbegin, send: SockString): SockString;
var
  ib, ie: integer;
begin
  Result := '';
  if source = '' then
    Exit;
  ib := PosEx(sbegin, source);
  ie := PosEx(send, source);
  Result := AnsiMidStr(source, ib + Length(sbegin), ie - ib-Length(sbegin));
end;   }

function THttpsSys.DownloadFile(list: TStringList; Ctxt: THttpServerRequest): Cardinal;
var
  filename: RawUTF8;
begin
  filename := list.Values['filename'];
  log.Log(sllInfo, '下载文件 ' + filename);
  filename := ExtractFilePath(Application.ExeName) + filename;
  if FileExists(filename) then
  begin
    Ctxt.OutContent := StringFromFile(filename);
    Result := 200;
  end
  else
  begin
    log.Log(sllInfo, filename + ' 文件不存在，无法下载');
    Result := 404;
  end;
end;

function THttpsSys.Execute(list: TStringList): Cardinal;
var
  doc: TDocVariantData;
  ex: TQuery;
  i: Integer;
  sql: RawUTF8;
begin
  // 客户端发送的sql参数是一个JSON数组：["insert into t2(c1) values (''cxg17'')","update...","delete from..."]
  // 因此要逐条执行数组的每一个json字符串
  doc.InitJSONInPlace(Pointer(list.Values['sql']), JSON_OPTIONS_FAST_STRICTJSON);
  ex := TQuery.Create(fProps.ThreadSafeConnection);
  try
    ex.Close;
    ex.SQL.Clear;
    try
      for i := 0 to doc.Count - 1 do
      begin
        sql := doc.Value[i];
        log.Log(sllSQL, sql);
        ex.SQL.Add(sql);
      end;
      ex.ExecSQL;
      Result := 200;
    except
      on E: Exception do
      begin
        Result := iExecuteSqlErr;
        log.Log(sllError, 'executeSQL() ' + E.Message);
      end;
    end;
  finally
    ex.Free;
  end;
end;

function THttpsSys.Process(Ctxt: THttpServerRequest): cardinal;
var
  FN, cmd{, sql}: RawUTF8;
//  i: integer;
//  doc: TDocVariantData;
//  ex: TQuery;
  list: TStringList;
begin
  // 为了简单，只支持http POST，不支持HTTP GET
  Result := 404;
  list := nil;
  if Ctxt = nil then
    exit;
  Ctxt.OutContentType := JSON_CONTENT_TYPE;
  try
    // 解码
    FN := StringReplaceChars(UrlDecode(Ctxt.InContent), '/', '\');
    list := split(FN, '&');
    cmd := list.Values['cmd'];
    // 只有合法的SESSION才能请求服务
    if fAuthentication <> nil then
      if not SameText(cmd, sAUTHENTICATION_USER) then
        if not fauthentication.SessionExists(StrToIntDef(list.Values['sessionid'], 0)) then
        begin
          Result := iNoAuthentication;    // 非法SESSION
          exit;
        end;
    // 处理命令字------------------------------------------------------------------
    if SameText(cmd, sQUIT) then  // 客户端退出
    begin
      Result := Quit(list);
    end
    else if SameText(cmd, sDOWN_FILE) then   // 下载文件
    begin
      Result := DownloadFile(list, Ctxt);
    end
    else if SameText(cmd, sUP_FILE) then  // 上传文件
    begin
      Result := UploadFile(list, Ctxt);
    end
    else if SameText(cmd, sQUERY_SQL) then   // 查询非事务SQL
    begin
      Result := Query(list, Ctxt);
    end
    else if SameText(cmd, sEXECUTE_SQL) then  // 执行事务SQL
    begin
      Result := Execute(list);
    end
    else if SameText(cmd, sAUTHENTICATION_USER) then     // 验证SESSION
    begin
      if fAuthentication <> nil then
        if fauthentication.checkUser(list.Values['user'], list.Values['password']) then
        begin
          fauthentication.CreateSession(StrToIntDef(list.Values['sessionid'], 0));
          Result := 200;
        end
        else
        begin
          Result := iUserOrPasswordError;
        end
      else
        Result := 200;
    end
    else
    begin
      Result := iInvalidRequest;   // 不能识别的HTTP请求
    end;
  finally
    if list <> nil then
      list.Free;
  end;
end;

function THttpsSys.Query(list: TStringList; Ctxt: THttpServerRequest): Cardinal;
var
  sql: RawUTF8;
begin
  try
    sql := list.Values['sql'];
    log.Log(sllSQL, sql);
    Ctxt.OutContent := fProps.Execute(sql, []).FetchAllAsJSON(True);
    Result := 200;
  except
    on E: Exception do
    begin
      Result := iQuerySqlErr;
      log.Log(sllError, 'querySQL() ' + E.Message);
    end;
  end;
end;

function THttpsSys.Quit(list: TStringList): Cardinal;
begin
  if fAuthentication <> nil then
    fauthentication.RemoveSession(StrToIntDef(list.Values['sessionid'], 0));
  Result := 200;
end;

function THttpsSys.UploadFile(list: TStringList; Ctxt: THttpServerRequest): Cardinal;
var
  filename, tmp: RawUTF8;
begin
  filename := list.Values['filename'];
  log.Log(sllInfo, '上传文件 ' + filename);
  filename := ExtractFilePath(Application.ExeName) + filename;
  tmp := Copy(Ctxt.InContent, PosEx('filecontent=', Ctxt.InContent) + length('filecontent='), MaxInt);
  if FileFromString(tmp, filename) then
    Result := 200
  else
    Result := 404;
end;

end.

