/// <author>cxg 2017-12-18</author>
/// sessionid是必须要传的，因为要验证SESSION

unit ufun;

interface

uses
  SysUtils, Dialogs, Classes, SynCommons, mORMotMidasVCL, SynCrtSock, SynDB,
  SynDBRemote, SynDBDataset, SynDBMidasVCL, uCmd, Forms;

type
  TRest = class
  private
    FSessionID: SockString;
    FAuthenticationed: Boolean;
    FHttp: THttpClientSocket;
    FIP: SockString;
    FPort: SockString;
    FUser: SockString;
    FPassword: SockString;
    function urlEncodeParams(strings: TStrings): SockString;
    function httpPost(params: TStrings; var data: SockString): Integer;
    function getSessionId: SockString;
  public
    constructor Create(const ip, port, user, password: SockString);
    destructor Destroy; override;
    /// rest 方法 全部是POST提交 -----------------------------------------------
    /// <summary>
    /// 查询非事务SQL
    /// </summary>
    /// <param name="sql">SELECT * FROM...</param>
    /// <param name="data">返回数据集的数据（JSON格式）</param>
    procedure Qry(const sql: RawUTF8; var data: SockString);
    /// <summary>
    /// 执行事务SQL
    /// </summary>
    /// <param name="sql">insert...delete...update</param>
    procedure Exec(const sql: RawUTF8);
    /// <summary>
    /// 验证SESSION
    /// </summary>
    /// <param name="user">用户名</param>
    /// <param name="password">密码</param>
    /// <returns>200-成功</returns>
    function Authentication(const user, password: SockString): Integer;
    /// <summary>
    /// 通知服务端清除我的SESSION
    /// </summary>
    procedure Quit;
    /// <summary>
    /// 下载文件
    /// </summary>
    /// <param name="filename">文件名称</param>
    /// <returns></returns>
    function DownFile(const filename: SockString; var data: SockString): Integer;
    /// <summary>
    /// 上传文件
    /// </summary>
    /// <param name="filename">文件名称</param>
    /// <returns></returns>
    function UpFile(const filename,fileContent: SockString): Integer;
  end;

implementation

{ TRest }

constructor TRest.Create(const ip, port, user, password: SockString);
begin
  FIP := ip;
  FPort := port;
  FUser := user;
  FPassword := password;
  FSessionID := getSessionId;
  FHttp := OpenHttp(FIP, FPort);
end;

destructor TRest.Destroy;
begin
  Quit;
  if FHttp <> nil then
    FHttp.Free;
  inherited;
end;

function TRest.getSessionId: SockString;
var
  i: Cardinal;
begin
  i := abs(Random32 * PPtrInt(self)^);
  Result := IntToStr(i);
end;

function TRest.httpPost(params: TStrings; var data: SockString): Integer;
begin
  Result := fhttp.Post('', urlEncodeParams(params), JSON_CONTENT_TYPE);
  case Result of
    404:
      begin
        ShowMessage('404 error');
        Abort;
      end;
    iUserOrPasswordError:
      begin
        FAuthenticationed := False;
        ShowMessage('User or password error');
        Abort;
      end;
    iNoAuthentication:
      begin
        FAuthenticationed := False;
        ShowMessage('No authentication');
        Abort;
      end;
    iInvalidRequest:
      begin
        ShowMessage('Invalid request');
        Abort;
      end;
    iQuerySqlErr:
      begin
        ShowMessage('Query sql error');
        Abort;
      end;
    iExecuteSqlErr:
      begin
        ShowMessage('Execute sql error');
        Abort;
      end;
  end;
  data := fhttp.Content;
  FHttp.Content := '';
end;

procedure TRest.Qry(const sql: RawUTF8; var data: SockString);
var
  params: TStrings;
begin
  if not FAuthenticationed then
    Authentication(FUser, FPassword);
  params := TStringList.Create;
  try
    params.Add('cmd=' + sQUERY_SQL);
    params.Add('sql=' + sql);
    params.Add('sessionid=' + FSessionID);
    HttpPost(params, data);
  finally
    params.Free;
  end;
end;

function TRest.urlEncodeParams(strings: TStrings): SockString;
var
  i: Integer;
  S: string;
begin
  for i := 0 to strings.Count - 1 do
  begin
    S := strings.Names[i];
    if Length(strings.Values[S]) > 0 then
    begin
      strings.Values[S] := UrlEncode(strings.Values[S]);
    end;
    if Result = '' then
      Result := strings[i]
    else
      Result := Result + '&' + strings[i];
  end;
end;

function TRest.Authentication(const user, password: SockString): Integer;
var
  params: TStrings;
  data: SockString;
begin
  params := TStringList.Create;
  try
    params.Add('cmd=' + sAUTHENTICATION_USER);
    params.Add('user=' + UrlEncode(user));
    params.Add('password=' + UrlEncode(password));
    params.Add('sessionid=' + FSessionID);
    Result := HttpPost(params, data);
    FAuthenticationed := Result = 200;
  finally
    params.Free;
  end;
end;

procedure TRest.Quit;
var
  params: TStringList;
  data: SockString;
begin
  params := TStringList.Create;
  try
    params.Add('cmd=' + sQUIT);
    params.Add('sessionid=' + fsessionid);
    HttpPost(params, data);
  finally
    params.Free;
  end;
end;

procedure TRest.Exec(const sql: RawUTF8);
var
  params: TStrings;
  data: SockString;
begin
  if not FAuthenticationed then
    Authentication(FUser, FPassword);
  params := TStringList.Create;
  try
    params.Add('cmd=' + sEXECUTE_SQL);
    params.Add('sql=' + sql);
    params.Add('sessionid=' + FSessionID);
    HttpPost(params, data);
  finally
    params.Free;
  end;
end;

function TRest.DownFile(const filename: SockString; var data: SockString): Integer;
var
  params: TStrings;
begin
  if not FAuthenticationed then
    Authentication(FUser, FPassword);
  params := TStringList.Create;
  try
    params.Add('cmd=' + sDOWN_FILE);
    params.Add('filename=' + filename);
    params.Add('sessionid=' + FSessionID);
    Result := HttpPost(params, data);
  finally
    params.Free;
  end;
end;

function TRest.UpFile(const filename, fileContent: SockString): Integer;
var
  d, params: SockString;
begin
  if not FAuthenticationed then
    Authentication(FUser, FPassword);
  params := 'cmd=' + sUP_FILE + '&filename=' + filename +'&sessionid=' + FSessionID+ '&filecontent='+ fileContent;
  Result := fhttp.Post('', params, BINARY_CONTENT_TYPE);
end;

end.

