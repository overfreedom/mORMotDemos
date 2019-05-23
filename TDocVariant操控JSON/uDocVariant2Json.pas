unit uDocVariant2Json;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,SynCommons;

type
  TForm1 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


//获取更多信息 请参考 https://synopse.info/files/html/Synopse%20mORMot%20Framework%20SAD%201.18.html#TITLE_39
procedure TForm1.btn1Click(Sender: TObject);
var
  json,doc: Variant;
begin
  TDocVariant.New(json);
  json.Name := 'hell';
  json.age := 18;
  TDocVariant.New(doc);
  doc.hightschool := 'huaqiao';
  doc.comment := '家里蹲';
  json.doc := doc;
  ShowMessage(json);
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  complicateJSON: Variant;
//复杂json构建
//{
//  "total": 300,
//  "url": "http:wap.abc.com",
//  "bizs": {
//    "biz": [
//      {
//        "id": 555555,
//        "name": "兰州烧饼",
//        "add": "北京市海定区中关村"
//      }，{
//        "id": 666666,
//        "name": "兰州拉面",
//        "add": "北京市海定区中关村"
//      },
//      {
//        "id": 888888,
//        "name": "肯德基",
//        "add": "北京市海定区中关村"
//      }
//    ]
//  }
//}
begin
//  _Obj() 创建json对象
//  _Arr() 创建json数组

  complicateJSON := _Obj(
   ['total',300,
    'url', 'http:wap.abc.com',
    'bizs', _Obj(
        ['biz', _Arr([
              _Obj(['id', 55555,
              'name', '兰州烧饼',
              'add', '北京市海定区中关村']),
              _Obj(['name', '兰州拉面',
                    'id', 666666,
                    'add','北京市海定区中关村'
                   ]),
              _Obj(['id', 888888,
                    'name', '肯德基',
                    'add', '北京市海定区中关村'])
              ])]
                )
    ]
  );

//  ShowMessage(complicateJSON);  隐式转换，速度较慢
  ShowMessage(VariantSaveJSON(complicateJSON));  //Variant转成string 速度快
  ShowMessage(complicateJSON._count);   //3个属性
  ShowMessage(complicateJSON._Kind);//  Ord(dvObject).ToString
//  ShowMessage(Ord(dvObject).ToString);

end;


procedure TForm1.btn3Click(Sender: TObject);
var
  jsonstr: string;
  jsonv,v1: Variant;
begin
  jsonstr :='{ '#13#10 +
            '  "total": 300, '#13#10 +
            '  "url": "http:wap.abc.com", '#13#10 +
            '  "bizs": { '#13#10 +
            '    "biz": [ '#13#10 +
            '      { '#13#10 +
            '        "id": 55555, '#13#10 +
            '        "name": "兰州烧饼", '#13#10 +
            '        "add": "北京市海定区中关村" '#13#10 +
            '      }, '#13#10 +
            '      { '#13#10 +
            '        "name": "兰州拉面", '#13#10 +
            '        "id": 666666, '#13#10 +
            '        "add": "北京市海定区中关村" '#13#10 +
            '      }, '#13#10 +
            '      { '#13#10 +
            '        "id": 888888, '#13#10 +
            '        "name": "肯德基", '#13#10 +
            '        "add": "北京市海定区中关村" '#13#10 +
            '      } '#13#10 +
            '    ] '#13#10 +
            '  } '#13#10 +
            '} ';

  jsonv := _JsonFast(StringToUTF8(jsonstr));
  if jsonv.Exists('bizs') then
    ShowMessage(jsonv.bizs.biz);

  if jsonv.bizs.Exists('name') then  //不存在
    ShowMessage('name');

   jsonv.delete('total');
   jsonv.add('newtal', '200');
   jsonv.url := 'www.baidu.com';
   ShowMessage(VariantSaveJSON(jsonv));

   //访问数组
   v1 := jsonv.bizs.biz;
   var str: string :='';
   var i: Integer;
   for i := 0 to v1._count -1 do
      str := str + VariantSaveJSON(v1.value(i))+ #10#13;

   ShowMessage(str);

end;

procedure TForm1.btn4Click(Sender: TObject);
var
  doc: TDocVariantData;
begin
  doc.Init;
  Assert(doc.kind=dvUndefined);
  doc.AddValue('name','john');

  Assert(doc.Kind=dvObject);
  Assert(doc.Value['name']='john');
  doc.U['last name'] := 'hello';
  Assert(doc.u['last name']='hello');

  ShowMessage(doc.ToJSON());
end;

end.

