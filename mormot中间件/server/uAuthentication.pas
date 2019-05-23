/// <author>cxg 2017-12-20</author>
/// SESSION验证

unit uAuthentication;

interface

uses
  SysUtils, SyncObjs, SynCommons, SynCrtSock;

type
  TAuthentication = class  ///验证SESSION
  private
    sessions: TIntegerDynArray;
    sessionsCount: Integer;
    CS: TCriticalSection;
    FUser, FPassword: SockString;
    procedure lock;
    procedure unlock;
  public
    /// <summary>
    /// 创建者
    /// </summary>
    /// <param name="user">用户名</param>
    /// <param name="password">密码</param>
    constructor Create(const user, password: SockString);
    destructor Destroy; override;
    /// <summary>
    /// 删除指定SESSION
    /// </summary>
    /// <param name="sessionid"></param>
    procedure RemoveSession(sessionid: integer);
    /// <summary>
    /// 创建一个新的SESSION
    /// </summary>
    /// <param name="sessionid"></param>
    procedure CreateSession(sessionid: integer);
    /// <summary>
    /// SESSION已经验证过了？
    /// </summary>
    /// <param name="sessionid"></param>
    /// <returns>TRUE-SESSION验证过了</returns>
    function SessionExists(sessionid: integer): boolean;
    /// <summary>
    /// 核对用户名和密码
    /// </summary>
    /// <param name="user"></param>
    /// <param name="password"></param>
    /// <returns></returns>
    function checkUser(const user, password: string): Boolean;
  end;

implementation

{ TAuthentication }

function TAuthentication.checkUser(const user, password: string): Boolean;
begin
  Result := (user = FUser) and (password = FPassword);
end;

constructor TAuthentication.Create(const user, password: SockString);
begin
  CS := TCriticalSection.Create;
  sessionsCount := 0;
  FUser := user;
  FPassword := password;
end;

procedure TAuthentication.CreateSession(sessionid: integer);
begin
  lock;
  try
    AddSortedInteger(Sessions, SessionsCount, sessionid);
  finally
    unlock;
  end;
end;

destructor TAuthentication.Destroy;
begin
  CS.Free;
  inherited;
end;

procedure TAuthentication.lock;
begin
  CS.Enter;
end;

procedure TAuthentication.RemoveSession(sessionid: integer);
var
  i: integer;
begin
  Lock;
  try
    i := FastFindIntegerSorted(pointer(Sessions), SessionsCount - 1, sessionid); // 找到序号
    if i >= 0 then
      DeleteInteger(Sessions, SessionsCount, i); //根据序号删除
  finally
    UnLock;
  end;
end;

function TAuthentication.SessionExists(sessionid: integer): boolean;
begin
  Lock;
  try
    result := FastFindIntegerSorted(pointer(Sessions), SessionsCount - 1, sessionid) >= 0;
  finally
    UnLock;
  end;
end;

procedure TAuthentication.unlock;
begin
  CS.Leave;
end;

end.
 
