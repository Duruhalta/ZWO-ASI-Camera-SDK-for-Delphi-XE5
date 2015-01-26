//------------------------------------------------------------------------------
// ZWOpctical ASICamera2.h convert to Delphi XE5
//
//  Contributor:
//    Youngjae Ha (sbrngm@gmail.com)
//    http://sbrngm.tistory.com
//
// Last update : 2015-01-23
//

unit ASICamera2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes;

//------------------------------------------------------------------------------

// ASI Camera DLL
const
  ASICAMERA_API = 'ASICamera2.dll';

// ASI_BAYER_PATTERN
const
	ASI_BAYER_RG = 0;
	ASI_BAYER_BG = 1;
	ASI_BAYER_GR = 2;
	ASI_BAYER_GB = 3;

// ASI_IMG_TYPE (Supported Video Format)
const
	ASI_IMG_RAW8  = 0;
	ASI_IMG_RGB24 = 1;
	ASI_IMG_RAW16 = 2;
	ASI_IMG_Y8    = 3;
	ASI_IMG_END   = 4;

// ASI_GUIDE_DIRECTION (Guider Direction)
const
	ASI_GUIDE_NORTH = 0;
	ASI_GUIDE_SOUTH = 1;
	ASI_GUIDE_EAST  = 2;
	ASI_GUIDE_WEST  = 3;

// ASI_FLIP_STATUS
const
	ASI_FLIP_NONE   = 0;  // original
	ASI_FLIP_HORIZ  = 1;  // horizontal flip
	ASI_FLIP_VERT   = 2;  // vertical flip
	ASI_FLIP_BOTH   = 3;  // both horizontal and vertical flip

// ASI_ERROR_CODE
const
	ASI_SUCCESS                     =  0;
	ASI_ERROR_INVALID_INDEX         =  1; // no camera connected or index value out of boundary
	ASI_ERROR_INVALID_ID            =  2; // invalid ID
	ASI_ERROR_INVALID_CONTROL_ID    =  3; // invalid Control ID
	ASI_ERROR_CAMERA_CLOSED         =  4; // camera didn't open
	ASI_ERROR_CAMERA_REMOVED        =  5; // failed to find the camera, maybe the camera has been removed
	ASI_ERROR_INVALID_PATH          =  6; // cannot find the path of the file
	ASI_ERROR_INVALID_FILEFORMAT    =  7;
	ASI_ERROR_INVALID_SIZE          =  8; // wrong video format size
	ASI_ERROR_INVALID_IMGTYPE       =  9; // unsupported image formate
	ASI_ERROR_OUTOF_BOUNDARY        = 10; // the image is out of boundary
	ASI_ERROR_TIMEOUT               = 11; // timeout
	ASI_ERROR_INVALID_SENQUENCE     = 12; // stop capture first
	ASI_ERROR_BUFFER_TOO_SMALL      = 13; // buffer size is not big enough
	ASI_ERROR_VIDEO_MODE_ACTIVE     = 14;
	ASI_ERROR_EXPOSURE_IN_PROGRESS  = 15;
	ASI_ERROR_END                   = 16;

// ASI_BOOL
const
  ASI_FALSE = 0;
  ASI_TRUE  = 1;

// ASI_Control_TYPE (Control ID)
const
	ASI_GAIN                  =  0;
	ASI_EXPOSURE              =  1;
	ASI_GAMMA                 =  2;
	ASI_WB_R                  =  3;
	ASI_WB_B                  =  4;
	ASI_BRIGHTNESS            =  5;
	ASI_BANDWIDTHOVERLOAD     =  6;
	ASI_OVERCLOCK             =  7;
	ASI_TEMPERATURE           =  8;
	ASI_FLIP                  =  9;
	ASI_AutoExpMaxGain        = 10;
	ASI_AutoExpMaxExp         = 11;
	ASI_AutoExpMaxBrightness  = 12;

//------------------------------------------------------------------------------

// _ASI_CAMERA_INFO
type
  PASI_CAMERA_INFO = ^TASI_CAMERA_INFO;
  TASI_CAMERA_INFO = record
    Name                : array[0..63] of AnsiChar; // the name of the camera, you can display this to the UI
    CameraID            : Integer;                  // this is used to control everything of the camera in other functions
    MaxHeight           : Longint;                  // the max height of the camera
    MaxWidth            : Longint;                  // the max width of the camera

    IsColorCam          : Integer;
    BayerPattern        : Integer;

    SupportedBins       : array[0..15] of Integer;  // 1 means bin1 which is supported by every camera, 2 means bin 2 etc.. 0 is the end of supported binning method
    SupportedVideoFormat: array[0..7] of Integer;   // this array will content with the support output format type.IMG_END is the end of supported video format

    PixelSize           : Double;                   // the pixel size of the camera, unit is um. such like 5.6um
    MechanicalShutter   : Integer;
    ST4Port             : Integer;
  end;

// _ASI_CONTROL_CAPS
type
  PASI_CONTROL_CAPS = ^TASI_CONTROL_CAPS;
  TASI_CONTROL_CAPS = packed record
    Name            : array[0..63] of AnsiChar;   // the name of the Control like Exposure, Gain etc..
    Description     : array[0..127] of AnsiChar;  // description of this control
	  ControlID       : Integer;                    // this is used to get value and set value of the control
	  MaxValue        : Longint;
	  MinValue        : Longint;
	  DefaultValue    : Longint;
    IsAutoSupported : Integer;                    // support auto set 1, don't support 0
    IsWritable      : Integer;                    // some control like temperature can only be read by some cameras
    ControlType     : Integer;
  end;

//------------------------------------------------------------------------------
// ASICamera2.dll functions declaration
//------------------------------------------------------------------------------

//******************************************************************************
//  Descriptions£º
//    this should be the first api to be called
//    get number of connected ASI cameras,
//
//  Params£º
//
//  return£ºnumber of connected ASI cameras. 1 means 1 camera connected.
//******************************************************************************
function ASIGetNumOfConnectedCameras(): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    get the property of the connected cameras, you can do this without open the camera.
//    here is the sample code:
//
//    int iNumofConnectCameras = ASIGetNumOfConnectedCameras();
//    ASI_CAMERA_INFO **ppASICameraInfo = (ASI_CAMERA_INFO *)malloc(sizeof(ASI_CAMERA_INFO *)*iNumofConnectCameras);
//    for(int i = 0; i < iNumofConnectCameras; i++)
//    	ASIGetCameraProperty(pASICameraInfo[i], i);
//
//  Params£º
//  	ASI_CAMERA_INFO *pASICameraInfo: Pointer to structure containing the property of camera
//  									user need to malloc the buffer
//  	int iCameraIndex: 0 means the first connect camera, 1 means the second connect camera
//
//  return£º
//  	ASI_SUCCESS
//  	ASI_ERROR_INVALID_INDEX  :no camera connected or index value out of boundary
//******************************************************************************
function ASIGetCameraProperty(pASICameraInfo: PASI_CAMERA_INFO; iCameraIndex: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//  	open the camera before any operation to the camera, this function may take some while because it will init the camera too
//  	All APIs below need to open the camera at first.
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//
//  return£º
//    ASI_SUCCESS
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//    ASI_ERROR_CAMERA_REMOVED: failed to find the camera, maybe camera has been removed
//******************************************************************************
function ASIOpenCamera(iCameraID: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    you need to close the camera to free all the resource
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//
//  return£º
//    ASI_SUCCESS :it will return success even the camera already closed
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//******************************************************************************
function ASICloseCamera(iCameraID: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    Get number of controls available for this camera. the camera need be opened at first.
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    int * piNumberOfControls: pointer to an int to save the number of controls
//
//  Return:
//    ASI_SUCCESS :
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//******************************************************************************
function ASIGetNumOfControls(iCameraID: Integer; var piNumberOfControls: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    Get controls property available for this camera. the camera need be opened at first.
//    user need to malloc and maintain the buffer.
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    int iControlIndex:
//    ASI_CONTROL_CAPS * pControlCaps: Pointer to structure containing the property of the control
//    user need to malloc the buffer
//
//  Return:
//    ASI_SUCCESS :
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//******************************************************************************
function ASIGetControlCaps(iCameraID: Integer; iControlIndex: Integer; pControlCaps: PASI_CONTROL_CAPS): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    Get controls property value and auto value
//    note:the value of the temperature is the float value * 10 to convert it to long type, control name is "Temperature"
//    because long is the only type for control
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    int ControlID: this is get from control property use the api ASIGetControlCaps
//    long *plValue: pointer to the value you want to save the value get from control
//    ASI_BOOL *pbAuto: pointer to the ASI_BOOL type
//
//  Return:
//    ASI_SUCCESS :
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//    ASI_ERROR_INVALID_CONTROL_ID, //invalid Control ID
//******************************************************************************
function ASIGetControlValue(iCameraID: Integer; iControlID: Integer; var plValue: Longint; var pbAuto: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    Set controls property value and auto value
//    it will return success and set the max value or min value if the value is beyond the boundary
//
//  Params£º
//    int CameraID: this is get from the camera property use the API ASIGetCameraProperty
//    int ControlID: this is get from control property use the API ASIGetControlCaps
//    long lValue: the value set to the control
//    ASI_BOOL bAuto: set the control auto
//
//  Return:
//    ASI_SUCCESS :
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//    ASI_ERROR_INVALID_CONTROL_ID, //invalid Control ID
//******************************************************************************
function ASISetControlValue(iCameraID: Integer; iControlID: Integer; lValue: Longint; bAuto: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    set the ROI area before capture.
//    you must stop capture before call it.
//    the width and height is the value after binning.
//    ie. you need to set width to 640 and height to 480 if you want to run at 640X480@BIN2
//
//  Paras£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    int iWidth,  the width of the ROI area    please make sure that width*height%1024=0
//    int iHeight,  the height of the ROI area. please make sure that width*height%1024=0
//    int iBin,   binning method. bin1=1, bin2=2
//    ASI_IMG_TYPE Img_type: the output format you want
//
//  Return:
//    ASI_SUCCESS :
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//    ASI_ERROR_INVALID_SIZE, //wrong video format size
//    ASI_ERROR_INVALID_IMGTYPE, //unsupported image format, make sure iWidth and iHeight and binning is set correct
//******************************************************************************
function ASISetROIFormat(iCameraID: Integer; iWidth: Integer; iHeight: Integer; iBin: Integer; Img_type: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    Get the current ROI area setting .
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    int *piWidth,  pointer to the width of the ROI area
//    int *piHeight, pointer to the height of the ROI area.
//    int *piBin,   pointer to binning method. bin1=1, bin2=2
//    ASI_IMG_TYPE *pImg_type: pointer to the output format
//
//  Return:
//    ASI_SUCCESS :
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//******************************************************************************
function ASIGetROIFormat(iCameraID: Integer; var piWidth: Integer; var piHeight: Integer; var piBin: Integer; var pImg_type: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    Set the start position of the ROI area.
//    you can call this api to move the ROI area when video is streaming
//    the camera will set the ROI area to the center of the full image as default
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    int iStartX, pointer to the start X
//    int iStartY  pointer to the start Y
//
//  Return:
//    ASI_SUCCESS :
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//    ASI_ERROR_OUTOF_BOUNDARY: the start x and start y make the image out of boundary
//******************************************************************************
function ASISetStartPos(iCameraID, iStartX, iStartY: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    Get the start position of current ROI area .
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    int *piStartX, pointer to the start X
//    int *piStartY  pointer to the start Y
//
//  Return:
//    ASI_SUCCESS :
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//******************************************************************************
function ASIGetStartPos(iCameraID: Integer; var piStartX: Integer; var piStartY: Integer): Integer; cdecl; external ASICAMERA_API

//******************************************************************************
//  Descriptions£º
//    Get the droped frames .
//    drop frames happen when USB is traffic or harddisk write speed is slow
//    it will reset to 0 after stop capture
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    int *piDropFrames pointer to drop frames
//
//  Return:
//    ASI_SUCCESS :
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//******************************************************************************
function ASIGetDroppedFrames(iCameraID: Integer; var piDropFrames: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    provide a dark file's path to the function and enable dark subtract
//    this is used when there is hot pixel or need to do long exposure
//    you'd better make this dark file from the  "dark subtract" funtion
//    of the "video capture filter" directshow page.
//    the dark file's size should be the same of camera's max width and height
//    and should be RGB8 raw format.it will on even you changed the ROI setting
//    it only correct the hot pixels if out put is 16bit.
//
//    it will be remembered in registry. so "Dark subtract" is on next time if you close your app.
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    char *pcBMPPath: the path to the bmp dark file.
//    bIsSubDarkWorking:  check if subtracting dark is working, wrong dark file path may cause it not work
//
//  return£º
//    ASI_SUCCESS :
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_PATH, //cannot find the path of the file
//    ASI_ERROR_INVALID_FILEFORMAT, //the dark file's size should be the same of camera's max width and height
//******************************************************************************
function ASIEnableDarkSubtract(iCameraID: Integer; pcBMPPath: PAnsiChar; var bIsSubDarkWorking: BOOL): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    Disable the dark subtract function.
//    you'd better call it at start if you don't want to use it.
//    because dark subtract function is remembered on windows platform
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//
//  Return:
//    ASI_SUCCESS :
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//******************************************************************************
function ASIDisableDarkSubtract(iCameraID: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    Start video capture
//    then you can get the data from the api ASIGetVideoData
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//
//  Return:
//    ASI_SUCCESS : it will return success if already started
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//******************************************************************************
function ASIStartVideoCapture(iCameraID: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    Stop video capture
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//
//  Return:
//    ASI_SUCCESS : it will return success if already started
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//******************************************************************************
function ASIStopVideoCapture(iCameraID: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    get data from the video buffer.the buffer is very small
//    you need to call this api as fast as possible, otherwise frame will be discarded
//    so the best way is maintain one buffer loop and call this api in a loop
//    please make sure the buffer size is biger enough to hold one image
//    otherwise the this api will crash
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    unsigned char* pBuffer, caller need to malloc the buffer, make sure the size is big enough
//    		the size in byte:
//    		8bit mono:width*height
//    		16bit mono:width*height*2
//    		RGB24:width*height*3
//
//    int iWaitms, this API will block and wait iWaitms to get one image. the unit is ms
//    		-1 means wait forever. this value is recommend set to exposure*2+500ms
//
//  Return:
//    ASI_SUCCESS : it will return success if already started
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//    ASI_ERROR_TIMEOUT: no image get and timeout
//******************************************************************************
function ASIGetVideoData(iCameraID: Integer; pBuffer: PBYTE; lBuffSize: Longint; iWaitms: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    PulseGuide of the ST4 port on. this function only work on the module which have ST4 port
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    ASI_GUIDE_DIRECTION direction the direction of guider
//
//  Return:
//    ASI_SUCCESS : it will return success if already started
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//******************************************************************************
function ASIPulseGuideOn(iCameraID: Integer; direction: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    PulseGuide of the ST4 port off. this function only work on the module which have ST4 port
//    make sure where is ASIPulseGuideOn and there is ASIPulseGuideOff
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    ASI_GUIDE_DIRECTION direction the direction of guider
//
//  Return:
//    ASI_SUCCESS : it will return success if already started
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//******************************************************************************
function ASIPulseGuideOff(iCameraID: Integer; direction: Integer): Integer; cdecl; external ASICAMERA_API;

//******************************************************************************
//  Descriptions£º
//    check if the camera works at usb3 status
//
//  Params£º
//    int CameraID: this is get from the camera property use the api ASIGetCameraProperty
//    ASI_GUIDE_DIRECTION direction the direction of guider
//    ASI_BOOL *bSet: ASI_TRUE USB3, ASI_FALSE USB2
//
//  Return:
//    ASI_SUCCESS : it will return success if already started
//    ASI_ERROR_CAMERA_CLOSED : camera didn't open
//    ASI_ERROR_INVALID_ID  :no camera connected or index value out of boundary
//******************************************************************************
function ASIIsUSB3Host(iCameraID: Integer; var bSet: Integer): Integer; cdecl; external ASICAMERA_API;

implementation

initialization
  IsMultiThread := TRUE;

end.
