program DocVariant2JSON;

uses
  Vcl.Forms,
  uDocVariant2Json in 'uDocVariant2Json.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
