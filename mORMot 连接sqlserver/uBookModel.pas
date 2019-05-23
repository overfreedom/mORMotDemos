unit uBookModel;

interface

uses
  SynCommons,
  mORMot;

type
  TBookRecord = class(TSQLRecord)
  private
    FID: UInt64;
    Fbookname: RawUTF8;
    Fauthor: RawUTF8;
    Fcreatedate: TModTime;
  published
//    property ID: UInt64 read FID write FID;
    property bookname: RawUTF8 index 256 read Fbookname write Fbookname;
    property author: RawUTF8 index 64 read Fauthor write Fauthor;
    property createdate: TModTime read Fcreatedate write Fcreatedate;

  end;

function CreateBookModel: TSQLModel;

implementation

function CreateBookModel: TSQLModel;
begin
  Result := TSQLModel.Create([TBookRecord]);
end;
end.
