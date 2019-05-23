/// <author>cxg 2017-12-20</author>
/// MYSQL数据库驱动
/// 要安装MYSQL ODBC驱动程序
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
    /// <param name="databaseIP">数据库IP</param>
    /// <param name="databaseName">数据库名称</param>
    /// <param name="User">用户</param>
    /// <param name="password">密码</param>
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

