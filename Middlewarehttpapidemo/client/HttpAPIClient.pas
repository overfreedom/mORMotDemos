unit HttpAPIClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, SynCrtSock, SynCommons;

type
  pform = ^cform;
  cform = class of TForm1;
  TForm1 = class(TForm)
    idhtp1: TIdHTTP;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Fhcs: THttpClientSocket;
    name: string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  res :string;
begin
  res :=idhtp1.Get('http://localhost:8011/root');
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  Fhcs := OpenHttp('localhost','8011');
  Fhcs.Post('root','','');  //如果服务端设置了地址是localhost:8011/root 这种的 post和get的地址要填上root
  Fhcs.Get('root');
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  if Assigned(Fhcs) then
    FreeAndNil(Fhcs);
  Fhcs := OpenHttp('https//www.baidu.com');
//  Fhcs := OpenHttp('https://www.google.com/');
  //第一次可以，不会自动跳转 后面报 无法立即完成一个非阻挡性套接字
  ShowMessage(Fhcs.Get('').ToString);
  ShowMessage(Fhcs.Content);

end;

procedure TForm1.btn4Click(Sender: TObject);
type
  pstr = ^UnicodeString;
  ps = pstr;
var
  dyarry: TDynArray;
  da: TIntegerDynArray;
  dyarrayhash: TDynArrayHashed;
  tmp: Integer;
  syndic: TSynDictionary;
  tmpstr1,tmpstr2: string;
begin
  SetLength(da,5);
  da[0] := 1;
  da[1] := 2;
  da[2] := 3;
  dyarry.Init(TypeInfo(TIntegerdynArray), da);
  tmp := 10;
  dyarry.Add(tmp).ToString;

//  ShowMessage(IntToStr(PPtrInt(dyarry.ElemPtr(5))^));
//  ShowMessage(dyarry.SaveToJSON);

//  dyarrayhash.Init();
//  dyarrayhash.FindHashedForAdding();


  syndic := TSynDictionary.Create(TypeInfo(TPointerDynArray),TypeInfo(TPointerDynArray));
  tmpstr1:= 'hell';
  tmpstr2:= 'world';
  syndic.Add(tmpstr1,tmpstr2);
  tmpstr1 := 'form';
  syndic.Add(tmpstr1,Form1);

//  ShowMessage(pstring(syndic.FindValue(tmpstr1))^);

//  ShowMessage(pform(syndic.FindValue(tmpstr1))^^.name);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  name := 'test hell world';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if Assigned(Fhcs) then
    FreeAndNil(Fhcs);
end;

end.
