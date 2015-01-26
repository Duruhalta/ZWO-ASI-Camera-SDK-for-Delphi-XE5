//------------------------------------------------------------------------------
//  ZWOpctical ASI camera library demo convert to Delphi XE5
//
//  Contributor:
//    Youngjae Ha (sbrngm@gmail.com)
//    http://sbrngm.tistory.com
//
//  Last update : 2015-01-26
//
//  OpenCV Version : 2.4.9
//  OpenCV : http://opencv.org
//  Delphi-OpenCV : git://github.com/Laex/Delphi-OpenCV.git
//

unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ASICamera2, Vcl.StdCtrls, ocv.highgui_c, ocv.core_c,
  ocv.core.types_c, ocv.imgproc_c, ocv.imgproc.types_c, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.ExtDlgs;

{$DEFINE DEBUG_MODE}

//------------------------------------------------------------------------------

const
  MAX_CAM_COUNT     = 10;
  MAX_CAM_CONTROLS  = 13;

//------------------------------------------------------------------------------

const
  TH_MESSAGE  = WM_USER + 1991; // custom thread message
  TH_FINISHED = 1;              // thread sub message

//------------------------------------------------------------------------------

type
  TCamStatus = (csClosed, csOpened, csCapturing);

type
  PASIControlCapsArray = ^TASIControlCapsArray;
  TASIControlCapsArray = array[0..Pred(MAXWORD)] of TASI_CONTROL_CAPS;

type
  TCameraInfo = record
    CamThreadHwnd   : THandle;
    CamThreadId     : Cardinal;
    CamStatus       : TCamStatus;
    CtrlNum         : Integer;
    Index           : Integer;
    ControlCaps     : array[0..Pred(MAX_CAM_CONTROLS)] of TASI_CONTROL_CAPS;
    ASICameraInfo   : TASI_CAMERA_INFO;
    RefreshedIndex  : array[0..Pred(MAX_CAM_CONTROLS)] of BOOL;
    IsTestGood      : BOOL;
    IsThreadWorking : BOOL;
  end;

type
  TResolution = record
    Width,
    Height: Integer;
  end;

//------------------------------------------------------------------------------

const
  ASI_CAMERA_NAME: array[0..14] of string = (
    'FX2DVK', 'BootLoader', 'ASI120MM-SC', 'ASI120MM', 'ASI120MM-S',
    'ASI120MC', 'ASI130MM', 'ASI035MC', 'ASI035MM', 'ASI030MC',
    'ASI034MC', 'ASI120MC-S', 'ASI120MC-SC', 'ASI136MC', 'ASI136MM'
  );

const
  CAM_RESOLUTION: array[0..4] of TResolution = (
    (Width: 640; Height:480),
    (Width:1280; Height:960),
    (Width: 960; Height:960),
    (Width: 480; Height:480),
    (Width:1280; Height:720)
  );

//------------------------------------------------------------------------------

type
  TMainForm = class(TForm)
    StartButton: TButton;
    LogMemo: TMemo;
    Label1: TLabel;
    CameraComboBox: TComboBox;
    RescanButton: TButton;
    OpenButton: TButton;
    CloseButton: TButton;
    CloseAllButton: TButton;
    Label2: TLabel;
    ResolutionLabel: TLabel;
    SubDarkCheckBox: TCheckBox;
    CameraTypeLabel: TLabel;
    ROIWidthEdit: TEdit;
    Label3: TLabel;
    ROIHeightEdit: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    ImgTypeComboBox: TComboBox;
    Label6: TLabel;
    BINComboBox: TComboBox;
    SetFormatButton: TButton;
    Label7: TLabel;
    StartPosXEdit: TEdit;
    Label8: TLabel;
    StartPosYEdit: TEdit;
    SetStartPosButton: TButton;
    StopButton: TButton;
    StopAllButton: TButton;
    Label9: TLabel;
    GainTrackBar: TTrackBar;
    GainLabel: TLabel;
    GainEdit: TEdit;
    GainCheckBox: TCheckBox;
    ExposureEdit: TEdit;
    ExposureCheckBox: TCheckBox;
    ExposureLabel: TLabel;
    ExposureTrackBar: TTrackBar;
    GammaEdit: TEdit;
    GammaCheckBox: TCheckBox;
    GammaLabel: TLabel;
    GammaTrackBar: TTrackBar;
    WB_REdit: TEdit;
    WB_RCheckBox: TCheckBox;
    WBRLabel: TLabel;
    WB_RTrackBar: TTrackBar;
    WB_BEdit: TEdit;
    WB_BCheckBox: TCheckBox;
    WBBLabel: TLabel;
    WB_BTrackBar: TTrackBar;
    BrightnessEdit: TEdit;
    BrightnessCheckBox: TCheckBox;
    BrightnessLabel: TLabel;
    BrightnessTrackBar: TTrackBar;
    BandWidthEdit: TEdit;
    BandWidthCheckBox: TCheckBox;
    BandWidthLabel: TLabel;
    BandWidthTrackBar: TTrackBar;
    TemperatureEdit: TEdit;
    TempLabel: TLabel;
    TemperatureTrackBar: TTrackBar;
    FlipEdit: TEdit;
    FlipLabel: TLabel;
    FlipTrackBar: TTrackBar;
    AutoExpMaxGainEdit: TEdit;
    AutoExpMaxGainLabel: TLabel;
    AutoExpMaxGainTrackBar: TTrackBar;
    AutoExpMaxExpEdit: TEdit;
    AutoExpMaxExpLabel: TLabel;
    AutoExpMaxExpTrackBar: TTrackBar;
    AutoExpMaxBrightEdit: TEdit;
    AutoExpMaxBrightLabel: TLabel;
    AutoExpMaxBrightTrackBar: TTrackBar;
    StatusTimer: TTimer;
    TempCheckBox: TCheckBox;
    FlipCheckBox: TCheckBox;
    AutoExpMaxGainCheckBox: TCheckBox;
    AutoExpMaxExpCheckBox: TCheckBox;
    AutoExpMaxBrightCheckBox: TCheckBox;
    OpenPictureDialog: TOpenPictureDialog;
    CaptureInfoLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RescanButtonClick(Sender: TObject);
    procedure OpenButtonClick(Sender: TObject);
    procedure SetFormatButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CloseAllButtonClick(Sender: TObject);
    procedure SetStartPosButtonClick(Sender: TObject);
    procedure StatusTimerTimer(Sender: TObject);
    procedure CameraComboBoxChange(Sender: TObject);
    procedure GainTrackBarChange(Sender: TObject);
    procedure GainEditKeyPress(Sender: TObject; var Key: Char);
    procedure GainCheckBoxClick(Sender: TObject);
    procedure SubDarkCheckBoxClick(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure StopAllButtonClick(Sender: TObject);
  private
	  m_iWidth: Integer;
	  m_iHeight: Integer;
	  m_iStartX: Integer;
	  m_iStartY: Integer;
	  m_iROIWidth: Integer;
	  m_iROIHeight: Integer;
	  m_ctrlMin: Integer;
	  m_ctrlMax: Integer;
	  m_curPos: Integer;
	  m_fTemp: Single;
	  m_ST4time: Integer;
	  m_bFlipY: BOOL;
	  m_bFlipX: BOOL;
    iAllControlNum: Integer;
	  iTestindex: Integer;
    m_ImgTypeArray: array[0..63] of Integer;
    m_CtrlArray: array[0..63] of Integer;
    m_BinArray: array[0..63] of Integer;
  protected
    bThreadCall: BOOL;
    m_strCameraType: string;
  public
    procedure InitVariables();
    procedure RefreshInfoCtrl();
    procedure DeletepControlCaps(ACamIndex: Integer);
    procedure MallocControlCaps(ACamindex: Integer);
    procedure ChangeButtonAppearence(AStatus: TCamStatus);
    procedure DrawControl(ANumOfCtrl: Integer);
    procedure GetControlObject(AIndex: Integer; var ALabelObj: TLabel; var ATrackObj: TWinControl; var AEditObj: TWinControl; var ACheckObj: TWinControl);
    procedure RefreshSliderEdit(ATrackObj, AEditObj: TWinControl; ACtrlType: Integer; AValue: Longint);
    procedure EnableControl(AIndex: Integer; AIsAuto: Integer; AIsWriteable: Integer);
    procedure EditSetValue(AIndex: Integer; AEditObj, ATrackObj: TWinControl);
    procedure TrackSetValue(AIndex: Integer; AEditObj, ATrackObj: TWinControl);
    procedure SetAuto(AIndex: Integer);
  public
    iCamIndex: Integer;
    ConnectCamera: array[0..9] of TCameraInfo;
    procedure GetConnectedCameraList();
    procedure WaitDisplayThreadExit(AThreadHwnd: THandle);
    procedure DisplayThreadMessage(var Message: TMessage); message TH_MESSAGE;
  end;

//------------------------------------------------------------------------------

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

//------------------------------------------------------------------------------

const
  MAX_CONTROL = 7;

const
  BAYER: array[0..3] of string = ('RG', 'BG', 'GR', 'GB');
  CAMERA_CONTROLS: array[0..6] of string = ('Exposure', 'Gain', 'Gamma', 'WB_R', 'WB_B', 'Brightness', 'USB Traffic');

//------------------------------------------------------------------------------

procedure WriteLog(const AValue: string);
begin
  MainForm.LogMemo.Lines.Add(AValue);
end;

//------------------------------------------------------------------------------

procedure ForceThreadKill(AThreadHwnd: THandle);
var
  dwExitCode: DWORD;
begin
	GetExitCodeThread(AThreadHwnd, dwExitCode);
	if (STILL_ACTIVE = dwExitCode) then
		TerminateThread(AThreadHwnd, 0);
end;

{ TMainForm}

//------------------------------------------------------------------------------

procedure TMainForm.InitVariables();
var
  I: Integer;
begin
  m_iWidth := 0;
  m_iHeight := 0;
  m_iStartX := 0;
  m_iStartY := 0;
  m_iROIWidth := 0;
  m_iROIHeight := 0;
  m_ctrlMin := 0;
  m_ctrlMax := 0;
  m_curPos := 0;
  m_fTemp := 0.0;
  m_ST4time := 0;
  m_bFlipY := FALSE;
  m_bFlipX := FALSE;
  iCamIndex := -1;
  iTestindex := -1;
  iAllControlNum := MAX_CAM_CONTROLS;
  ZeroMemory(@m_ImgTypeArray[0], sizeof(Integer) * 64);
  ZeroMemory(@m_CtrlArray[0], sizeof(Integer) * 64);
  ZeroMemory(@m_BinArray[0], sizeof(Integer) * 64);

  for I := 0 to 9 do
  begin
    ConnectCamera[I].CamThreadHwnd := 0;
    ConnectCamera[I].CamThreadId := 0;
    ConnectCamera[I].CamStatus := csClosed;
    ConnectCamera[I].CtrlNum := -1;
    ConnectCamera[I].Index := -1;
    ZeroMemory(@ConnectCamera[I].ControlCaps[0], sizeof(TASI_CONTROL_CAPS) * MAX_CAM_COUNT);
    ZeroMemory(@ConnectCamera[I].ASICameraInfo, sizeof(TASI_CAMERA_INFO));
    ZeroMemory(@ConnectCamera[I].RefreshedIndex[0], sizeof(BOOL) * MAX_CAM_COUNT);
    ConnectCamera[I].IsTestGood := FALSE;
    ConnectCamera[I].IsThreadWorking := FALSE;
  end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.RefreshInfoCtrl();
var
  I: Integer;
  Count: Integer;
	Bin: Integer;
  bDark: BOOL;
  strBMPPath: AnsiString;
	imgType: Integer; //ASI_IMG_TYPE
begin
  if (ConnectCamera[iCamIndex].CamStatus <> csClosed) then
  begin
		m_iHeight := ConnectCamera[iCamIndex].ASICameraInfo.MaxHeight;
		m_iWidth  := ConnectCamera[iCamIndex].ASICameraInfo.MaxWidth;
    ImgTypeComboBox.Items.Clear();

    I := 0; Count := 0;
    while (ConnectCamera[iCamIndex].ASICameraInfo.SupportedVideoFormat[I] <> ASI_IMG_END) do
    begin
      case ConnectCamera[iCamIndex].ASICameraInfo.SupportedVideoFormat[I] of
        ASI_IMG_RAW8:
        begin
          ImgTypeComboBox.Items.Add('RAW8');
          m_ImgTypeArray[Count] := ASI_IMG_RAW8;
        end;
        ASI_IMG_RGB24:
        begin
          ImgTypeComboBox.Items.Add('RGB24');
          m_ImgTypeArray[Count] := ASI_IMG_RGB24;
        end;
        ASI_IMG_RAW16:
        begin
          ImgTypeComboBox.Items.Add('RAW16');
          m_ImgTypeArray[Count] := ASI_IMG_RAW16;
        end;
        ASI_IMG_Y8:
        begin
          ImgTypeComboBox.Items.Add('Y8');
          m_ImgTypeArray[Count] := ASI_IMG_Y8;
        end;
      end;
      Inc(I); Inc(Count);
    end;

		i := 0;
		BinComboBox.Items.Clear();
		while (ConnectCamera[iCamIndex].ASICameraInfo.SupportedBins[i] <> 0) do
		begin
      BinComboBox.Items.Add(IntToStr(ConnectCamera[iCamIndex].ASICameraInfo.SupportedBins[i]));
			m_BinArray[i] := ConnectCamera[iCamIndex].ASICameraInfo.SupportedBins[i];
			Inc(I);
		end;

    ASIGetROIFormat(iCamIndex, m_iROIWidth, m_iROIHeight, Bin, imgType);
    ROIWidthEdit.Text := IntToStr(m_iROIWidth);
    ROIHeightEdit.Text := IntToStr(m_iROIHeight);
    ResolutionLabel.Caption := Format('%d x %d', [m_iROIWidth, m_iROIHeight]);

    ImgTypeComboBox.ItemIndex := 0;
    BinComboBox.ItemIndex := 0;

    for I := 0 to ImgTypeComboBox.Items.Count-1 do
    begin
			if(m_ImgTypeArray[I] = imgType) then
        ImgTypeComboBox.ItemIndex := I;
    end;

    for I := 0 to BinComboBox.Items.Count-1 do
    begin
      if (m_BinArray[I] = Bin) then
        BinComboBox.ItemIndex := I;
    end;

    ASIGetStartPos(iCamIndex, m_iStartX, m_iStartY);
    StartPosXEdit.Text := IntToStr(m_iStartX);
    StartPosYEdit.Text := IntToStr(m_iStartY);

		if(ConnectCamera[iCamIndex].ASICameraInfo.IsColorCam = ASI_TRUE) then
			m_strCameraType := 'Color Camera'
		else
			m_strCameraType := 'Mono Camera';
    CameraTypeLabel.Caption := m_strCameraType;

    bDark := FALSE;
    strBMPPath := '';
    ASIEnableDarkSubtract(iCamIndex, PAnsiChar(strBmpPath), bDark);
    SubDarkCheckBox.Checked := bDark;
  end
	else
	begin
		m_iHeight := 0;
		m_iWidth := 0;
		m_iStartY := 0;
		m_iStartX := 0;
		m_iROIHeight := 0;
		m_iROIWidth := 0;
    ImgTypeComboBox.Items.Clear();
    ImgTypeComboBox.Text := '';
    ImgTypeComboBox.ItemIndex := -1;
    BinComboBox.Items.Clear();
    BinComboBox.Text := '';
    BinComboBox.ItemIndex := -1;
    SubDarkCheckBox.Checked := FALSE;

    CameraTypeLabel.Caption := '';
    StartPosXEdit.Text := '';
    StartPosYEdit.Text := '';
    ROIWidthEdit.Text := '';
    ROIHeightEdit.Text := '';
    ResolutionLabel.Caption := '0 x 0';
  end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.DeletepControlCaps(ACamIndex: Integer);
begin
  ZeroMemory(@ConnectCamera[ACamIndex].ControlCaps[0], sizeof(TASI_CONTROL_CAPS) * MAX_CAM_COUNT);
  ZeroMemory(@ConnectCamera[ACamIndex].RefreshedIndex[0], sizeof(BOOL) * MAX_CAM_COUNT);
end;

//------------------------------------------------------------------------------

procedure TMainForm.MallocControlCaps(ACamindex: Integer);
var
  I: Integer;
begin
  for I := 0 to ConnectCamera[ACamindex].CtrlNum-1 do
    ASIGetControlCaps(ACamindex, I, @ConnectCamera[ACamindex].ControlCaps[I]);
end;

//------------------------------------------------------------------------------

procedure TMainForm.ChangeButtonAppearence(AStatus: TCamStatus);
var
  I: Integer;
begin
  case AStatus of
    csClosed:
    begin
      OpenButton.Enabled := TRUE;
      CloseButton.Enabled := FALSE;
      CloseAllButton.Enabled := FALSE;
      SetFormatButton.Enabled := FALSE;
      SetStartPosButton.Enabled := FALSE;
      StartButton.Enabled := FALSE;
      StopButton.Enabled := FALSE;
      StopAllButton.Enabled := FALSE;

      for I := 0 to MAX_CAM_COUNT-1 do
      begin
        if (ConnectCamera[I].CamStatus = csCapturing) then
          StopAllButton.Enabled := TRUE;
        if (ConnectCamera[I].CamStatus <> csClosed) then
          CloseAllButton.Enabled := TRUE;
      end;
    end;
    csOpened:
    begin
      OpenButton.Enabled := FALSE;
      CloseButton.Enabled := TRUE;
      CloseAllButton.Enabled := TRUE;
      SetFormatButton.Enabled := TRUE;
      SetStartPosButton.Enabled := TRUE;
      StartButton.Enabled := TRUE;
      StopButton.Enabled := FALSE;
      StopAllButton.Enabled := FALSE;

      for I := 0 to MAX_CAM_COUNT-1 do
      begin
        if (ConnectCamera[I].CamStatus = csCapturing) then
          StopAllButton.Enabled := TRUE;
      end;
    end;
    csCapturing:
    begin
      OpenButton.Enabled := FALSE;
      CloseButton.Enabled := TRUE;
      CloseAllButton.Enabled := TRUE;

      SetFormatButton.Enabled := FALSE;
      SetStartPosButton.Enabled := TRUE;

      StartButton.Enabled := FALSE;
      StopButton.Enabled := TRUE;
      StopAllButton.Enabled := TRUE;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.DrawControl(ANumOfCtrl: Integer);
var
  I: Integer;
  LabelObj: TLabel;
  EditObj, TrackObj, AutoObj: TWinControl;
  ControlValue: Longint;
  IsAuto: Integer;
begin
  IsAuto := 0;

	if ((ConnectCamera[iCamIndex].CamStatus = csOpened) or (ConnectCamera[iCamIndex].CamStatus = csCapturing)) then
  begin
    for I := 0 to iAllControlNum-1 do
    begin
      GetControlObject(I, LabelObj, TrackObj, EditObj, AutoObj);
      if ((LabelObj = nil) or (TrackObj = nil) or (AutoObj = nil)) then Continue;

      if (I < ANumOfCtrl) then
      begin
        LabelObj.Caption := string(ConnectCamera[iCamIndex].ControlCaps[I].Name);
        if (I = ASI_EXPOSURE) then
        begin
          // Set Exposure : MIN = 1ms, MAX = 1000ms (this program is just demo.)
          TTrackBar(TrackObj).Min := 1000;
          TTrackBar(TrackObj).Max := 1000000;
        end else
        begin
          TTrackBar(TrackObj).Min := ConnectCamera[iCamIndex].ControlCaps[I].MinValue;
          TTrackBar(TrackObj).Max := ConnectCamera[iCamIndex].ControlCaps[I].MaxValue;
        end;
        if (AutoObj <> nil) then
          TCheckBox(AutoObj).Enabled := (ConnectCamera[iCamIndex].ControlCaps[I].IsAutoSupported = 1);

        ASIGetControlValue(iCamIndex, ConnectCamera[iCamIndex].ControlCaps[I].ControlID, ControlValue, IsAuto);
        RefreshSliderEdit(TrackObj, EditObj, ConnectCamera[iCamIndex].ControlCaps[I].ControlType, ControlValue);

        if ((IsAuto <> 0) or (ConnectCamera[iCamIndex].ControlCaps[I].IsWritable = ASI_FALSE)) then
          ConnectCamera[iCamIndex].RefreshedIndex[I] := TRUE
        else
          ConnectCamera[iCamIndex].RefreshedIndex[I] := FALSE;

        EnableControl(I, IsAuto, ConnectCamera[iCamIndex].ControlCaps[I].IsWritable);
      end else
      begin
        TTrackBar(TrackObj).Enabled := FALSE;
        TTrackBar(TrackObj).Position := 0;
        TEdit(EditObj).Enabled := FALSE;
        TEdit(EditObj).Text := '';
        TCheckBox(AutoObj).Enabled := FALSE;
        TCheckBox(AutoObj).Checked := FALSE;
        LabelObj.Enabled := FALSE;
      end;
    end;
  end else
  begin
    for I := 0 to ANumOfCtrl-1 do
    begin
      GetControlObject(I, LabelObj, TrackObj, EditObj, AutoObj);
      if ((LabelObj = nil) or (TrackObj = nil) or (AutoObj = nil)) then Continue;

      LabelObj.Caption := '';

      TTrackBar(TrackObj).Min := 0;
      TTrackBar(TrackObj).Max := 100;
      TTrackBar(TrackObj).Position := 0;
      TTrackBar(TrackObj).Enabled := FALSE;

      TEdit(EditObj).Text := '';
      TEdit(EditObj).Enabled := FALSE;

      TCheckBox(AutoObj).Checked := FALSE;
      TCheckBox(AutoObj).Enabled := FALSE;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.GetControlObject(AIndex: Integer; var ALabelObj: TLabel; var ATrackObj: TWinControl; var AEditObj: TWinControl; var ACheckObj: TWinControl);
begin
  case AIndex of
    0:
    begin
      ALabelObj := GainLabel;
      ATrackObj := GainTrackBar;
      AEditObj := GainEdit;
      ACheckObj := GainCheckBox;
    end;
    1:
    begin
      ALabelObj := ExposureLabel;
      ATrackObj := ExposureTrackBar;
      AEditObj := ExposureEdit;
      ACheckObj := ExposureCheckBox;
    end;
    2:
    begin
      ALabelObj := GammaLabel;
      ATrackObj := GammaTrackBar;
      AEditObj := GammaEdit;
      ACheckObj := GammaCheckBox;
    end;
    3:
    begin
      ALabelObj := WBRLabel;
      ATrackObj := WB_RTrackBar;
      AEditObj := WB_REdit;
      ACheckObj := WB_RCheckBox;
    end;
    4:
    begin
      ALabelObj := WBBLabel;
      ATrackObj := WB_BTrackBar;
      AEditObj := WB_BEdit;
      ACheckObj := WB_BCheckBox;
    end;
    5:
    begin
      ALabelObj := BrightnessLabel;
      ATrackObj := BrightnessTrackBar;
      AEditObj := BrightnessEdit;
      ACheckObj := BrightnessCheckBox;
    end;
    6:
    begin
      ALabelObj := BandWidthLabel;
      ATrackObj := BandWidthTrackBar;
      AEditObj := BandWidthEdit;
      ACheckObj := BandWidthCheckBox;
    end;
    7:
    begin
      ALabelObj := TempLabel;
      ATrackObj := TemperatureTrackBar;
      AEditObj := TemperatureEdit;
      ACheckObj := TempCheckBox;
    end;
    8:
    begin
      ALabelObj := FlipLabel;
      ATrackObj := FlipTrackBar;
      AEditObj := FlipEdit;
      ACheckObj := FlipCheckBox;
    end;
    9:
    begin
      ALabelObj := AutoExpMaxGainLabel;
      ATrackObj := AutoExpMaxGainTrackBar;
      AEditObj := AutoExpMaxGainEdit;
      ACheckObj := AutoExpMaxGainCheckBox;
    end;
    10:
    begin
      ALabelObj := AutoExpMaxExpLabel;
      ATrackObj := AutoExpMaxExpTrackBar;
      AEditObj := AutoExpMaxExpEdit;
      ACheckObj := AutoExpMaxExpCheckBox;
    end;
    11:
    begin
      ALabelObj := AutoExpMaxBrightLabel;
      ATrackObj := AutoExpMaxBrightTrackBar;
      AEditObj := AutoExpMaxBrightEdit;
      ACheckObj := AutoExpMaxBrightCheckBox;
    end;
  else
    ALabelObj := nil;
    ATrackObj := nil;
    AEditObj := nil;
    ACheckObj := nil;
  end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.RefreshSliderEdit(ATrackObj, AEditObj: TWinControl;
  ACtrlType: Integer; AValue: Longint);
begin
	if (ACtrlType = ASI_TEMPERATURE) then
	begin
    TTrackBar(ATrackObj).Position := Trunc(AValue / 10);
    TEdit(AEditObj).Text := Format('%.1f', [AValue / 10]);
  end else
  if (ACtrlType = ASI_EXPOSURE) then
  begin
    TTrackBar(ATrackObj).Position := AValue;
    TEdit(AEditObj).Text := Format('%.6f', [AValue / 1.0E+6]);
  end else
  begin
    TTrackBar(ATrackObj).Position := AValue;
    TEdit(AEditObj).Text := IntToStr(AValue);
	end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.EnableControl(AIndex, AIsAuto, AIsWriteable: Integer);
var
  LabelObj: TLabel;
  EditObj, TrackObj, CheckObj: TWinControl;
begin
  GetControlObject(AIndex, LabelObj, TrackObj, EditObj, CheckObj);
  if ((LabelObj = nil) or (TrackObj = nil) or (CheckObj = nil)) then Exit;

  LabelObj.Enabled := TRUE;
  if ((AIsAuto > 0) or (AIsWriteable = 0)) then
  begin
    ConnectCamera[iCamIndex].RefreshedIndex[AIndex] := TRUE;
    TTrackBar(TrackObj).Enabled := FALSE;
    TEdit(EditObj).Enabled := FALSE;
  end
  else
  begin
		ConnectCamera[iCamIndex].RefreshedIndex[AIndex] := FALSE;
    TTrackBar(TrackObj).Enabled := TRUE;
    TEdit(EditObj).Enabled := TRUE;
  end;

  if (AIsAuto > 0) then
    TCheckBox(CheckObj).Checked := TRUE
  else
    TCheckBox(CheckObj).Checked := FALSE;
end;

//------------------------------------------------------------------------------

procedure TMainForm.EditSetValue(AIndex: Integer; AEditObj, ATrackObj: TWinControl);
var
  lValue: Longint;
begin
  if ((AEditObj = nil) or (ATrackObj = nil)) then Exit;

  if (AIndex = ASI_EXPOSURE) then
    lValue := Trunc(StrToFloat(TEdit(AEditObj).Text) * 1.0E+6)
  else
    lValue := StrToIntDef(TEdit(AEditObj).Text, 0);

  ASISetControlValue(iCamIndex, AIndex, lValue, ASI_FALSE);
  TTrackBar(ATrackObj).Position := lValue;
end;

//------------------------------------------------------------------------------

procedure TMainForm.TrackSetValue(AIndex: Integer; AEditObj,
  ATrackObj: TWinControl);
var
  lValue: Longint;
begin
  if ((AEditObj = nil) or (ATrackObj = nil)) then Exit;

  lValue := TTrackBar(ATrackObj).Position;
  ASISetControlValue(iCamIndex, AIndex, lValue, ASI_FALSE);

  if (AIndex = ASI_EXPOSURE) then
    TEdit(AEditObj).Text := Format('%.6f', [lValue / 1.0e+6])
  else
    TEdit(AEditObj).Text := IntToStr(lValue);
end;

//------------------------------------------------------------------------------

procedure TMainForm.SetAuto(AIndex: Integer);
var
  lValue: Longint;
  iControlID: Integer;
  bAuto: Integer;
  LabelObj: TLabel;
  EditObj, TrackObj, CheckObj: TWinControl;
begin
  lValue := 0;
  bAuto := ASI_FALSE;
  GetControlObject(AIndex, LabelObj, TrackObj, EditObj, CheckObj);

  iControlID := ConnectCamera[iCamIndex].ControlCaps[AIndex].ControlID;
  ASIGetControlValue(iCamIndex, iControlID, lValue, bAuto);

  if (TCheckBox(CheckObj).Checked) then
    bAuto := ASI_TRUE
  else
    bAuto := ASI_FALSE;

  ASISetControlValue(iCamIndex, iControlID, lValue, bAuto);
  EnableControl(AIndex, bAuto, ASI_TRUE);
end;

//------------------------------------------------------------------------------

procedure TMainForm.GetConnectedCameraList();
var
  I, Ret: Integer;
  iNumofConnectCameras: Integer;
begin
  for I := 0 to 9 do
  begin
    if (ConnectCamera[I].CamStatus <> csClosed) then
    begin
      MessageBox(Handle, 'Please close all camera first.', 'Error', MB_OK);
      Exit;
    end;
  end;

  InitVariables();

  iNumofConnectCameras := ASIGetNumOfConnectedCameras();
  if (iNumofConnectCameras <= 0) then
  begin
    MessageBox(Handle, 'No camera connected.', 'Info', MB_OK);
    Exit;
  end;

  CameraComboBox.ItemIndex := -1;
  CameraComboBox.Items.Clear();

  for I := 0 to iNumofConnectCameras-1 do
  begin
    Ret := ASIGetCameraProperty(@ConnectCamera[I].ASICameraInfo, I);
    if (ASI_SUCCESS <> Ret) then
    begin
      MessageBox(Handle, PWideChar(Format('ASIGetCameraProperty() : Return code %d', [Ret])), 'Error', MB_OK);
      CameraComboBox.Items.Clear();
      Exit;
    end;
    CameraComboBox.Items.Add(string(ConnectCamera[I].ASICameraInfo.Name));
  end;
  CameraComboBox.ItemIndex := 0;
end;

//------------------------------------------------------------------------------

procedure OnCvMouseMove(Event: Integer; X, Y, Flags: Integer; Param: Pointer); cdecl;
begin
  if (Event = CV_EVENT_LBUTTONDOWN) then
  begin
    MainForm.ChangeButtonAppearence(csCapturing);
    MainForm.RefreshInfoCtrl();
    Application.ProcessMessages();
  end;
end;

//------------------------------------------------------------------------------
// Display thread procedure

function DisplayThreadProcedure(AData: Pointer): Integer;
var
  ThreadCamIndex: Integer;
  DisplayWinName: AnsiString;
  Bin, ROI_Width, ROI_Height: Integer;
  Time1, Time2: DWORD;
  FrameCount: Integer;
  lBufSize: Longint;
  img_type: Integer;
  pRGBImg: PIplImage;
  iDropFrame: Integer;
begin
  WriteLog('Start display thread.');

  Result := 0;
  FrameCount := 0;

  ThreadCamIndex := MainForm.iCamIndex;
  DisplayWinName := AnsiString(MainForm.CameraComboBox.Text);
  cvNamedWindow(PAnsiChar(DisplayWinName), CV_WINDOW_AUTOSIZE);

  cvSetMouseCallback(PAnsiChar(DisplayWinName), OnCvMouseMove);

  ASIGetROIFormat(ThreadCamIndex, ROI_Width, ROI_Height, Bin, img_type);
  case img_type of
    ASI_IMG_Y8, ASI_IMG_RAW8:
    begin
      pRGBImg := cvCreateImage(cvSize(ROI_Width, ROI_Height), IPL_DEPTH_8U, 1);
      lBufSize := ROI_Width * ROI_Height;
    end;
    ASI_IMG_RGB24:
    begin
      pRGBImg := cvCreateImage(cvSize(ROI_Width, ROI_Height), IPL_DEPTH_8U, 3);
      lBufSize := ROI_Width * ROI_Height * 3;
    end;
    ASI_IMG_RAW16:
    begin
      pRGBImg := cvCreateImage(cvSize(ROI_Width, ROI_Height), IPL_DEPTH_16U, 1);
      lBufSize := ROI_Width * ROI_Height * 2;
    end;
  else
    PostMessage(MainForm.Handle, TH_MESSAGE, TH_FINISHED, GetCurrentThreadID());
    Exit;
  end;

  Time1 := GetTickCount();
  while (MainForm.ConnectCamera[ThreadCamIndex].CamStatus = csCapturing) do
  begin
		if (ASI_SUCCESS <> ASIGetVideoData(ThreadCamIndex, pRGBImg.imageData, lBufSize, -1)) then
    begin
      WriteLog('[Error] ASIGetVideoData() : Failed.');
      break;
    end;

    Inc(FrameCount);
    Time2 := GetTickCount();
    if ((Time2 - Time1) > 1000) then
    begin
      ASIGetDroppedFrames(ThreadCamIndex, iDropFrame);
      MainForm.CaptureInfoLabel.Caption := Format('FPS: %d, Dropped frames: %d', [FrameCount, iDropFrame]);
      FrameCount := 0;
      Time1 := GetTickCount();
    end;

    cvShowImage(PAnsiChar(DisplayWinName), pRGBImg);
    cvWaitKey(1);
  end;
	cvDestroyWindow(PAnsiChar(DisplayWinName));

  PostMessage(MainForm.Handle, TH_MESSAGE, TH_FINISHED, GetCurrentThreadID());

{$IFDEF DEBUG_MODE}
  WriteLog('Display thread terminated.');
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TMainForm.WaitDisplayThreadExit(AThreadHwnd: THandle);
var
  Ret: DWORD;
begin
  while TRUE do
  begin
    Ret := MsgWaitForMultipleObjects(1, AThreadHwnd, FALSE, INFINITE, QS_ALLINPUT);
    if (Ret = WAIT_OBJECT_0) then
      break
    else if (Ret = WAIT_FAILED) then
    begin
      if (ConnectCamera[iCamIndex].IsThreadWorking) then
      begin
        ForceThreadKill(AThreadHwnd);
{$IFDEF DEBUG_MODE}
        WriteLog('Display thread force killed.');
{$ENDIF}
        PostMessage(MainForm.Handle, TH_MESSAGE, TH_FINISHED, ConnectCamera[iCamIndex].CamThreadId);
      end;
      break;
    end else
      Application.ProcessMessages();
  end;
end;

//------------------------------------------------------------------------------
// Main form create

procedure TMainForm.FormCreate(Sender: TObject);
begin
  bThreadCall := FALSE;
  InitVariables();
end;

//------------------------------------------------------------------------------
// Main form show

procedure TMainForm.FormShow(Sender: TObject);
begin
  GetConnectedCameraList();
end;

//------------------------------------------------------------------------------
// Main form clsoe

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
	for I := 0 to MAX_CAM_COUNT-1 do
  begin
		if (ConnectCamera[I].CamStatus <> csClosed) then
		begin
			if (ConnectCamera[I].CamStatus = csCapturing) then
			begin
				ConnectCamera[I].CamStatus := csOpened;
				WaitDisplayThreadExit(ConnectCamera[iCamIndex].CamThreadHwnd);
			end;

			ConnectCamera[I].CamStatus := csClosed;
      // Wait for capture thread signaled.
      while (ConnectCamera[I].IsThreadWorking) do
      begin
        Application.ProcessMessages();
        sleep(1);
      end;
			ASICloseCamera(I);
			DeletepControlCaps(iCamIndex);
		end;
  end;
end;

//------------------------------------------------------------------------------
// Rescan button

procedure TMainForm.RescanButtonClick(Sender: TObject);
begin
  GetConnectedCameraList();
end;

//------------------------------------------------------------------------------
// Open button

procedure TMainForm.OpenButtonClick(Sender: TObject);
var
  nNumOfCtrl: Integer;
begin
  iCamIndex := CameraComboBox.ItemIndex;
  if (iCamIndex < 0) then Exit;

  if (iCamIndex >= MAX_CAM_COUNT) then
  begin
    MessageBox(Handle, PWideChar(Format('Can''t open cameras more than %d', [iCamIndex])), 'Error', MB_OK);
    Exit;
  end;

  if (ASI_SUCCESS <> ASIOpenCamera(iCamIndex)) then
  begin
    MessageBox(Handle, 'Reopen or open fail.', 'Error', MB_OK);
    Exit;
  end;

	ConnectCamera[iCamIndex].CamStatus := csOpened;
	ConnectCamera[iCamIndex].Index := iCamIndex;

  RefreshInfoCtrl();

  nNumOfCtrl := 0;
	if (ASI_SUCCESS <> ASIGetNumOfControls(iCamIndex, nNumOfCtrl)) then
  begin
    MessageBox(Handle, 'ASIGetNumOfControls() : Failed.', 'Error', MB_OK);
    Exit;
  end;
	ConnectCamera[iCamIndex].CtrlNum := nNumOfCtrl;

  DeletepControlCaps(iCamIndex);
  MallocControlCaps(iCamIndex);

  DrawControl(ConnectCamera[iCamIndex].CtrlNum);

	ChangeButtonAppearence(csOpened);
	SetFormatButtonClick(nil);

  WriteLog(Format('Camera open: %s', [CameraComboBox.Text]));
end;

//------------------------------------------------------------------------------
// Set format button

procedure TMainForm.SetFormatButtonClick(Sender: TObject);
var
  I: Integer;
  ASIError: Integer;
begin
  I := ImgTypeComboBox.ItemIndex;
  if (I = -1) then Exit;

  if (ConnectCamera[iCamIndex].CamStatus <> csClosed) then
  begin
    m_iROIWidth := StrToIntDef(ROIWidthEdit.Text, 640);
    m_iROIHeight := StrToIntDef(ROIHeightEdit.Text, 480);

    ASIError := ASISetROIFormat(iCamIndex, m_iROIWidth, m_iROIHeight, m_BinArray[BinComboBox.ItemIndex], m_ImgTypeArray[I]);
    if (ASI_SUCCESS <> ASIError)  then
		begin
			if (ASIError = ASI_ERROR_INVALID_SENQUENCE) then
				MessageBox(Handle, 'Stop capture first', 'Error', MB_OK)
			else
				MessageBox(Handle, 'Set format error', 'Error', MB_OK);
		end;
  end else
    WriteLog(Format('Set Format: Width: %d, Height %d, Image type: %s, Bin: %s', [m_iROIWidth, m_iROIHeight, ImgTypeComboBox.Text, BinComboBox.Text]));
end;

//------------------------------------------------------------------------------

procedure TMainForm.CloseButtonClick(Sender: TObject);
begin
  if (ConnectCamera[iCamIndex].CamStatus = csCapturing) then
  begin
    ConnectCamera[iCamIndex].CamStatus := csOpened;
    WaitDisplayThreadExit(ConnectCamera[iCamIndex].CamThreadHwnd);
  end;
  ConnectCamera[iCamIndex].CamStatus := csClosed;

  if (ASI_SUCCESS <> ASICloseCamera(iCamIndex)) then
    WriteLog('[Error] ASICloseCamera() : No camera connected or index value out of boundary.');

  DeletepControlCaps(iCamIndex);
  RefreshInfoCtrl();
  DrawControl(iAllControlNum);
  ChangeButtonAppearence(csClosed);

  WriteLog(Format('Camera close: %s', [CameraComboBox.Text]));
end;

//------------------------------------------------------------------------------

procedure TMainForm.CloseAllButtonClick(Sender: TObject);
var
  I: Integer;
begin
	for I := 0 to MAX_CAM_COUNT-1 do
  begin
    if (ConnectCamera[I].CamStatus <> csClosed) then
    begin
      if (ConnectCamera[I].CamStatus = csCapturing) then
      begin
        ConnectCamera[I].CamStatus := csOpened;
        WaitDisplayThreadExit(ConnectCamera[I].CamThreadHwnd);
      end;

      // Wait for capture thread signaled.
      while (ConnectCamera[I].IsThreadWorking) do
      begin
        Application.ProcessMessages();
        sleep(1);
      end;

			ConnectCamera[I].CamStatus := csClosed;
			ASICloseCamera(I);
			DeletepControlCaps(I);
    end;
  end;

	ChangeButtonAppearence(csClosed);
	RefreshInfoCtrl();
	DrawControl(iAllControlNum);

  WriteLog('Camera close all');
end;

//------------------------------------------------------------------------------
// Set Start Pos button

procedure TMainForm.SetStartPosButtonClick(Sender: TObject);
begin
  m_iStartX := StrToIntDef(StartPosXEdit.Text, 0);
  m_iStartY := StrToIntDef(StartPosYEdit.Text, 0);
  ASISetStartPos(iCamIndex, m_iStartX, m_iStartY);

  WriteLog(Format('Set start posision: X: %d, Y: %d', [m_iStartX, m_iStartY]));
end;

//------------------------------------------------------------------------------
// Status timer

procedure TMainForm.StatusTimerTimer(Sender: TObject);
var
  I: Integer;
  lValue: Longint;
  bAuto: Integer;
  LabelObj: TLabel;
  EditObj, TrackObj, CheckObj: TWinControl;
begin
	if ((iCamIndex > -1) and (ConnectCamera[iCamIndex].CamStatus <> csClosed)) then
  begin
    for I := 0 to ConnectCamera[iCamIndex].CtrlNum-1 do
    begin
      if (ConnectCamera[iCamIndex].RefreshedIndex[I]) then
      begin
        ASIGetControlValue(iCamIndex, ConnectCamera[iCamIndex].ControlCaps[I].ControlID, lValue, bAuto);
        GetControlObject(I, LabelObj, TrackObj, EditObj, CheckObj);
        RefreshSliderEdit(TrackObj, EditObj, ConnectCamera[iCamIndex].ControlCaps[i].ControlType, lValue);
      end;
    end;
	end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.CameraComboBoxChange(Sender: TObject);
begin
	iCamIndex := CameraComboBox.ItemIndex;
	if (iCamIndex = -1) then Exit;

  case ConnectCamera[iCamIndex].CamStatus of
    csOpened:
    begin
      ChangeButtonAppearence(csOpened);
      RefreshInfoCtrl();
      DrawControl(ConnectCamera[iCamIndex].CtrlNum);
    end;
    csClosed:
    begin
      ChangeButtonAppearence(csClosed);
      RefreshInfoCtrl();
      DrawControl(iAllControlNum);
    end;
    csCapturing:
    begin
      ChangeButtonAppearence(csCapturing);
      RefreshInfoCtrl();
      DrawControl(ConnectCamera[iCamIndex].CtrlNum);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.GainCheckBoxClick(Sender: TObject);
begin
  if (ConnectCamera[iCamIndex].CamStatus = csClosed) then Exit;
  SetAuto(TCheckBox(Sender).Tag);
end;

//------------------------------------------------------------------------------

procedure TMainForm.GainEditKeyPress(Sender: TObject; var Key: Char);
var
  LabelObj: TLabel;
  EditObj, TrackObj, CheckObj: TWinControl;
begin
  if (Key = #13) then
  begin
    GetControlObject(TEdit(Sender).Tag, LabelObj, TrackObj, EditObj, CheckObj);
    EditSetValue(TEdit(Sender).Tag, EditObj, TrackObj);
    Key := #0;
  end;
end;

//------------------------------------------------------------------------------

procedure TMainForm.GainTrackBarChange(Sender: TObject);
var
  LabelObj: TLabel;
  EditObj, TrackObj, CheckObj: TWinControl;
begin
  if (not TTrackBar(Sender).Focused) then Exit;
  GetControlObject(TTrackBar(Sender).Tag, LabelObj, TrackObj, EditObj, CheckObj);
  TrackSetValue(TTrackBar(Sender).Tag, EditObj, TrackObj);
end;

//------------------------------------------------------------------------------

procedure TMainForm.SubDarkCheckBoxClick(Sender: TObject);
var
  bDark: BOOL;
  DarkFileName: AnsiString;
begin
  if (SubDarkCheckBox.Checked) then
  begin
    if (not OpenPictureDialog.Execute(Handle)) then
    begin
      SubDarkCheckBox.Checked := FALSE;
      Exit;
    end;
    bDark := TRUE;
    DarkFileName := AnsiString(OpenPictureDialog.FileName);
    ASIEnableDarkSubtract(iCamIndex, PAnsiChar(DarkFileName), bDark);
  end else
    ASIDisableDarkSubtract(iCamIndex);
end;

//------------------------------------------------------------------------------
// Start capture button

procedure TMainForm.StartButtonClick(Sender: TObject);
var
  Ret: Integer;
begin
  if (iCamIndex < 0) then Exit;
  
  Ret := ASIStartVideoCapture(iCamIndex);
  if (ASI_SUCCESS <> Ret) then
  begin
    WriteLog(Format('[Error] ASIStartVideoCapture() : Return code %d', [Ret]));
    Exit;
  end;

  ConnectCamera[iCamIndex].CamStatus := csCapturing;
  // create display thread
  ConnectCamera[iCamIndex].CamThreadHwnd := BeginThread(nil, 0, @DisplayThreadProcedure, nil, 0, ConnectCamera[iCamIndex].CamThreadId);
  if (ConnectCamera[iCamIndex].CamThreadHwnd <> 0) then
  begin
    ConnectCamera[iCamIndex].IsThreadWorking := TRUE;
    ChangeButtonAppearence(csCapturing);
  end else
  begin
    WriteLog('[Error] Create Display thread failed.');
    ConnectCamera[iCamIndex].CamStatus := csOpened;
    ASIStopVideoCapture(iCamIndex);
  end;

  WriteLog('Start capture.');
end;

//------------------------------------------------------------------------------
// Stop button
procedure TMainForm.StopButtonClick(Sender: TObject);
begin
	ConnectCamera[iCamIndex].CamStatus := csOpened;
	WaitDisplayThreadExit(ConnectCamera[iCamIndex].CamThreadHwnd);
  WriteLog('Stop capture.');
end;

//------------------------------------------------------------------------------
// Stop all button

procedure TMainForm.StopAllButtonClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to MAX_CAM_COUNT-1 do
  begin
    if (ConnectCamera[I].CamStatus = csCapturing) then
    begin
      ConnectCamera[I].CamStatus := csOpened;
      WaitDisplayThreadExit(ConnectCamera[iCamIndex].CamThreadHwnd);
    end;
  end;
  ChangeButtonAppearence(csOpened);
  WriteLog('Stop capture all.');
end;

//------------------------------------------------------------------------------
// Display thread message handler

procedure TMainForm.DisplayThreadMessage(var Message: TMessage);
begin
  case Message.WParam of
    TH_FINISHED:
    begin
      if (ConnectCamera[iCamIndex].CamThreadId <> Cardinal(Message.LParam)) then Exit;
      CloseHandle(ConnectCamera[iCamIndex].CamThreadHwnd);

{$IFDEF DEBUG_MODE}
      WriteLog('Display thread finished.');
{$ENDIF}

      ASIStopVideoCapture(iCamIndex);

      CaptureInfoLabel.Caption := '';
      ConnectCamera[iCamIndex].CamThreadHwnd := 0;
      ConnectCamera[iCamIndex].CamThreadId := 0;
      ConnectCamera[iCamIndex].IsThreadWorking := FALSE;
      ChangeButtonAppearence(csOpened);
    end;
  end;
end;

end.
