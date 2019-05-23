/// <author>cxg 2017-12-20</author>
/// 基于HTTPS.SYS 的数据服务器
/// 使用二进制数据序列

unit uDBServer;

interface

uses
  SysUtils, SynCommons, SynDBRemote, SynDB;

type
  TDBServer = class
  private
    FDBServer: TSQLDBServerHttpApi;
    fServerName, fPort, fUser, fPassword: RawUTF8;
    fThreadnum: integer;
  public
    constructor Create(props: TSQLDBConnectionProperties; const serverName, port, user, password: RawUTF8; threadnum: integer);
    destructor Destroy; override;
    property DBServer: TSQLDBServerHttpApi read FDBServer;
  end;

implementation

{ TDBServer }

constructor TDBServer.Create(props: TSQLDBConnectionProperties;
  const serverName, port, user, password: RawUTF8; threadnum: integer);
begin
  fServerName := serverName;
  fPort := port;
  fUser := user;
  fPassword := password;
  fThreadnum := threadnum;

  fDBServer := TSQLDBServerHttpApi.Create(props, fServerName, fPort, fUser, fPassword, False, threadnum, nil, tmThreadPool);
end;

destructor TDBServer.Destroy;
begin
  FDBServer.Free;
  FDBServer := nil;

  inherited;
end;

end.

