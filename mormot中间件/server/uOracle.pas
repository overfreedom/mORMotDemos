/// <author>cxg 2017-12-20</author>
/// oracle数据库驱动
/// 部署只需要oci.dll and oraociei11.dll 两个文件
/// DELPHI 7等低版本只能识别32位的OCI
/// TSQLDBOracleConnectionProperties.Create('TNSNAMEALIAS','','USERId', 'mypassword');
/// 第二个参数database name不需要填写
/// 只要设置第一个参数sever name,可以设置TNSName in aServerName
/// 或者是一个连接字符串：//127.0.0.1:1521/orcl
                                                                                                             

unit uoracle;

interface

uses
  SysUtils, SynDBOracle, SynCommons, forms;

type
  Toracle = class
  private
    foracle: TSQLDBOracleConnectionProperties;
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
    property ORACLE: TSQLDBOracleConnectionProperties read foracle;
  end;

implementation

{ Toracle }

constructor Toracle.Create(const databaseIP, databaseName, User,
  password: RawUTF8);
begin
  FdatabaseIP := databaseIP;
  FdatabaseName := databaseName;
  Fuser := User;
  Fpassword := password;

  foracle := TSQLDBOracleConnectionProperties.Create(FdatabaseIP, FdatabaseName, Fuser, Fpassword);
end;

destructor Toracle.Destroy;
begin
  foracle.ClearConnectionPool;
  foracle.Free;
  foracle := nil;
  
  inherited;
end;

end.

