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
  tl := TimeLogNow; //��ȡ��ǰʱ��
  tlb.Value := tl;  //����TimelogBits��ֵ
  tlb.FromNow; //�ϲ�
  Writeln(tlb.Text(True, ' '));
  Writeln(tlb.Text(False,' '));
//  tlb.ToUnixTime //���Է����ת��Ϊunixtime

  //mORMot֧��timezoneȡʱ�� ���԰���ͬʱ��ȥȡ
  time := TSynTimeZone.Default.NowToLocal('Asia/Shanghai');  //timezoneid �Լ���
  Writeln(DateTimeToStr(time));
  //����ʱ����Ҫ�Լ��½�ʱ����
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

