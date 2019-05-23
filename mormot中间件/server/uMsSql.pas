/// <author>cxg 2017-12-20</author>
/// MSSQL���ݿ�����
/// TOleDBMSSQLConnectionProperties ����MSSQL���ݿ�Ĭ����ʹ��SQL SERVER NATIVE CLIENT 10
/// windows�ǰ�װSQL SERVER NATIVE CLIENT 10
/// TOleDBMSSQLConnectionProperties.Create(edtIP.Text, edtDatabase.Text, edtUser.Text, edtPassword.Text);

unit uMsSql;

interface

uses
  SysUtils, SynOleDB, SynCommons;

type
  TMsSql = class
  private
    fMSSql: TOleDBMSSQLConnectionProperties;
    FdatabaseIP, FdatabaseName, Fuser, Fpassword: RawUTF8;
  public
    /// <summary>
    /// 
    /// </summary>
    /// <param name="databaseIP">���ݿ�IP</param>
    /// <param name="databaseName">���ݿ�����</param>
    /// <param name="User">�û�</param>
    /// <param name="password">����</param>
    constructor Create(const databaseIP, databaseName, User, password: RawUTF8);
    destructor Destroy; override;
    property MSSQL: TOleDBMSSQLConnectionProperties read FMsSql;
  end;

implementation

{ TMsSql }

constructor TMsSql.Create(const databaseIP, databaseName, User,
  password: RawUTF8);
begin
  FdatabaseIP := databaseIP;
  FdatabaseName := databaseName;
  Fuser := User;
  Fpassword := password;
  fMSSql := TOleDBMSSQLConnectionProperties.Create(FdatabaseIP, FdatabaseName, Fuser, Fpassword);
end;

destructor TMsSql.Destroy;
begin
  fMSSql.ClearConnectionPool;
  fMSSql.Free;
  fMSSql := nil;
  
  inherited;
end;

end.

