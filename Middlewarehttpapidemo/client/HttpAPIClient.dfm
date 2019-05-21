object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 242
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 72
    Top = 56
    Width = 75
    Height = 25
    Caption = #26041#24335'1'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 72
    Top = 120
    Width = 75
    Height = 25
    Caption = #26041#24335#20108
    TabOrder = 1
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 208
    Top = 120
    Width = 153
    Height = 25
    Caption = #23581#35797#29992#26469#35775#38382#30334#24230
    TabOrder = 2
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 72
    Top = 176
    Width = 75
    Height = 25
    Caption = 'dyhasharray'
    TabOrder = 3
    OnClick = btn4Click
  end
  object idhtp1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 24
    Top = 48
  end
end
