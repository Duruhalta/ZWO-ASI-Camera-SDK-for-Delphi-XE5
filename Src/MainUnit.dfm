object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'ASI Camera Demo'
  ClientHeight = 415
  ClientWidth = 861
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 42
    Height = 13
    Caption = 'Cameras'
  end
  object Label2: TLabel
    Left = 8
    Top = 43
    Width = 50
    Height = 13
    Caption = 'Resolution'
  end
  object ResolutionLabel: TLabel
    Left = 80
    Top = 43
    Width = 119
    Height = 13
    AutoSize = False
    Caption = '0 x 0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object CameraTypeLabel: TLabel
    Left = 80
    Top = 62
    Width = 119
    Height = 13
    AutoSize = False
  end
  object Label3: TLabel
    Left = 8
    Top = 93
    Width = 50
    Height = 13
    Caption = 'ROI Width'
  end
  object Label4: TLabel
    Left = 87
    Top = 93
    Width = 53
    Height = 13
    Caption = 'ROI Height'
  end
  object Label5: TLabel
    Left = 166
    Top = 93
    Width = 46
    Height = 13
    Caption = 'IMG Type'
  end
  object Label6: TLabel
    Left = 247
    Top = 93
    Width = 17
    Height = 13
    Caption = 'BIN'
  end
  object Label7: TLabel
    Left = 8
    Top = 144
    Width = 53
    Height = 13
    Caption = 'Start Pos X'
  end
  object Label8: TLabel
    Left = 154
    Top = 144
    Width = 53
    Height = 13
    Caption = 'Start Pos Y'
  end
  object Label9: TLabel
    Left = 8
    Top = 180
    Width = 17
    Height = 13
    Caption = 'Log'
  end
  object GainLabel: TLabel
    Left = 448
    Top = 11
    Width = 113
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ExposureLabel: TLabel
    Left = 448
    Top = 38
    Width = 113
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object GammaLabel: TLabel
    Left = 448
    Top = 64
    Width = 113
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Enabled = False
  end
  object WBRLabel: TLabel
    Left = 448
    Top = 96
    Width = 113
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Enabled = False
  end
  object WBBLabel: TLabel
    Left = 448
    Top = 122
    Width = 113
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Enabled = False
  end
  object BrightnessLabel: TLabel
    Left = 448
    Top = 148
    Width = 113
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Enabled = False
  end
  object BandWidthLabel: TLabel
    Left = 448
    Top = 180
    Width = 113
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Enabled = False
  end
  object TempLabel: TLabel
    Left = 448
    Top = 206
    Width = 113
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Enabled = False
  end
  object FlipLabel: TLabel
    Left = 448
    Top = 232
    Width = 113
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Enabled = False
  end
  object AutoExpMaxGainLabel: TLabel
    Left = 448
    Top = 266
    Width = 113
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Enabled = False
  end
  object AutoExpMaxExpLabel: TLabel
    Left = 448
    Top = 292
    Width = 113
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Enabled = False
  end
  object AutoExpMaxBrightLabel: TLabel
    Left = 448
    Top = 318
    Width = 113
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Enabled = False
  end
  object CaptureInfoLabel: TLabel
    Left = 82
    Top = 180
    Width = 344
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
  end
  object StartButton: TButton
    Left = 448
    Top = 363
    Width = 145
    Height = 44
    Caption = 'Start Capture'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 37
    OnClick = StartButtonClick
  end
  object LogMemo: TMemo
    Left = 8
    Top = 199
    Width = 418
    Height = 208
    ImeName = 'Microsoft IME 2010'
    ScrollBars = ssVertical
    TabOrder = 36
  end
  object CameraComboBox: TComboBox
    Left = 56
    Top = 8
    Width = 145
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 0
    OnChange = CameraComboBoxChange
  end
  object RescanButton: TButton
    Left = 205
    Top = 7
    Width = 75
    Height = 23
    Caption = 'Rescan'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = RescanButtonClick
  end
  object OpenButton: TButton
    Left = 335
    Top = 7
    Width = 91
    Height = 23
    Caption = 'Open'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = OpenButtonClick
  end
  object CloseButton: TButton
    Left = 335
    Top = 36
    Width = 91
    Height = 23
    Caption = 'Close'
    Enabled = False
    TabOrder = 3
    OnClick = CloseButtonClick
  end
  object CloseAllButton: TButton
    Left = 335
    Top = 65
    Width = 91
    Height = 23
    Caption = 'Close All'
    Enabled = False
    TabOrder = 4
    OnClick = CloseAllButtonClick
  end
  object SubDarkCheckBox: TCheckBox
    Left = 205
    Top = 42
    Width = 75
    Height = 17
    TabStop = False
    Caption = 'Sub Drak'
    TabOrder = 40
    OnClick = SubDarkCheckBoxClick
  end
  object ROIWidthEdit: TEdit
    Left = 8
    Top = 112
    Width = 73
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 5
  end
  object ROIHeightEdit: TEdit
    Tag = 1
    Left = 87
    Top = 112
    Width = 73
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 6
  end
  object ImgTypeComboBox: TComboBox
    Left = 166
    Top = 112
    Width = 75
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 7
  end
  object BINComboBox: TComboBox
    Left = 247
    Top = 112
    Width = 75
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 8
  end
  object SetFormatButton: TButton
    Left = 335
    Top = 111
    Width = 91
    Height = 23
    Caption = 'Set Format'
    Enabled = False
    TabOrder = 9
    OnClick = SetFormatButtonClick
  end
  object StartPosXEdit: TEdit
    Left = 72
    Top = 141
    Width = 62
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 10
    Text = '0'
  end
  object StartPosYEdit: TEdit
    Left = 218
    Top = 141
    Width = 62
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 11
    Text = '0'
  end
  object SetStartPosButton: TButton
    Left = 335
    Top = 140
    Width = 91
    Height = 23
    Caption = 'Set Start Pos'
    Enabled = False
    TabOrder = 12
    OnClick = SetStartPosButtonClick
  end
  object StopButton: TButton
    Left = 617
    Top = 363
    Width = 115
    Height = 44
    Caption = 'Stop Capture'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 38
    OnClick = StopButtonClick
  end
  object StopAllButton: TButton
    Left = 738
    Top = 363
    Width = 115
    Height = 44
    Caption = 'Stop All'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 39
    OnClick = StopAllButtonClick
  end
  object GainTrackBar: TTrackBar
    Left = 566
    Top = 5
    Width = 161
    Height = 24
    Enabled = False
    ShowSelRange = False
    TabOrder = 13
    TickStyle = tsNone
    OnChange = GainTrackBarChange
  end
  object GainEdit: TEdit
    Left = 733
    Top = 8
    Width = 62
    Height = 21
    Enabled = False
    ImeName = 'Microsoft IME 2010'
    TabOrder = 14
    OnKeyPress = GainEditKeyPress
  end
  object GainCheckBox: TCheckBox
    Left = 801
    Top = 10
    Width = 51
    Height = 17
    TabStop = False
    Caption = 'Auto'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 41
    OnClick = GainCheckBoxClick
  end
  object ExposureEdit: TEdit
    Tag = 1
    Left = 733
    Top = 35
    Width = 62
    Height = 21
    Enabled = False
    ImeName = 'Microsoft IME 2010'
    TabOrder = 15
    OnKeyPress = GainEditKeyPress
  end
  object ExposureCheckBox: TCheckBox
    Tag = 1
    Left = 801
    Top = 37
    Width = 51
    Height = 17
    TabStop = False
    Caption = 'Auto'
    Enabled = False
    TabOrder = 42
    OnClick = GainCheckBoxClick
  end
  object ExposureTrackBar: TTrackBar
    Tag = 1
    Left = 566
    Top = 32
    Width = 161
    Height = 24
    Enabled = False
    LineSize = 500
    Frequency = 10
    ShowSelRange = False
    TabOrder = 43
    TickStyle = tsNone
    OnChange = GainTrackBarChange
  end
  object GammaEdit: TEdit
    Tag = 2
    Left = 733
    Top = 62
    Width = 62
    Height = 21
    Enabled = False
    ImeName = 'Microsoft IME 2010'
    TabOrder = 17
    OnKeyPress = GainEditKeyPress
  end
  object GammaCheckBox: TCheckBox
    Tag = 2
    Left = 801
    Top = 63
    Width = 51
    Height = 17
    TabStop = False
    Caption = 'Auto'
    Enabled = False
    TabOrder = 44
    OnClick = GainCheckBoxClick
  end
  object GammaTrackBar: TTrackBar
    Tag = 2
    Left = 566
    Top = 58
    Width = 161
    Height = 24
    Enabled = False
    ShowSelRange = False
    TabOrder = 16
    TickStyle = tsNone
    OnChange = GainTrackBarChange
  end
  object WB_REdit: TEdit
    Tag = 3
    Left = 733
    Top = 94
    Width = 62
    Height = 21
    Enabled = False
    ImeName = 'Microsoft IME 2010'
    TabOrder = 19
    OnKeyPress = GainEditKeyPress
  end
  object WB_RCheckBox: TCheckBox
    Tag = 3
    Left = 801
    Top = 95
    Width = 51
    Height = 17
    TabStop = False
    Caption = 'Auto'
    Enabled = False
    TabOrder = 45
    OnClick = GainCheckBoxClick
  end
  object WB_RTrackBar: TTrackBar
    Tag = 3
    Left = 566
    Top = 90
    Width = 161
    Height = 24
    Enabled = False
    ShowSelRange = False
    TabOrder = 18
    TickStyle = tsNone
    OnChange = GainTrackBarChange
  end
  object WB_BEdit: TEdit
    Tag = 4
    Left = 733
    Top = 120
    Width = 62
    Height = 21
    Enabled = False
    ImeName = 'Microsoft IME 2010'
    TabOrder = 21
    OnKeyPress = GainEditKeyPress
  end
  object WB_BCheckBox: TCheckBox
    Tag = 4
    Left = 801
    Top = 121
    Width = 51
    Height = 17
    TabStop = False
    Caption = 'Auto'
    Enabled = False
    TabOrder = 46
    OnClick = GainCheckBoxClick
  end
  object WB_BTrackBar: TTrackBar
    Tag = 4
    Left = 566
    Top = 116
    Width = 161
    Height = 24
    Enabled = False
    ShowSelRange = False
    TabOrder = 20
    TickStyle = tsNone
    OnChange = GainTrackBarChange
  end
  object BrightnessEdit: TEdit
    Tag = 5
    Left = 733
    Top = 146
    Width = 62
    Height = 21
    Enabled = False
    ImeName = 'Microsoft IME 2010'
    TabOrder = 23
    OnKeyPress = GainEditKeyPress
  end
  object BrightnessCheckBox: TCheckBox
    Tag = 5
    Left = 801
    Top = 147
    Width = 51
    Height = 17
    TabStop = False
    Caption = 'Auto'
    Enabled = False
    TabOrder = 47
    OnClick = GainCheckBoxClick
  end
  object BrightnessTrackBar: TTrackBar
    Tag = 5
    Left = 566
    Top = 142
    Width = 161
    Height = 24
    Enabled = False
    ShowSelRange = False
    TabOrder = 22
    TickStyle = tsNone
    OnChange = GainTrackBarChange
  end
  object BandWidthEdit: TEdit
    Tag = 6
    Left = 733
    Top = 178
    Width = 62
    Height = 21
    Enabled = False
    ImeName = 'Microsoft IME 2010'
    TabOrder = 25
    OnKeyPress = GainEditKeyPress
  end
  object BandWidthCheckBox: TCheckBox
    Tag = 6
    Left = 801
    Top = 179
    Width = 51
    Height = 17
    TabStop = False
    Caption = 'Auto'
    Enabled = False
    TabOrder = 48
    OnClick = GainCheckBoxClick
  end
  object BandWidthTrackBar: TTrackBar
    Tag = 6
    Left = 566
    Top = 174
    Width = 161
    Height = 24
    Enabled = False
    ShowSelRange = False
    TabOrder = 24
    TickStyle = tsNone
    OnChange = GainTrackBarChange
  end
  object TemperatureEdit: TEdit
    Tag = 7
    Left = 733
    Top = 204
    Width = 62
    Height = 21
    Enabled = False
    ImeName = 'Microsoft IME 2010'
    TabOrder = 27
  end
  object TemperatureTrackBar: TTrackBar
    Tag = 7
    Left = 566
    Top = 200
    Width = 161
    Height = 24
    Enabled = False
    ShowSelRange = False
    TabOrder = 26
    TickStyle = tsNone
  end
  object FlipEdit: TEdit
    Tag = 8
    Left = 733
    Top = 230
    Width = 62
    Height = 21
    Enabled = False
    ImeName = 'Microsoft IME 2010'
    TabOrder = 29
    OnKeyPress = GainEditKeyPress
  end
  object FlipTrackBar: TTrackBar
    Tag = 8
    Left = 566
    Top = 226
    Width = 161
    Height = 24
    Enabled = False
    ShowSelRange = False
    TabOrder = 28
    TickStyle = tsNone
    OnChange = GainTrackBarChange
  end
  object AutoExpMaxGainEdit: TEdit
    Tag = 9
    Left = 733
    Top = 264
    Width = 62
    Height = 21
    Enabled = False
    ImeName = 'Microsoft IME 2010'
    TabOrder = 31
    OnKeyPress = GainEditKeyPress
  end
  object AutoExpMaxGainTrackBar: TTrackBar
    Tag = 9
    Left = 566
    Top = 260
    Width = 161
    Height = 24
    Enabled = False
    ShowSelRange = False
    TabOrder = 30
    TickStyle = tsNone
    OnChange = GainTrackBarChange
  end
  object AutoExpMaxExpEdit: TEdit
    Tag = 10
    Left = 733
    Top = 290
    Width = 62
    Height = 21
    Enabled = False
    ImeName = 'Microsoft IME 2010'
    TabOrder = 33
    OnKeyPress = GainEditKeyPress
  end
  object AutoExpMaxExpTrackBar: TTrackBar
    Tag = 10
    Left = 566
    Top = 286
    Width = 161
    Height = 24
    Enabled = False
    ShowSelRange = False
    TabOrder = 32
    TickStyle = tsNone
    OnChange = GainTrackBarChange
  end
  object AutoExpMaxBrightEdit: TEdit
    Tag = 11
    Left = 733
    Top = 316
    Width = 62
    Height = 21
    Enabled = False
    ImeName = 'Microsoft IME 2010'
    TabOrder = 35
    OnKeyPress = GainEditKeyPress
  end
  object AutoExpMaxBrightTrackBar: TTrackBar
    Tag = 11
    Left = 566
    Top = 312
    Width = 161
    Height = 24
    Enabled = False
    ShowSelRange = False
    TabOrder = 34
    TickStyle = tsNone
    OnChange = GainTrackBarChange
  end
  object TempCheckBox: TCheckBox
    Tag = 7
    Left = 801
    Top = 207
    Width = 51
    Height = 17
    TabStop = False
    Caption = 'Auto'
    Enabled = False
    TabOrder = 49
    Visible = False
    OnClick = GainCheckBoxClick
  end
  object FlipCheckBox: TCheckBox
    Tag = 8
    Left = 802
    Top = 230
    Width = 51
    Height = 17
    TabStop = False
    Caption = 'Auto'
    Enabled = False
    TabOrder = 50
    Visible = False
    OnClick = GainCheckBoxClick
  end
  object AutoExpMaxGainCheckBox: TCheckBox
    Tag = 9
    Left = 802
    Top = 265
    Width = 51
    Height = 17
    TabStop = False
    Caption = 'Auto'
    Enabled = False
    TabOrder = 51
    Visible = False
    OnClick = GainCheckBoxClick
  end
  object AutoExpMaxExpCheckBox: TCheckBox
    Tag = 10
    Left = 801
    Top = 293
    Width = 51
    Height = 17
    TabStop = False
    Caption = 'Auto'
    Enabled = False
    TabOrder = 52
    Visible = False
    OnClick = GainCheckBoxClick
  end
  object AutoExpMaxBrightCheckBox: TCheckBox
    Tag = 11
    Left = 801
    Top = 316
    Width = 51
    Height = 17
    TabStop = False
    Caption = 'Auto'
    Enabled = False
    TabOrder = 53
    Visible = False
    OnClick = GainCheckBoxClick
  end
  object StatusTimer: TTimer
    OnTimer = StatusTimerTimer
    Left = 24
    Top = 216
  end
  object OpenPictureDialog: TOpenPictureDialog
    Left = 104
    Top = 216
  end
end
