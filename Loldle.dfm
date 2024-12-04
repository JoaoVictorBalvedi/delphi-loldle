object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 498
  ClientWidth = 891
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 96
    Top = 77
    Width = 194
    Height = 13
    Caption = 'Before guessing, sort the character --->'
  end
  object Label2: TLabel
    Left = 504
    Top = 61
    Width = 3
    Height = 13
  end
  object LabelPontuacao: TLabel
    Left = 552
    Top = 36
    Width = 161
    Height = 85
  end
  object Edit1: TEdit
    Left = 224
    Top = 184
    Width = 169
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 432
    Top = 173
    Width = 145
    Height = 43
    Caption = 'Guess'
    TabOrder = 1
    OnClick = Button1Click
  end
  object MLane: TMemo
    Left = 304
    Top = 312
    Width = 81
    Height = 65
    Lines.Strings = (
      'MLane')
    TabOrder = 2
  end
  object MRange: TMemo
    Left = 424
    Top = 312
    Width = 81
    Height = 65
    Lines.Strings = (
      'MRange')
    TabOrder = 3
  end
  object MRegion: TMemo
    Left = 656
    Top = 312
    Width = 81
    Height = 65
    Lines.Strings = (
      'MRegion')
    TabOrder = 4
  end
  object MResource: TMemo
    Left = 536
    Top = 312
    Width = 81
    Height = 65
    Lines.Strings = (
      'MResource')
    TabOrder = 5
  end
  object MRace: TMemo
    Left = 192
    Top = 312
    Width = 81
    Height = 65
    Lines.Strings = (
      'MRace')
    TabOrder = 6
  end
  object MSex: TMemo
    Left = 96
    Top = 312
    Width = 73
    Height = 65
    Lines.Strings = (
      'MSex')
    TabOrder = 7
  end
  object Button2: TButton
    Left = 336
    Top = 56
    Width = 145
    Height = 57
    Caption = 'Sort character'
    TabOrder = 8
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 743
    Top = 17
    Width = 147
    Height = 473
    Lines.Strings = (
      'Memo1')
    TabOrder = 9
  end
end
