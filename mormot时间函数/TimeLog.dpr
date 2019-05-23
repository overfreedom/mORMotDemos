program TimeLog;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  SynCommons;

procedure TimeLogFunctionTest;
var
  tl: TTimeLog;
  tlb: TTimeLogBits;
  time: TDateTime;
begin
  tl := TimeLogNow; //获取当前时间
  tlb.Value := tl;  //设置TimelogBits的值
  tlb.FromNow; //合并
  Writeln(tlb.Text(True, ' '));
  Writeln(tlb.Text(False,' '));
//  tlb.ToUnixTime //可以方便的转换为unixtime

  //mORMot支持timezone取时间 可以按不同时区去取
  time := TSynTimeZone.Default.NowToLocal('Asia/Shanghai');  //timezoneid 自己查
  Writeln(DateTimeToStr(time));
  //其它时区的要自己新建时区？
//  time := TSynTimeZone.Default.NowToLocal('America/New_York');
//  Writeln(DateTimeToStr(time));
end;

begin
  try
    TimeLogFunctionTest;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

