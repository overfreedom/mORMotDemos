/// <author>cxg 2017-12-21</author>
/// websocket

unit uWebsocket;

interface

uses
  SysUtils,SynCommons,mORMot, SynBidirSock, mORMotHttpServer, uIntf;

type
  TChatService = class(TInterfacedObject, IChatService)
  protected
    fConnected: array of IChatCallback;
  public
    procedure Join(const connid: string; const callback: IChatCallback);
    procedure msg(const connid, msg: string);
    procedure CallbackReleased(const callback: IInvokable; const interfaceName: RawUTF8);
  end;

type
  TWebSocket = class
  private
    fPort, fKey: string;
    HttpServer: TSQLHttpServer;
    Server: TSQLRestServerFullMemory;
  public
    constructor Create(const port, key: string);
    destructor Destroy; override;
  end;

implementation


{ TWebSocket }


constructor TWebSocket.Create(const port, key: string);
begin
  fPort := port;
  fKey := key;
  
  Server := TSQLRestServerFullMemory.CreateWithOwnModel([]);
  Server.CreateMissingTables;
  Server.ServiceDefine(TChatService, [IChatService], sicShared).SetOptions([], [optExecLockedPerInterface]).ByPassAuthentication := true;

  HttpServer := TSQLHttpServer.Create(fPort, [Server], '+', useBidirSocket);
  HttpServer.WebSocketsEnable(Server, fKey).Settings.SetFullLog;
end;

destructor TWebSocket.Destroy;
begin
  HttpServer.Free;
  HttpServer := nil;
  Server.Free;
  Server := nil;

  inherited;
end;


{ TChatService }

procedure TChatService.CallbackReleased(const callback: IInvokable;
  const interfaceName: RawUTF8);
begin
  if interfaceName = 'IChatCallback' then
    InterfaceArrayDelete(fConnected, callback);
end;

procedure TChatService.Join(const connid: string;
  const callback: IChatCallback);
begin
  InterfaceArrayAdd(fConnected, callback);
end;

procedure TChatService.msg(const connid, msg: string);
var
  i: integer;
begin
  for i := high(fConnected) downto 0 do
  try
    fConnected[i].NotifyMsg(connid, '服务端回复:'+connid+'收到你的消息 '+msg);      // 应答消息
  except
    InterfaceArrayDelete(fConnected, i);
  end;
end;

end.
