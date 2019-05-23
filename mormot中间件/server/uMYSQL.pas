/// <author>cxg 2017-12-20</author>
/// MYSQL���ݿ�����
/// Ҫ��װMYSQL ODBC��������
/// 

unit uMYSQL;

interface

uses
  SysUtils, SynOleDB, SynCommons;

type
  Tmysql = class
  private
    fMYSQL: TOleDBMySQLConnectionProperties;
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
    property MYSQL: TOleDBMySQLConnectionProperties read fMYSQL;
  end;

implementation

{ Tmysql }

constructor Tmysql.Create(const databaseIP, databaseName, User,
  password: RawUTF8);
begin
  FdatabaseIP := databaseIP;
  FdatabaseName := databaseName;
  Fuser := User;
  Fpassword := password;
  fMYSQL := TOleDBMySQLConnectionProperties.Create(FdatabaseIP, FdatabaseName, Fuser, Fpassword);
end;

destructor Tmysql.Destroy;
begin
  fMYSQL.ClearConnectionPool;
  fMYSQL.Free;
  fMYSQL := nil;
  
  inherited;
end;

end.

