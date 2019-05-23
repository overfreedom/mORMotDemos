/// <author>cxg</author>

unit uCmd;

interface

const
  sMYSQL = 'mysql';
  sORACLE = 'oracle';
  sMSSQL = 'mssql';

const
  sQUERY_SQL = 'query';
  sEXECUTE_SQL = 'execute';
  sAUTHENTICATION_USER = 'authentication';
  sQUIT = 'quit';
  sDOWN_FILE = 'down';
  sUP_FILE = 'up';

const
  iUserOrPasswordError = 405;  // User or password error
  iNoAuthentication = 406;     // No authentication
  iInvalidRequest = 407;       // Invalid request
  iExecuteSqlErr = 408;        // Execute sql error
  iQuerySqlErr = 409;          // Query sql error
//  iFileNotExists = 410;        // file not exists

implementation

end.
