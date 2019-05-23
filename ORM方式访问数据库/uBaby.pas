unit uBaby;

interface

uses
  SynCommons, mORMot;

type
  TSex = (sFemale, sMale);

  TSQLBaby = class(TSQLRecord)
  private
    fName: RawUTF8;
    fAddress: RawUTF8;
    fBirthDate: TDateTime;
    fSex: TSex;
  published
    property Name: RawUTF8 index 32 read fName write fName stored AS_UNIQUE;
    //sqlite�����������ݿ�û���ֶγ��ȵĿ��Բ�������
    //index 32 ���ڿ������ɵ�table��varchar�ֶδ�С  stored AS_UNIQUE (false) ���ڿ������ݿ�baby�ĸ����Ƿ�Ψһ
    //�����õ�ʱ�� sqlserver Ĭ��Ϊvarchar(max)

    property Address: RawUTF8 index 32 read fAddress write fAddress;
    property BirthDate: TDateTime read fBirthDate write fBirthDate;
    property Sex: TSex read fSex write fSex;
  end;

  TSQLDiaper = class(TSQLRecord)
  private
    fSerialNumber: RawUTF8;
//    fModel: TSQLDiaperModel;
    fBaby: TSQLBaby;
  published
    property SerialNumber: RawUTF8 index 30
        read fSerialNumber write fSerialNumber stored AS_UNIQUE;
//    property Model: TSQLDiaperModel read fModel write fModel;
    property Baby: TSQLBaby read fBaby write fBaby;
  end;

implementation

end.

