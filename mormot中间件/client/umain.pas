/// <author>cxg 2017-12-16</author>
/// cxg 2017-12-21 增加websocket

unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, StdCtrls, DB, Grids, DBGrids, SynCommons,
  mORMotMidasVCL, SynCrtSock, SynDB, SynDBRemote, SynDBDataset, SynDBMidasVCL, ufun
  ,uWebSocket, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  uCmd,
  IdHTTP
  ;

type
  Tfmain = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    ToolBar1: TToolBar;
    DBGrid1: TDBGrid;
    edtIP2: TEdit;
    DataSource1: TDataSource;
    TabSheet2: TTabSheet;
    ToolBar2: TToolBar;
    ToolButton4: TToolButton;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    Label2: TLabel;
    edtIP: TEdit;
    edtServer: TEdit;
    Label4: TLabel;
    edtUser: TEdit;
    Label5: TLabel;
    edtPassword: TEdit;
    ToolButton5: TToolButton;
    Label3: TLabel;
    edtPort: TEdit;
    ToolButton1: TToolButton;
    Label6: TLabel;
    Label7: TLabel;
    edtUser8: TEdit;
    edtPassword8: TEdit;
    ToolButton2: TToolButton;
    TabSheet3: TTabSheet;
    Memo1: TMemo;
    Edit1: TEdit;
    Button1: TButton;
    Label8: TLabel;
    edtIP11: TEdit;
    Label9: TLabel;
    edtPort11: TEdit;
    Label10: TLabel;
    edtKey11: TEdit;
    Label11: TLabel;
    edtConn11: TEdit;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    IdHTTP1: TIdHTTP;
    procedure ToolButton4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
  private
    { Private declarations }
    Props: TSQLDBSocketConnectionProperties;
    cds: TSynDBDataSet;
    rest: TRest;
    websocket: twebsocket;
  public
    { Public declarations }
  end;

var
  fmain: Tfmain;

implementation

{$R *.dfm}

procedure Tfmain.ToolButton4Click(Sender: TObject);
var
  ib, ie: Cardinal;
begin
  ib := GetTickCount;
  cds.Close;
  cds.CommandText := 'select top 10000 * from t2'; //定义一个查询串
  cds.Open;
  ie := GetTickCount;
  Caption := IntToStr(cds.RecordCount) + '条记录，费时（毫秒）：' + inttostr(ie - ib);
  DataSource2.DataSet := cds;
end;

procedure Tfmain.FormCreate(Sender: TObject);
begin
  Props := TSQLDBSocketConnectionProperties.Create(edtIP.Text, edtServer.Text, edtUser.Text, edtPassword.Text);
  cds := TSynDBDataSet.Create(Self);
  cds.Connection := Props;
  rest := TRest.Create(edtIP2.Text, edtPort.Text, edtUser8.Text, edtPassword8.Text);
  websocket := TWebSocket.Create(edtIP11.Text, edtPort11.Text, edtKey11.Text, edtConn11.Text);
end;

procedure Tfmain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(websocket);
  FreeAndNil(Props);
  FreeAndNil(rest);


end;

procedure Tfmain.ToolButton5Click(Sender: TObject);
begin
  if cds.State in [dsinsert, dsedit] then
    cds.Post;
  if cds.ChangeCount > 0 then
    cds.ApplyUpdates(0);
end;

procedure Tfmain.ToolButton1Click(Sender: TObject);
var
  data: SockString;
begin
  rest.Qry('select top 1000 * from t2', data);
  DataSource1.DataSet := JSONToClientDataSet(Self, data);
end;

procedure Tfmain.ToolButton2Click(Sender: TObject);
begin
  rest.Exec('["update t2 set c2=''cxg'' where c1=''1''"]');
end;

procedure Tfmain.Button1Click(Sender: TObject);
begin
  websocket.Service.msg(edtConn11.Text, Edit1.Text);
  Sleep(100);
  Memo1.Lines.Add(websocketMsg);
end;

procedure Tfmain.ToolButton3Click(Sender: TObject);
var
  data: SockString;
  filename: SockString;
begin
  filename := 'mormot中间件.zip';
  rest.DownFile(filename, data);
  FileFromString(data, ExtractFilePath(Application.ExeName) + filename);
end;

procedure Tfmain.ToolButton6Click(Sender: TObject);
var
  filename, filecontent: SockString;
begin
  filename := 'up.7z';
  filecontent := StringFromFile(ExtractFilePath(Application.ExeName) + filename);
  rest.UpFile(filename, filecontent);
end;

end.

