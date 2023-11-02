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
  DesignSize = (
    628
    442)
  TextHeight = 15
  object lblOr: TLabel
    Left = 159
    Top = 12
    Width = 11
    Height = 15
    Caption = 'or'
  end
  object btnReadFromFile: TButton
    Left = 8
    Top = 8
    Width = 145
    Height = 25
    Caption = 'read text from file'
    TabOrder = 0
    OnClick = btnReadFromFileClick
  end
  object btnGenerateRandomText: TButton
    Left = 176
    Top = 8
    Width = 145
    Height = 25
    Caption = 'generate random text'
    TabOrder = 1
    OnClick = btnGenerateRandomTextClick
  end
  object memo: TMemo
    Left = 8
    Top = 39
    Width = 608
    Height = 89
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    ExplicitWidth = 604
  end
  object btnProcessText: TButton
    Left = 8
    Top = 134
    Width = 145
    Height = 25
    Caption = 'process the text'
    TabOrder = 3
    OnClick = btnProcessTextClick
  end
  object grid: TStringGrid
    Left = 8
    Top = 165
    Width = 608
    Height = 156
    Anchors = [akLeft, akTop, akRight]
    ColCount = 2
    DefaultColWidth = 145
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 4
    ExplicitWidth = 604
  end
end
