object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'FrmMain'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 39
    Width = 75
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = '0'
  end
  object Label2: TLabel
    Left = 89
    Top = 39
    Width = 75
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = '0'
  end
  object Label3: TLabel
    Left = 170
    Top = 39
    Width = 75
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = '0'
  end
  object Label4: TLabel
    Left = 251
    Top = 39
    Width = 75
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = '0'
  end
  object Label5: TLabel
    Left = 332
    Top = 39
    Width = 75
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = '0'
  end
  object btnStart1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object btnStop1: TButton
    Left = 8
    Top = 60
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = btnStopClick
  end
  object btnStart2: TButton
    Tag = 1
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 2
    OnClick = btnStartClick
  end
  object btnStop2: TButton
    Tag = 1
    Left = 89
    Top = 60
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 3
    OnClick = btnStopClick
  end
  object btnStart3: TButton
    Tag = 2
    Left = 170
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 4
    OnClick = btnStartClick
  end
  object btnStop3: TButton
    Tag = 2
    Left = 170
    Top = 60
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 5
    OnClick = btnStopClick
  end
  object btnStart4: TButton
    Tag = 3
    Left = 251
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 6
    OnClick = btnStartClick
  end
  object btnStop4: TButton
    Tag = 3
    Left = 251
    Top = 60
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 7
    OnClick = btnStopClick
  end
  object btnStart5: TButton
    Tag = 4
    Left = 332
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 8
    OnClick = btnStartClick
  end
  object btnStop5: TButton
    Tag = 4
    Left = 332
    Top = 60
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 9
    OnClick = btnStopClick
  end
end
