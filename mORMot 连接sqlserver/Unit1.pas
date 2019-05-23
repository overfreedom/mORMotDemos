unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, SynOleDB,
  SynDB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Datasnap.Provider;

type
  TForm1 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    fdqry1: TFDQuery;
    dbgrd1: TDBGrid;
    ds1: TDataSource;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  uBookModel, mORMot, mORMotDB, mORMotSQLite3, SynSQLite3Static, SynDBFireDAC;

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  pros: TOleDBMSSQL2012ConnectionProperties;
  model: TSQLModel;
  db: TSQLRestServer;
begin
  pros := TOleDBMSSQL2012ConnectionProperties.Create('localhost', 'ginfo_test', 'sa', '0000');
  model := CreateBookModel;
  VirtualTableExternalRegister(model, [TBookRecord], pros);
  db := TSQLRestServer.Create(model);
  db.CreateMissingTables;
end;


//ORM ´´½¨±í
procedure TForm1.btn2Click(Sender: TObject);
var
  pros: TOleDBMSSQLConnectionProperties;
  model: TSQLModel;
  db: TSQLRestServerDB;
  rec: TBookRecord;
begin
  pros := TOleDBMSSQLConnectionProperties.Create('.', 'ginfo_test', '', '');
  model := TSQLModel.Create([TBookRecord]);
  VirtualTableExternalRegister(model, [TBookRecord], pros);
  rec := TBookRecord.Create;
  rec.GetJSONValues();
  db := TSQLRestServerDB.Create(model, 'ginfo_test.db');
  db.CreateMissingTables;
end;

procedure TForm1.btn3Click(Sender: TObject);
var
  fdcon : TSQLDBFireDACConnection;
  fdconpro: TSQLDBFireDACConnectionProperties;

begin
  fdconpro := TSQLDBFireDACConnectionProperties.Create('.','ginfo_test','','');
  fdcon :=TSQLDBFireDACConnection.Create(fdconpro);
  fdcon.Connect;
//  fdqry1.Connection := fdcon;
//  fdqry1.Open;
end;

end.

