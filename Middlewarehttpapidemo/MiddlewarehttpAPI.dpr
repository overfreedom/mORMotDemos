program MiddlewarehttpAPI;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  {$I SynDprUses.inc}
  System.SysUtils,
  SynCommons,
  SynZip,
  SynCrtSock,
  SynLog
  ;

type
  TRSDBMiddleWare = class
    protected
      fServer: THttpApiServer;
      function Process(Ctxt: THttpServerRequest): Cardinal;
   public
     constructor Create;
     destructor Destory;
  end;

var
  log: TSynLog;
{ TRSDBMiddleWare }

constructor TRSDBMiddleWare.Create;
begin
  fServer := THttpApiServer.Create(True);
  fServer.AddUrl('root','8011',False,'+',True);
  fServer.RegisterCompress(CompressDeflate);
  fServer.OnRequest := Process;
  fServer.Clone(9);
  fServer.Start;
end;

destructor TRSDBMiddleWare.Destory;
begin
  fServer.Shutdown;
  fServer.Free;
  inherited;
end;

function TRSDBMiddleWare.Process(Ctxt: THttpServerRequest): Cardinal;
begin
  Writeln(Ctxt.Method,' ', Ctxt.URL);

  Result := 404;
end;

begin

  with TRSDBMiddleWare.Create do
  try
    log := Tsynlog.create();
    log.Family().Level := [TSynLogInfo.sllinfo]; //需要记录的日志等级
    log.Family().CustomFileName := '日志记录';  //日志名称
    log.Family().DestinationPath := 'E:\mydemos\Middlewarehttpapidemo\Win32'; //日志存放路径
    log.Log(TSynLogInfo.sllinfo,'start rsdbmiddleware');
    log.Log(sllinfo,'what the hell');

    log.Flush(False);
    Readln;
  finally
    Free;
  end;
end.

