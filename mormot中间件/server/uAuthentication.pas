/// <author>cxg 2017-12-20</author>
/// SESSION��֤

unit uAuthentication;

interface

uses
  SysUtils, SyncObjs, SynCommons, SynCrtSock;

type
  TAuthentication = class  ///��֤SESSION
  private
    sessions: TIntegerDynArray;
    sessionsCount: Integer;
    CS: TCriticalSection;
    FUser, FPassword: SockString;
    procedure lock;
    procedure unlock;
  public
    /// <summary>
    /// ������
    /// </summary>
    /// <param name="user">�û���</param>
    /// <param name="password">����</param>
    constructor Create(const user, password: SockString);
    destructor Destroy; override;
    /// <summary>
    /// ɾ��ָ��SESSION
    /// </summary>
    /// <param name="sessionid"></param>
    procedure RemoveSession(sessionid: integer);
    /// <summary>
    /// ����һ���µ�SESSION
    /// </summary>
    /// <param name="sessionid"></param>
    procedure CreateSession(sessionid: integer);
    /// <summary>
    /// SESSION�Ѿ���֤���ˣ�
    /// </summary>
    /// <param name="sessionid"></param>
    /// <returns>TRUE-SESSION��֤����</returns>
    function SessionExists(sessionid: integer): boolean;
    /// <summary>
    /// �˶��û���������
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
    i := FastFindIntegerSorted(pointer(Sessions), SessionsCount - 1, sessionid); // �ҵ����
    if i >= 0 then
      DeleteInteger(Sessions, SessionsCount, i); //�������ɾ��
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
 
