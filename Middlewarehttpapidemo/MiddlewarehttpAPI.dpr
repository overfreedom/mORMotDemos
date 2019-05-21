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
    log.Family().Level := [TSynLogInfo.sllinfo]; //��Ҫ��¼����־�ȼ�
    log.Family().CustomFileName := '��־��¼';  //��־����
    log.Family().DestinationPath := 'E:\mydemos\Middlewarehttpapidemo\Win32'; //��־���·��
    log.Log(TSynLogInfo.sllinfo,'start rsdbmiddleware');
    log.Log(sllinfo,'what the hell');

    log.Flush(False);
    Readln;
  finally
    Free;
  end;
end.

