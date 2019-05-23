
/// <author>cxg 2017-12-20</author>
/// 主窗体


unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SynCommons, comCtrls, ToolWin, SynCrtSock, SynDB, SyncObjs,
  uCmd, uMsSql, uAuthentication, uDBServer, uHTTPSSYS, uOracle, uMYSQL,
  uWebsocket, ExtCtrls, ulog, SynLog;

type
  Tfmain = class(TForm)
    ToolBar1: TToolBar;
    btnStart: TToolButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    TabSheet3: TTabSheet;
    Label4: TLabel;
    edtIP: TEdit;
    Label5: TLabel;
    edtDatabase: TEdit;
    Label6: TLabel;
    edtUser: TEdit;
    Label7: TLabel;
    edtPassword: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtThreadNum: TEdit;
    edtHttpPort: TEdit;
    edtHttpsPort: TEdit;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    edtPort: TEdit;
    Label9: TLabel;
    edtServer: TEdit;
    Label10: TLabel;
    edtUser2: TEdit;
    Label11: TLabel;
    edtPassword2: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    edtUser8: TEdit;
    edtPassword8: TEdit;
    Label14: TLabel;
    cbDBType: TComboBox;
    GroupBox3: TGroupBox;
    Label15: TLabel;
    edtPort9: TEdit;
    Label16: TLabel;
    edtKey: TEdit;
    procedure btnStartClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fAuthentication: TAuthentication;
    fMSSQL: TMsSql;
    fOracle: Toracle;
    fMysql: Tmysql;
    fDBServer: TDBServer;
    fServer: THttpsSys;
    fWebSocket: TWebSocket;
  public
    { Public declarations }
    /// <summary>
    /// 增加一行日志显示
    /// </summary>
    /// <param name="value">日志</param>
    procedure addLine(const value: string);
  end;

var
  fmain: Tfmain;

implementation

{$R *.dfm}


{ Tfmain }

procedure Tfmain.addLine(const value: string);
var
  s: string;
begin
  s := FormatDateTime('yyyy-mm-dd hh:nn:ss-->' + value, Now);
  log.Log(sllInfo, s);
  Memo1.Lines.Add(s);
end;

procedure Tfmain.btnStartClick(Sender: TObject);
var
  props: TSQLDBConnectionProperties;
begin
  if log = nil then    // 日志
  begin
    log := TSynLog.Add;
    log.Family.DestinationPath := ExeVersion.ProgramFilePath + '\logs';
    log.Family.Level := [sllInfo, sllError, sllLastError, sllException, sllExceptionOS, sllFail, sllSQL];
    log.Family.AutoFlushTimeOut := 60;
  end;

  props := nil;
  if SameText(cbDBType.Text, sMSSQL) then
  begin
    fMSSQL := TMsSql.Create(edtIP.Text, edtDatabase.Text, edtUser.Text, edtPassword.Text);
    props := fMSSQL.MSSQL;
  end
  else if SameText(cbDBType.Text, sORACLE) then
  begin
    fOracle := Toracle.Create(edtIP.Text, edtDatabase.Text, edtUser.Text, edtPassword.Text);
    props := fOracle.ORACLE;
  end
  else if SameText(cbDBType.Text, sMYSQL) then
  begin
    fMysql := Tmysql.Create(edtIP.Text, edtDatabase.Text, edtUser.Text, edtPassword.Text);
    props := fMysql.MYSQL;
  end;
  // 数据库https.sys server 二进制数据序列
  fDBServer := TDBServer.Create(props, edtServer.Text, edtPort.Text, edtUser2.Text, edtPassword2.Text, strtoint(edtThreadNum.Text));
  // http session 验证
  fAuthentication := TAuthentication.Create(edtUser8.Text, edtPassword8.Text);
  // https.sys server  JSON数据序列
  fServer := THttpsSys.Create(props, edtHttpPort.Text, edtHttpsPort.Text, StrToIntDef(edtThreadNum.Text, 1), fAuthentication);
  fWebSocket := TWebSocket.Create(edtPort9.Text, edtKey.Text);    // websocket server

  addLine('开启中间件');
  addLine('连接数据库');
  btnStart.Enabled := False;
end;

procedure Tfmain.FormDestroy(Sender: TObject);
begin
  if fMSSQL <> nil then
    FreeAndNil(fMSSQL);
  if fOracle <> nil then
    FreeAndNil(fOracle);
  if fMysql <> nil then
    FreeAndNil(fMysql);
  if fDBServer <> nil then
    FreeAndNil(fDBServer);
  if fauthentication <> nil then
    FreeAndNil(fauthentication);
  if fServer <> nil then
    FreeAndNil(fServer);
  if fWebSocket <> nil then
    FreeAndNil(fWebSocket);
  if log <> nil then
    log.CloseLogFile;
end;

end.

