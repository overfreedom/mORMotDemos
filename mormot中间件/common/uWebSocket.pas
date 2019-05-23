/// <author>cxg 2017-12-21</author>
/// websocket

unit uWebSocket;

interface

uses
  SysUtils, SynCommons, mORMot, uIntf, mORMotHttpClient;

type
  TChatCallback = class(TInterfacedCallback, IChatCallback)
  protected
    procedure Notifymsg(const connid, msg: string);
  end;

type
  TWebSocket = class
  private
    fIP, fPort, fKey, fConnID: string;
    Client: TSQLHttpClientWebsockets;
    callback: IChatCallback;
  public
    Service: IChatService;
    
    constructor Create(const ip, port, key, connid: string);
    destructor Destroy; override;
  end;

var
  websocketMsg: string;

implementation

{ TChatCallback }

procedure TChatCallback.Notifymsg(const connid, msg: string);
begin
  websocketMsg:='';
  websocketMsg := msg;
end;

{ TWebSocket }

constructor TWebSocket.Create(const ip, port, key, connid: string);
begin
  fIP := ip;
  fPort := port;
  fkey := key;
  fConnID := connid;

  Client := TSQLHttpClientWebsockets.Create(fIP, fPort, TSQLModel.Create([]));
  Client.Model.Owner := Client;
  Client.WebSocketsUpgrade(fKey);
  if not Client.ServerTimeStampSynchronize then
    raise EServiceException.Create('Error connecting to the server: please run Server');
  Client.ServiceDefine([IChatService], sicShared);
  if not Client.Services.Resolve(IChatService, Service) then
    raise EServiceException.Create('Service IChatService unavailable');
  callback := TChatCallback.Create(Client, IChatCallback);
  Service.Join(fConnID, callback);
end;

destructor TWebSocket.Destroy;
begin
  callback := nil;
  Service:=nil;
  Client.Free;
  client:=nil;

  inherited;
end;

end.

