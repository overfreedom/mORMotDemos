object fmain: Tfmain
  Left = 424
  Top = 205
  Width = 498
  Height = 283
  Caption = #21647#21335'HTTPS.SYS'#20013#38388#20214
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
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
    object btnStart: TToolButton
      Left = 0
      Top = 2
      Caption = #24320#21551#20013#38388#20214
      ImageIndex = 0
      OnClick = btnStartClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 29
    Width = 482
    Height = 215
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet2: TTabSheet
      Caption = #31471#21475#35774#32622
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 8
        Top = 0
        Width = 225
        Height = 137
        Caption = 'REST'#26381#21153#22120
        TabOrder = 0
        object Label1: TLabel
          Left = 12
          Top = 20
          Width = 60
          Height = 12
          Caption = #32447#31243#25968#37327#65306
        end
        object Label2: TLabel
          Left = 12
          Top = 46
          Width = 60
          Height = 12
          Caption = 'http'#31471#21475#65306
        end
        object Label3: TLabel
          Left = 9
          Top = 70
          Width = 66
          Height = 12
          Caption = 'https'#31471#21475#65306
        end
        object Label12: TLabel
          Left = 12
          Top = 94
          Width = 60
          Height = 12
          Caption = #39564#35777#29992#25143#65306
        end
        object Label13: TLabel
          Left = 9
          Top = 118
          Width = 60
          Height = 12
          Caption = #39564#35777#23494#30721#65306
        end
        object edtThreadNum: TEdit
          Left = 92
          Top = 17
          Width = 121
          Height = 20
          TabOrder = 0
          Text = '10'
        end
        object edtHttpPort: TEdit
          Left = 93
          Top = 41
          Width = 120
          Height = 20
          TabOrder = 1
          Text = '2006'
        end
        object edtHttpsPort: TEdit
          Left = 92
          Top = 65
          Width = 121
          Height = 20
          TabOrder = 2
          Text = '2010'
        end
        object edtUser8: TEdit
          Left = 93
          Top = 89
          Width = 120
          Height = 20
          TabOrder = 3
          Text = 'yn'
        end
        object edtPassword8: TEdit
          Left = 92
          Top = 113
          Width = 121
          Height = 20
          TabOrder = 4
          Text = 'yn'
        end
      end
      object GroupBox2: TGroupBox
        Left = 240
        Top = 0
        Width = 225
        Height = 137
        Caption = 'BIN'#26381#21153#22120
        TabOrder = 1
        object Label8: TLabel
          Left = 12
          Top = 22
          Width = 36
          Height = 12
          Caption = #31471#21475#65306
        end
        object Label9: TLabel
          Left = 5
          Top = 46
          Width = 60
          Height = 12
          Caption = #26381#21153#22120#21517#65306
        end
        object Label10: TLabel
          Left = 12
          Top = 70
          Width = 36
          Height = 12
          Caption = #29992#25143#65306
        end
        object Label11: TLabel
          Left = 12
          Top = 94
          Width = 36
          Height = 12
          Caption = #23494#30721#65306
        end
        object edtPort: TEdit
          Left = 65
          Top = 17
          Width = 120
          Height = 20
          TabOrder = 0
          Text = '1954'
        end
        object edtServer: TEdit
          Left = 65
          Top = 41
          Width = 120
          Height = 20
          TabOrder = 1
          Text = 'yongnan'
        end
        object edtUser2: TEdit
          Left = 65
          Top = 65
          Width = 120
          Height = 20
          TabOrder = 2
          Text = 'yn'
        end
        object edtPassword2: TEdit
          Left = 65
          Top = 89
          Width = 120
          Height = 20
          TabOrder = 3
          Text = 'yn'
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 138
        Width = 457
        Height = 47
        Caption = 'websocket'
        TabOrder = 2
        object Label15: TLabel
          Left = 12
          Top = 22
          Width = 36
          Height = 12
          Caption = #31471#21475#65306
        end
        object Label16: TLabel
          Left = 204
          Top = 22
          Width = 30
          Height = 12
          Caption = 'KEY'#65306
        end
        object edtPort9: TEdit
          Left = 65
          Top = 17
          Width = 120
          Height = 20
          TabOrder = 0
          Text = '1952'
        end
        object edtKey: TEdit
          Left = 257
          Top = 17
          Width = 120
          Height = 20
          TabOrder = 1
          Text = '1952'
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #25968#25454#24211
      ImageIndex = 2
      object Label4: TLabel
        Left = 32
        Top = 49
        Width = 60
        Height = 12
        Caption = #25968#25454#24211'IP'#65306
      end
      object Label5: TLabel
        Left = 32
        Top = 81
        Width = 48
        Height = 12
        Caption = #25968#25454#24211#65306
      end
      object Label6: TLabel
        Left = 32
        Top = 113
        Width = 48
        Height = 12
        Caption = #29992#25143#21517#65306
      end
      object Label7: TLabel
        Left = 32
        Top = 145
        Width = 36
        Height = 12
        Caption = #23494#30721#65306
      end
      object Label14: TLabel
        Left = 21
        Top = 17
        Width = 72
        Height = 12
        Caption = #25968#25454#24211#31867#22411#65306
      end
      object edtIP: TEdit
        Left = 96
        Top = 44
        Width = 297
        Height = 20
        TabOrder = 0
        Text = '127.0.0.1,8829'
      end
      object edtDatabase: TEdit
        Left = 96
        Top = 76
        Width = 297
        Height = 20
        TabOrder = 1
        Text = 'yndb'
      end
      object edtUser: TEdit
        Left = 96
        Top = 108
        Width = 297
        Height = 20
        TabOrder = 2
        Text = 'sa'
      end
      object edtPassword: TEdit
        Left = 96
        Top = 140
        Width = 297
        Height = 20
        TabOrder = 3
        Text = 'sa'
      end
      object cbDBType: TComboBox
        Left = 96
        Top = 16
        Width = 297
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 4
        Text = 'mssql'
        Items.Strings = (
          'mssql'
          'oracle'
          'mysql')
      end
    end
    object TabSheet1: TTabSheet
      Caption = #26085#24535
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 474
        Height = 188
        Align = alClient
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
end
