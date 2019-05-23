object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 374
  ClientWidth = 825
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 48
    Top = 104
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 48
    Top = 176
    Width = 75
    Height = 25
    Caption = 'btn2'
    TabOrder = 1
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 48
    Top = 240
    Width = 75
    Height = 25
    Caption = 'btn3'
    TabOrder = 2
    OnClick = btn3Click
  end
  object dbgrd1: TDBGrid
    Left = 184
    Top = 48
    Width = 505
    Height = 249
    DataSource = ds1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object fdqry1: TFDQuery
    SQL.Strings = (
      'SELECT * FROM AdminUser')
    Left = 64
    Top = 288
  end
  object ds1: TDataSource
    DataSet = fdqry1
    Left = 744
    Top = 224
  end
end
