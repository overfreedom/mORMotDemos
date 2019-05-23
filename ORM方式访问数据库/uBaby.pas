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
    //sqlite或者其它数据库没有字段长度的可以不用设置
    //index 32 用于控制生成的table的varchar字段大小  stored AS_UNIQUE (false) 用于控制数据库baby的该列是否唯一
    //不设置的时候 sqlserver 默认为varchar(max)

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

