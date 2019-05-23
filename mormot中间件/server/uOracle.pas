/// <author>cxg 2017-12-20</author>
/// oracle���ݿ�����
/// ����ֻ��Ҫoci.dll and oraociei11.dll �����ļ�
/// DELPHI 7�ȵͰ汾ֻ��ʶ��32λ��OCI
/// TSQLDBOracleConnectionProperties.Create('TNSNAMEALIAS','','USERId', 'mypassword');
/// �ڶ�������database name����Ҫ��д
/// ֻҪ���õ�һ������sever name,��������TNSName in aServerName
/// ������һ�������ַ�����//127.0.0.1:1521/orcl
                                                                                                             

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
    /// <param name="databaseIP">���ݿ�IP</param>
    /// <param name="databaseName">���ݿ�����</param>
    /// <param name="User">�û�</param>
    /// <param name="password">����</param>
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

