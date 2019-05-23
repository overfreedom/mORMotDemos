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


//��ȡ������Ϣ ��ο� https://synopse.info/files/html/Synopse%20mORMot%20Framework%20SAD%201.18.html#TITLE_39
procedure TForm1.btn1Click(Sender: TObject);
var
  json,doc: Variant;
begin
  TDocVariant.New(json);
  json.Name := 'hell';
  json.age := 18;
  TDocVariant.New(doc);
  doc.hightschool := 'huaqiao';
  doc.comment := '�����';
  json.doc := doc;
  ShowMessage(json);
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  complicateJSON: Variant;
//����json����
//{
//  "total": 300,
//  "url": "http:wap.abc.com",
//  "bizs": {
//    "biz": [
//      {
//        "id": 555555,
//        "name": "�����ձ�",
//        "add": "�����к������йش�"
//      }��{
//        "id": 666666,
//        "name": "��������",
//        "add": "�����к������йش�"
//      },
//      {
//        "id": 888888,
//        "name": "�ϵ»�",
//        "add": "�����к������йش�"
//      }
//    ]
//  }
//}
begin
//  _Obj() ����json����
//  _Arr() ����json����

  complicateJSON := _Obj(
   ['total',300,
    'url', 'http:wap.abc.com',
    'bizs', _Obj(
        ['biz', _Arr([
              _Obj(['id', 55555,
              'name', '�����ձ�',
              'add', '�����к������йش�']),
              _Obj(['name', '��������',
                    'id', 666666,
                    'add','�����к������йش�'
                   ]),
              _Obj(['id', 888888,
                    'name', '�ϵ»�',
                    'add', '�����к������йش�'])
              ])]
                )
    ]
  );

//  ShowMessage(complicateJSON);  ��ʽת�����ٶȽ���
  ShowMessage(VariantSaveJSON(complicateJSON));  //Variantת��string �ٶȿ�
  ShowMessage(complicateJSON._count);   //3������
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
            '        "name": "�����ձ�", '#13#10 +
            '        "add": "�����к������йش�" '#13#10 +
            '      }, '#13#10 +
            '      { '#13#10 +
            '        "name": "��������", '#13#10 +
            '        "id": 666666, '#13#10 +
            '        "add": "�����к������йش�" '#13#10 +
            '      }, '#13#10 +
            '      { '#13#10 +
            '        "id": 888888, '#13#10 +
            '        "name": "�ϵ»�", '#13#10 +
            '        "add": "�����к������йش�" '#13#10 +
            '      } '#13#10 +
            '    ] '#13#10 +
            '  } '#13#10 +
            '} ';

  jsonv := _JsonFast(StringToUTF8(jsonstr));
  if jsonv.Exists('bizs') then
    ShowMessage(jsonv.bizs.biz);

  if jsonv.bizs.Exists('name') then  //������
    ShowMessage('name');

   jsonv.delete('total');
   jsonv.add('newtal', '200');
   jsonv.url := 'www.baidu.com';
   ShowMessage(VariantSaveJSON(jsonv));

   //��������
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

