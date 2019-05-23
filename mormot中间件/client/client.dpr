program client;

uses
  FastMM4,
  Forms,
  umain in 'umain.pas' {fmain},
  ufun in 'ufun.pas',
  uCmd in '..\common\uCmd.pas',
  uIntf in '..\common\uIntf.pas',
  uWebSocket in '..\common\uWebSocket.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfmain, fmain);
  Application.Run;
end.
