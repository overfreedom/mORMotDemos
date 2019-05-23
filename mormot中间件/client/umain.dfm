object fmain: Tfmain
  Left = 245
  Top = 146
  Width = 506
  Height = 365
  Caption = 'fmain'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 490
    Height = 326
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'rest'
      object Label1: TLabel
        Left = 10
        Top = 43
        Width = 18
        Height = 12
        Caption = 'ip:'
      end
      object Label3: TLabel
        Left = 125
        Top = 43
        Width = 30
        Height = 12
        Caption = 'port:'
      end
      object Label6: TLabel
        Left = 242
        Top = 43
        Width = 30
        Height = 12
        Caption = 'user:'
      end
      object Label7: TLabel
        Left = 357
        Top = 43
        Width = 30
        Height = 12
        Caption = #23494#30721':'
      end
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 482
        Height = 29
        ButtonHeight = 20
        ButtonWidth = 67
        Caption = 'ToolBar1'
        ShowCaptions = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 2
          Caption = 'querySQL'
          ImageIndex = 4
          OnClick = ToolButton1Click
        end
        object ToolButton2: TToolButton
          Left = 67
          Top = 2
          Caption = 'executeSQL'
          ImageIndex = 5
          OnClick = ToolButton2Click
        end
        object ToolButton3: TToolButton
          Left = 134
          Top = 2
          Caption = 'downFile'
          ImageIndex = 6
          OnClick = ToolButton3Click
        end
        object ToolButton6: TToolButton
          Left = 201
          Top = 2
          Caption = 'upFile'
          ImageIndex = 7
          OnClick = ToolButton6Click
        end
      end
      object DBGrid1: TDBGrid
        Left = 16
        Top = 72
        Width = 433
        Height = 217
        DataSource = DataSource1
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
      end
      object edtIP2: TEdit
        Left = 40
        Top = 40
        Width = 81
        Height = 20
        TabOrder = 2
        Text = 'localhost'
      end
      object edtPort: TEdit
        Left = 155
        Top = 40
        Width = 81
        Height = 20
        TabOrder = 3
        Text = '2006'
      end
      object edtUser8: TEdit
        Left = 272
        Top = 40
        Width = 81
        Height = 20
        TabOrder = 4
        Text = 'yn'
      end
      object edtPassword8: TEdit
        Left = 395
        Top = 40
        Width = 81
        Height = 20
        TabOrder = 5
        Text = 'yn'
      end
    end
    object TabSheet2: TTabSheet
      Caption = #20108#36827#21046
      ImageIndex = 1
      object Label2: TLabel
        Left = 8
        Top = 40
        Width = 54
        Height = 12
        Caption = #26381#21153#22120'ip:'
      end
      object TLabel
        Left = 176
        Top = 40
        Width = 54
        Height = 12
        Caption = #26381#21153#22120#21517':'
      end
      object Label4: TLabel
        Left = 8
        Top = 72
        Width = 30
        Height = 12
        Caption = #29992#25143':'
      end
      object Label5: TLabel
        Left = 200
        Top = 72
        Width = 30
        Height = 12
        Caption = #23494#30721':'
      end
      object ToolBar2: TToolBar
        Left = 0
        Top = 0
        Width = 482
        Height = 29
        ButtonHeight = 20
        ButtonWidth = 43
        Caption = 'ToolBar2'
        ShowCaptions = True
        TabOrder = 0
        object ToolButton4: TToolButton
          Left = 0
          Top = 2
          Caption = #26597'  '#35810
          ImageIndex = 0
          OnClick = ToolButton4Click
        end
        object ToolButton5: TToolButton
          Left = 43
          Top = 2
          Caption = #20445'  '#23384
          ImageIndex = 1
          OnClick = ToolButton5Click
        end
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 96
        Width = 449
        Height = 185
        DataSource = DataSource2
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
      end
      object edtIP: TEdit
        Left = 64
        Top = 36
        Width = 107
        Height = 20
        TabOrder = 2
        Text = '127.0.0.1:1954'
      end
      object edtServer: TEdit
        Left = 231
        Top = 36
        Width = 114
        Height = 20
        TabOrder = 3
        Text = 'yongnan'
      end
      object edtUser: TEdit
        Left = 56
        Top = 68
        Width = 121
        Height = 20
        TabOrder = 4
        Text = 'yn'
      end
      object edtPassword: TEdit
        Left = 248
        Top = 68
        Width = 121
        Height = 20
        TabOrder = 5
        Text = 'yn'
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'websocket'
      ImageIndex = 2
      object Label8: TLabel
        Left = 16
        Top = 16
        Width = 12
        Height = 12
        Caption = 'ip'
      end
      object Label9: TLabel
        Left = 176
        Top = 16
        Width = 24
        Height = 12
        Caption = 'port'
      end
      object Label10: TLabel
        Left = 16
        Top = 40
        Width = 18
        Height = 12
        Caption = 'key'
      end
      object Label11: TLabel
        Left = 176
        Top = 40
        Width = 36
        Height = 12
        Caption = #23458#25143#21495
      end
      object Memo1: TMemo
        Left = 8
        Top = 88
        Width = 449
        Height = 153
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
      end
      object Edit1: TEdit
        Left = 16
        Top = 256
        Width = 321
        Height = 20
        TabOrder = 1
      end
      object Button1: TButton
        Left = 360
        Top = 256
        Width = 75
        Height = 25
        Caption = #21457#36865
        TabOrder = 2
        OnClick = Button1Click
      end
      object edtIP11: TEdit
        Left = 40
        Top = 13
        Width = 121
        Height = 20
        TabOrder = 3
        Text = '127.0.0.1'
      end
      object edtPort11: TEdit
        Left = 200
        Top = 13
        Width = 121
        Height = 20
        TabOrder = 4
        Text = '1952'
      end
      object edtKey11: TEdit
        Left = 40
        Top = 37
        Width = 121
        Height = 20
        TabOrder = 5
        Text = '1952'
      end
      object edtConn11: TEdit
        Left = 200
        Top = 37
        Width = 121
        Height = 20
        TabOrder = 6
        Text = #23458#25143#19968
      end
    end
  end
  object DataSource1: TDataSource
    Left = 40
    Top = 136
  end
  object DataSource2: TDataSource
    Left = 84
    Top = 135
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 148
    Top = 135
  end
end
