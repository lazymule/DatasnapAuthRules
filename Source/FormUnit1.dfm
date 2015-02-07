object Form1: TForm1
  Left = 271
  Top = 114
  Caption = 'Form1'
  ClientHeight = 413
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 170
    Top = 13
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object ButtonStart: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 196
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '8079'
  end
  object ButtonOpenBrowser: TButton
    Left = 320
    Top = 8
    Width = 85
    Height = 25
    Caption = 'Open Browser'
    TabOrder = 3
    OnClick = ButtonOpenBrowserClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 39
    Width = 449
    Height = 366
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
  object Button1: TButton
    Left = 408
    Top = 8
    Width = 54
    Height = 25
    Caption = 'cls'
    TabOrder = 5
    OnClick = Button1Click
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 120
    Top = 68
  end
end
