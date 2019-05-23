program ynserver;

uses
  FastMM4,
  Forms,
  umain in 'umain.pas' {fmain},
  uCmd in '..\common\uCmd.pas',
  uMsSql in 'uMsSql.pas',
  uoracle in 'uOracle.pas',
  SynOleDB in 'SynOleDB.pas',
  uAuthentication in 'uAuthentication.pas',
  uDBServer in 'uDBServer.pas',
  uMYSQL in 'uMYSQL.pas',
  uHTTPSSYS in 'uHTTPSSYS.pas',
  uIntf in '..\common\uIntf.pas',
  uWebsocket in 'uWebsocket.pas',
  uLog in 'uLog.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfmain, fmain);
  Application.Run;
end.
