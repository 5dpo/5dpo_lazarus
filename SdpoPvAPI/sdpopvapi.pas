{ SdpoPvAPI v0.0.1

  CopyRight (C) 2012 Paulo Malheiros and Joao Paulo Silva

  This library is Free software; you can rediStribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version.

  This program is diStributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; withOut even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a Copy of the GNU Library General Public License
  along with This library; if not, Write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

  This license has been modified. See File LICENSE.ADDON for more inFormation.
  Should you find these sources without a LICENSE File, please contact
  me at jsilva86@gmail.com
}
unit SdpoPvAPI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, BaseUnix, LResources, PvApi, Forms;

const
  MAXCAMERALIST = 8;
  FRAMESCOUNT = 16;


type
  TSdpoPvCameraFrameEvent = procedure(Sender: TObject; FramePtr: PByte) of object;

type
  TPvTriggerMode = (
    pvtm_Freerun,
    pvtm_SyncIn1,
    pvtm_SyncIn2,
    pvtm_FixedRate,
    pvtm_Software);

const
  PvTriggerModeConsts: array[TPvTriggerMode] of string = (
    'Freerun',
    'SyncIn1',
    'SyncIn2',
    'FixedRate',
    'Software');

type
  TPvAcquisitionMode = (
    pvam_Continuous,
    pvam_SingleFrame,
    pvam_MultiFrame,
    pvam_Recorder);

const
  PvAcquisitionModeConsts: array[TPvAcquisitionMode] of string = (
    'Continuous',
    'SingleFrame',
    'MultiFrame',
    'Recorder');

{ TODO : Add WhiteBalance controls }
type
  TPvWhiteBalanceMode = (
    pvwb_Manual,
    pvwb_Auto,
    pvwb_AutoOnce);

const
  PvWhiteBalanceModeConsts: array[TPvWhiteBalanceMode] of string = (
    'Manual',
    'Auto',
    'AutoOnce');

type
  TPvExposureMode = (
    pvem_Manual,
    pvem_Auto,
    pvem_AutoOnce,
    pvem_External);

const
  PvExposureModeConsts: array[TPvExposureMode] of string = (
    'Manual',
    'Auto',
    'AutoOnce',
    'External');

type
  TPvGainMode = (
    pvgm_Manual,
    pvgm_Auto,
    pvgm_AutoOnce);

const
  PvGainModeConsts: array[TPvGainMode] of string = (
    'Manual',
    'Auto',
    'AutoOnce');

type
  TPvPixelFormat = (
    pvpf_Mono8,
    pvpf_Mono16,
    pvpf_Bayer8,
    pvpf_Bayer16,
    pvpf_Rgb24,
    pvpf_Rgb48,
    pvpf_Yuv411,
    pvpf_Yuv422,
    pvpf_Yuv444,
    pvpf_Bgr24,
    pvpf_Rgba32,
    pvpf_Bgra32,
    pvpf_Mono12Packed,
    pvpf_Bayer12Packed);

const
  PvPixelFormatConsts: array[TPvPixelFormat] of string = (
    'Mono8',
    'Mono16',
    'Bayer8',
    'Bayer16',
    'Rgb24',
    'Rgb48',
    'Yuv411',
    'Yuv422',
    'Yuv444',
    'Bgr24',
    'Rgba32',
    'Bgra32',
    'Mono12Packed',
    'Bayer12Packed');

type
  TPvOpenMode = (
    pvom_ReadParams,
    pvom_SetParams);

const
  PVOpenModeConsts: array[TPvOpenMode] of string = (
    'ReadParams',
    'SetParams');

type

  TSdpoPvCamera = class;

  { TSdpoPvCaptureThread }

  TSdpoPvCameraCaptureThread = class(TThread)
  public
    Owner: TSdpoPvCamera;
    CurFrame: integer;
    VideoBufferIndex: integer;
  protected

    procedure CallEvent;
    procedure Execute; override;
  end;

  { TSdpoPvAPI }

  TSdpoPvAPI = class(TComponent)
  private

    //FActive: boolean;//Determines if there are any cameras on the bus
    FInitialized: boolean;
    FDebugList: TStrings;
    FCameraNum: culong;
    FCameraList: array[0..MAXCAMERALIST - 1] of tPvCameraInfoEx;

    procedure DeviceOpen;
    procedure DeviceClose;
    //procedure SetActive(state: boolean);
    procedure SetInitialized(state: boolean);
    procedure ListAvailableCameras;

  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Update;

    procedure Open;
    procedure Close;

    procedure SetDebugList(dl: TStrings);
    procedure AddDebug(s: string);

    function GetFirstCamera: PtPvCameraInfoEx;
    function GetCameraByUID(uid: culong): PtPvCameraInfoEx;
    function GetCameraByName(model: string): PtPvCameraInfoEx;
    procedure GetAvailableCamerasUID(Sender: TStringList);

  published
    //property Active: boolean read FActive write SetActive;
    property CamerasCount: culong read FCameraNum;
    property Initialized: boolean read FInitialized write SetInitialized;
  end;

  { TSdpoPvCamera }

  TSdpoPvCamera = class(TComponent)
  private
    FOnFrame: TSdpoPvCameraFrameEvent;

    FActive: boolean;
    FAPI: TSdpoPvAPI;
    FCamInfo: PtPvCameraInfoEx;
    FCamHandle: tPvHandle;
    FFrames: array[0..FRAMESCOUNT - 1] of tPvFrame;
    FCurFrame: integer;
    FDebugList: TStrings;

    CapThread: TSdpoPvCameraCaptureThread;
    CapThreadPID: TPid;

    {Camera Properties}

    //Camera Selection
    FUniqueID: integer;
    FModel: string;

    //Sensor Info
    FSensorBits: tPvUint32;
    FSensorWidth: tPvUint32;
    FSensorHeight: tPvUint32;

    //Controls
    FExposureMode: TPvExposureMode;
    FExposureValue: tPvUint32;
    FWhiteBalanceMode: TPvWhiteBalanceMode;
    FWhiteBalanceRed: tPvUint32;
    FWhiteBalanceBlue: tPvUint32;
    FGainMode: TPvGainMode;
    FGainValue: tPvUint32;

    //Acquisition
    FTriggerMode: TPvTriggerMode;
    FAcquisitionMode: TPvAcquisitionMode;
    FFrameRate: tPvFloat32;
    FPixelFormat: TPvPixelFormat;
    FPacketSize: integer;
    FStreamBytesPerSecond: integer;
    FRoiWidth: integer;
    FRoiHeight: integer;
    FRoiX: integer;
    FRoiY: integer;

    //    procedure SetActive(const AValue: Boolean);
    procedure SetAPI(const val: TSdpoPvAPI);

    procedure ListAttributes;

    procedure GetStringAttribute(attr: pcchar; val: pcchar; valsize: culong);
    procedure SetStringAttribute(attr: pcchar; val: pcchar);
    procedure GetEnumAttribute(attr: pcchar; val: pcchar; valsize: culong);
    procedure SetEnumAttribute(attr: pcchar; val: pcchar);
    procedure GetUint32Attribute(attr: pcchar; val: PtPvUint32);
    procedure SetUint32Attribute(attr: pcchar; val: tPvUint32);
    procedure GetFloat32Attribute(attr: pcchar; val: PtPvFloat32);
    procedure SetFloat32Attribute(attr: pcchar; val: tPvFloat32);
    procedure GetInt64Attribute(attr: pcchar; val: PtPvInt64);
    procedure SetInt64Attribute(attr: pcchar; val: tPvInt64);
    procedure GetBooleanAttribute(attr: pcchar; val: PtPvBoolean);
    procedure SetBooleanAttribute(attr: pcchar; val: tPvBoolean);

    //procedure Setup;
    procedure UnSetup;
    procedure DeviceOpen(var state: boolean);
    procedure DeviceClose;
    procedure SetActive(state: boolean);

    procedure SetCameraUID(const AValue: integer);
    procedure SetCameraModel(const AValue: string);
    procedure SetPixelFormat(const AValue: TPvPixelFormat);
    procedure SetCameraPixelFormat;
    procedure SetTriggerMode(const AValue: TPvTriggerMode);
    procedure SetCameraTriggerMode;
    procedure SetFrameRate(const AValue: single);
    procedure SetCameraFrameRate;
    procedure SetPacketSize(const AValue: integer);
    procedure SetCameraPacketSize;
    procedure SetRoiHeight(const AValue: integer);
    procedure SetCameraRoiHeight;
    procedure SetRoiWidth(const AValue: integer);
    procedure SetCameraRoiWidth;
    procedure SetRoiX(const AValue: integer);
    procedure SetCameraRoiX;
    procedure SetRoiY(const AValue: integer);
    procedure SetCameraRoiY;

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    FClosing: boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Open(OpenMode: TPvOpenMode=pvom_SetParams);
    procedure Close;

    //procedure Start;
    //procedure Stop;

    procedure SetDebugList(dl: TStrings);
    procedure AddDebug(s: string);
    function StatFramePixelFormat: TPvPixelFormat;

    function GetAttributeUint32(attr: string): tPvUint32;
    procedure SetAttributeUint32(attr: string; val: tPvUint32);

    procedure SetExposureMode(const AValue: TPvExposureMode);
    procedure SetExposureValue(const AValue: Longword);
    procedure SetWhiteBalanceMode(const AValue: TPvWhiteBalanceMode);
    procedure SetWhiteBalanceRed(const AValue: Longword);
    procedure SetWhiteBalanceBlue(const AValue: Longword);
    procedure SetGainMode(const AValue: TPvGainMode);
    procedure SetGainValue(const AValue: Longword);
    procedure SetStreamBytesPerSecond(const AValue: integer);

    procedure SetDecimation(const ValueX, ValueY: Longword);

    property SensorWidth: tPvUint32 read FSensorWidth;
    property SensorHeight: tPvUint32 read FSensorHeight;

  published
    property API: TSdpoPvAPI read FAPI write SetAPI;
    property Active: boolean read FActive write SetActive;
    property FrameRate: single read FFrameRate write SetFrameRate;
    property PixelFormat: TPvPixelFormat read FPixelFormat write SetPixelFormat;
    property CameraUID: integer read FUniqueID write SetCameraUID;
    property CameraModel: string read FModel write SetCameraModel;
    property TriggerMode: TPvTriggerMode read FTriggerMode write SetTriggerMode;
    property PacketSize: integer read FPacketSize write SetPacketSize;
    property RoiWidth: integer read FRoiWidth write SetRoiWidth;
    property RoiHeight: integer read FRoiHeight write SetRoiHeight;
    property RoiX: integer read FRoiX write SetRoiX;
    property RoiY: integer read FRoiY write SetRoiY;
    //    property WhiteBalanceMode: TPvWhiteBalanceMode read FWhiteBalanceMode write SetWhiteBalanceMode;
    //    property ExposureValue: tPvUint32 read FExposureValue write FExposureValue;
    //    property ExposureMode: TPvExposureMode read FExposureMode write FExposureMode;
    //    property AcquisitionMode: TPvAcquisitionMode read FAcquisitionMode write SetAcquisitionMode;

    property OnFrame: TSdpoPvCameraFrameEvent read FOnFrame write FOnFrame;
  end;

procedure Register;


implementation


procedure Register;
begin
  RegisterComponents('5dpo', [TSdpoPvAPI, TSdpoPvCamera]);
end;

{Utils}

function CharArrayToString(charArray: pcchar; arraySize: integer): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to arraySize - 1 do begin
    if charArray[i] = 0 then
      break;
    Result := Result + chr(charArray[i]);
  end;
end;


{ TSdpoPvCamera }

constructor TSdpoPvCamera.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited Create(AOwner);
  FAPI := nil;
  FActive := False;
  FCamInfo := nil;
  FCamHandle := nil;
  FDebugList := nil;
  FClosing := False;
  CapThread := nil;
  FUniqueID := -1;
  FModel := '';
  FPixelFormat := pvpf_Mono8;
  FTriggerMode := pvtm_Freerun;
  FAcquisitionMode := pvam_Continuous;
  FFrameRate := 0;
  FCurFrame := 0;
  FPacketSize := 1500;
  FStreamBytesPerSecond := 0;
  FExposureMode := pvem_Manual;
  FExposureValue := 15000;
  FWhiteBalanceMode := pvwb_Manual;
  FWhiteBalanceRed := 140;
  FWhiteBalanceBlue := 160;
  FRoiWidth := 0;
  FRoiHeight := 0;
  FRoiX := 0;
  FRoiY := 0;

  for i := 0 to FRAMESCOUNT - 1 do begin
    FFrames[i].ImageBuffer := nil;
  end;
end;

destructor TSdpoPvCamera.Destroy;
begin
  inherited Destroy;
end;

procedure TSdpoPvCamera.Open(OpenMode: TPvOpenMode);
var
  str1: string;
  err: tPvErr;
  valMin, valMax: tPvUint32;
begin
  Active := True;

  if Active then begin
    case OpenMode of
      pvom_ReadParams: begin
        str1 := 'WhitebalValueBlue';
        PvAttrUint32Get(FCamHandle, @str1[1], @FWhiteBalanceBlue);

        str1 := 'WhitebalValueRed';
        PvAttrUint32Get(FCamHandle, @str1[1], @FWhiteBalanceRed);

        str1 := 'GainValue';
        PvAttrUint32Get(FCamHandle, @str1[1], @FGainValue);

        str1 := 'ExposureValue';
        PvAttrUint32Get(FCamHandle, @str1[1], @FExposureValue);
      end;
      pvom_SetParams: begin
        str1 := 'WhitebalValueBlue';
        err := PvAttrRangeUint32(FCamHandle, @str1[1], @valMin, @valMax);
        if (err = ePvErrSuccess) then
          PvAttrUint32Set(FCamHandle, @str1[1], FWhiteBalanceBlue);

        str1 := 'WhitebalValueRed';
        err := PvAttrRangeUint32(FCamHandle, @str1[1], @valMin, @valMax);
        if (err = ePvErrSuccess) then
          PvAttrUint32Set(FCamHandle, @str1[1], FWhiteBalanceRed);

        str1 := 'GainValue';
        err := PvAttrRangeUint32(FCamHandle, @str1[1], @valMin, @valMax);
        if (err = ePvErrSuccess) then
          PvAttrUint32Set(FCamHandle, @str1[1], FGainValue);

        str1 := 'ExposureValue';
        err := PvAttrRangeUint32(FCamHandle, @str1[1], @valMin, @valMax);
        if (err = ePvErrSuccess) then
          PvAttrUint32Set(FCamHandle, @str1[1], FExposureValue);
      end;
    end;
  end;
end;

procedure TSdpoPvCamera.Close;
begin
  Active := False;
end;

procedure TSdpoPvCamera.SetDebugList(dl: TStrings);
begin
  FDebugList := dl;
end;

procedure TSdpoPvCamera.AddDebug(s: string);
begin
  if FDebugList <> nil then
    FDebugList.Add(s);
end;

function TSdpoPvCamera.StatFramePixelFormat: TPvPixelFormat;
begin
  Result := TPvPixelFormat(FFrames[FCurFrame].Format);
end;

function TSdpoPvCamera.GetAttributeUint32(attr: string): tPvUint32;
begin
  GetUint32Attribute(@(attr[1]), @result);
end;

procedure TSdpoPvCamera.SetAttributeUint32(attr: string; val: tPvUint32);
begin
  SetUint32Attribute(@(attr[1]), val);
end;


procedure TSdpoPvCamera.SetAPI(const val: TSdpoPvAPI);
begin
  FAPI := val;
end;

procedure TSdpoPvCamera.ListAttributes;
var
  attrList: tPvAttrListPtr;
  attrListLenght: culong;
begin
  PvAttrList(FCamHandle, @attrList, @attrListLenght);

  AddDebug('attrListLenght ' + IntToStr(attrListLenght));
end;

procedure TSdpoPvCamera.GetStringAttribute(attr: pcchar; val: pcchar; valsize: culong);
var
  err: tPvErr;
begin
  err := PvAttrStringGet(FCamHandle, attr, val, valsize, nil);
  if (err <> ePvErrSuccess) then begin
    val^ := Ord(' ');
    raise Exception.Create('Could not GetStringAttribute!');
  end;
end;

procedure TSdpoPvCamera.SetRoiHeight(const AValue: integer);
begin
  if FRoiHeight = AValue then
    exit;
  FRoiHeight := AValue;

  if Active then
    SetCameraRoiHeight;
end;

procedure TSdpoPvCamera.SetCameraRoiHeight;
var
  str1: string;
begin
  // Determines how frames are triggered
  str1 := 'Height';
  SetUint32Attribute(@str1[1], FRoiHeight);
end;

procedure TSdpoPvCamera.SetRoiWidth(const AValue: integer);
begin
  if FRoiWidth = AValue then
    exit;
  FRoiWidth := AValue;

  if Active then
    SetCameraRoiWidth;
end;

procedure TSdpoPvCamera.SetCameraRoiWidth;
var
  str1: string;
begin
  // Determines how frames are triggered
  str1 := 'Width';
  SetUint32Attribute(@str1[1], FRoiWidth);
end;

procedure TSdpoPvCamera.SetRoiX(const AValue: integer);
begin
  if FRoiX = AValue then
    exit;
  FRoiX := AValue;

  if Active then
    SetCameraRoiX;
end;

procedure TSdpoPvCamera.SetCameraRoiX;
var
  str1: string;
begin
  // Determines how frames are triggered
  str1 := 'RegionX';
  SetUint32Attribute(@str1[1], FRoiX);
end;

procedure TSdpoPvCamera.SetRoiY(const AValue: integer);
begin
  if FRoiY = AValue then
    exit;
  FRoiY := AValue;

  if Active then
    SetCameraRoiY;
end;

procedure TSdpoPvCamera.SetCameraRoiY;
var
  str1: string;
begin
  // Determines how frames are triggered
  str1 := 'RegionY';
  SetUint32Attribute(@str1[1], FRoiY);
end;

procedure TSdpoPvCamera.SetStringAttribute(attr: pcchar; val: pcchar);
var
  err: tPvErr;
begin
  err := PvAttrStringSet(FCamHandle, attr, val);
  if (err <> ePvErrSuccess) then begin
    raise Exception.Create('Could not SetStringAttribute!');
  end;
end;

procedure TSdpoPvCamera.GetEnumAttribute(attr: pcchar; val: pcchar; valsize: culong);
var
  err: tPvErr;
begin
  err := PvAttrEnumGet(FCamHandle, attr, val, valsize, nil);
  if (err <> ePvErrSuccess) then begin
    val^ := Ord(' ');
    raise Exception.Create('Could not GetEnumAttribute!');
  end;
end;

procedure TSdpoPvCamera.SetEnumAttribute(attr: pcchar; val: pcchar);
var
  err: tPvErr;
begin
  err := PvAttrEnumSet(FCamHandle, attr, val);
  if (err <> ePvErrSuccess) then begin
    raise Exception.Create('Could not SetEnumAttribute ' + CharArrayToString(attr, 32));
  end;
end;

procedure TSdpoPvCamera.GetUint32Attribute(attr: pcchar; val: PtPvUint32);
var
  err: tPvErr;
begin
  err := PvAttrUint32Get(FCamHandle, attr, val);
  if (err <> ePvErrSuccess) then begin
    val^ := 0;
    raise Exception.Create('Could not GetUint32Attribute ' + CharArrayToString(attr, 32));
  end;
end;

procedure TSdpoPvCamera.SetUint32Attribute(attr: pcchar; val: tPvUint32);
var
  err: tPvErr;
  valMin, valMax: tPvUint32;
begin
  err := PvAttrRangeUint32(FCamHandle, attr, @valMin, @valMax);
  if (err <> ePvErrSuccess) then
    raise Exception.Create('Could not SetUint32Attribute ' + CharArrayToString(attr, 32) + '. Value out of range!')
  else begin
    err := PvAttrUint32Set(FCamHandle, attr, val);
    if (err <> ePvErrSuccess) then
      raise Exception.Create('Could not SetUint32Attribute ' + CharArrayToString(attr, 32));
  end;
end;

procedure TSdpoPvCamera.GetFloat32Attribute(attr: pcchar; val: PtPvFloat32);
var
  err: tPvErr;
begin
  err := PvAttrFloat32Get(FCamHandle, attr, val);
  if (err <> ePvErrSuccess) then begin
    val^ := -1;
    raise Exception.Create('Could not GetFloat32Attribute ' + CharArrayToString(attr, 32));
  end;
end;

procedure TSdpoPvCamera.SetFloat32Attribute(attr: pcchar; val: tPvFloat32);
var
  err: tPvErr;
  valMin, valMax: tPvFloat32;
begin
  err := PvAttrRangeFloat32(FCamHandle, attr, @valMin, @valMax);
  if (err <> ePvErrSuccess) then
    raise Exception.Create('Could not SetFloat32Attribute ' + CharArrayToString(attr, 32) + '. Value out of range!')
  else begin
    err := PvAttrFloat32Set(FCamHandle, attr, val);
    if (err <> ePvErrSuccess) then
      raise Exception.Create('Could not SetFloat32Attribute ' + CharArrayToString(attr, 32));
  end;

end;

procedure TSdpoPvCamera.GetInt64Attribute(attr: pcchar; val: PtPvInt64);
var
  err: tPvErr;
begin
  err := PvAttrInt64Get(FCamHandle, attr, val);
  if (err <> ePvErrSuccess) then begin
    val^ := -1;
    raise Exception.Create('Could not GetInt64Attribute ' + CharArrayToString(attr, 32));
  end;
end;

procedure TSdpoPvCamera.SetInt64Attribute(attr: pcchar; val: tPvInt64);
var
  err: tPvErr;
begin
  err := PvAttrInt64Set(FCamHandle, attr, val);
  if (err <> ePvErrSuccess) then begin
    raise Exception.Create('Could not SetInt64Attribute ' + CharArrayToString(attr, 32));
  end;
end;

procedure TSdpoPvCamera.GetBooleanAttribute(attr: pcchar; val: PtPvBoolean);
var
  err: tPvErr;
begin
  err := PvAttrBooleanGet(FCamHandle, attr, val);
  if (err <> ePvErrSuccess) then begin
    raise Exception.Create('Could not GetBooleanAttribute ' + CharArrayToString(attr, 32));
  end;
end;

procedure TSdpoPvCamera.SetBooleanAttribute(attr: pcchar; val: tPvBoolean);
var
  err: tPvErr;
begin
  err := PvAttrBooleanSet(FCamHandle, attr, val);
  if (err <> ePvErrSuccess) then begin
    raise Exception.Create('Could not SetBooleanAttribute ' + CharArrayToString(attr, 32));
  end;
end;

procedure TSdpoPvCamera.SetWhiteBalanceMode(const AValue: TPvWhiteBalanceMode);
var
  str1, str2: string;
begin
  if FWhiteBalanceMode = AValue then
    exit;
  FWhiteBalanceMode := AValue;

  str1 := 'WhitebalMode';
  str2 := PvWhiteBalanceModeConsts[FWhiteBalanceMode];

  if Active then
    SetEnumAttribute(@str1[1], @str2[1]);
end;

procedure TSdpoPvCamera.SetWhiteBalanceRed(const AValue: Longword);
var
  str1: string;
begin
  if FWhiteBalanceRed = AValue then
    exit;
  FWhiteBalanceRed := AValue;

  str1 := 'WhitebalValueRed';
  if Active then
    SetUint32Attribute(@str1[1], FWhiteBalanceRed);
end;

procedure TSdpoPvCamera.SetWhiteBalanceBlue(const AValue: Longword);
var
  str1: string;
begin
  if FWhiteBalanceBlue = AValue then
    exit;
  FWhiteBalanceBlue := AValue;

  str1 := 'WhitebalValueBlue';
  if Active then
    SetUint32Attribute(@str1[1], FWhiteBalanceBlue);
end;

procedure TSdpoPvCamera.SetGainMode(const AValue: TPvGainMode);
var
  str1, str2: string;
begin
  if FGainMode = AValue then
    exit;
  FGainMode := AValue;

  str1 := 'GainMode';
  str2 := PvGainModeConsts[FGainMode];

  if Active then
    SetEnumAttribute(@str1[1], @str2[1]);
end;

procedure TSdpoPvCamera.SetGainValue(const AValue: Longword);
var
  str1: string;
begin
  if FGainValue = AValue then
    exit;
  FGainValue := AValue;

  str1 := 'GainValue';
  if Active then
    SetUint32Attribute(@str1[1], FGainValue);
end;

//procedure TSdpoPvCamera.Setup;
//var
//  imageSize: tPvUint32;
//  str: string;
//  i: Integer;
//begin
//  // Calculate frame buffer size
//  str := 'TotalBytesPerFrame';
//  GetUint32Attribute(@str[1],@imageSize);
//  //Allocate frame buffers
//  for i:=0 to FRAMESCOUNT-1 do begin
//      Getmem(FFrames[i].ImageBuffer,imageSize);
//      FFrames[i].ImageBufferSize:=imageSize;
//  end;
//end;

procedure TSdpoPvCamera.UnSetup;
var
  err: tPvErr;
  i: integer;
begin
  err := PvCameraClose(FCamHandle);
  if (err and ePvErrBadHandle) > 0 then begin
    AddDebug('Error closing camera: Bad handle!');
    //raise exception
  end else
    AddDebug('Camera successfully closed!');

  for i := 0 to FRAMESCOUNT - 1 do begin
    Freemem(FFrames[i].ImageBuffer, FFrames[i].ImageBufferSize);
    FFrames[i].ImageBuffer := nil;
  end;
end;

procedure TSdpoPvCamera.DeviceOpen(var state: boolean);
var
  //exposure: tPvUint32;
  err: tPvErr;
  str1, str2: string;
  imageSize: tPvUint32;
  i: integer;
begin
  if FAPI = nil then begin
    state := False;
    //exit;
    raise Exception.Create('Could not open camera: no API available');
  end;

  AddDebug('UID: ' + IntToStr(FUniqueID) + '; Model: ' + FModel);
  if FCamInfo = nil then begin
    if FUniqueID <> -1 then
      FCamInfo := FAPI.GetCameraByUID(FUniqueID)
    else if FModel <> '' then
      FCamInfo := FAPI.GetCameraByName(FModel)
    else
      FCamInfo := FAPI.GetFirstCamera;

    if FCamInfo = nil then begin
      state := False;
      exit;
      raise Exception.Create('Could not get camera!');
    end;
  end;

  AddDebug('UID: ' + IntToStr(FCamInfo^.UniqueId) + ' Camera Name: ' + CharArrayToString(@FCamInfo^.CameraName, 32));

  err := PvCameraOpen(FCamInfo^.UniqueId, ePvAccessMaster, @FCamHandle);
  if err = ePvErrSuccess then begin
    AddDebug('Camera successfully opened!');
  end else begin
    AddDebug('Error opening camera: ' + IntToStr(err) + '!');
    state := False;
    //exit;
    raise Exception.Create('Could not open camera: PvCameraOpen fail');
  end;

  if (FRoiWidth <> 0) and (FRoiHeight <> 0) then begin
    SetCameraRoiWidth;
    SetCameraRoiHeight;
    SetCameraRoiX;
    SetCameraRoiY;
    AddDebug('Camera Roi: ' + Format('Width=%d, Height=%d, X=%d, Y=%d', [FRoiWidth, FRoiHeight, FRoiX, FRoiY]));
  end;

  // Reset camera pixel format
  SetCameraPixelFormat;

  // Calculate frame buffer size
  str1 := 'TotalBytesPerFrame';
  //GetUint32Attribute(@str[1],@imageSize);
  err := PvAttrUint32Get(FCamHandle, @str1[1], @imageSize);
  if (err <> ePvErrSuccess) then begin
    state := False;
    raise Exception.Create('Could not GetUint32Attribute!');
    exit;
  end;

  // Allocate frame buffers
  for i := 0 to FRAMESCOUNT - 1 do begin
    if FFrames[i].ImageBuffer = nil then begin
      Getmem(FFrames[i].ImageBuffer, imageSize);
      FFrames[i].ImageBufferSize := imageSize;
    end;
  end;

  // Set packet size
  //err := PvCaptureAdjustPacketSize(FCamHandle, 8228);
  //if (err <> ePvErrSuccess) then
  //begin
  //  state := False;
  //  raise Exception.Create('Error while adjusting packet size!');
  //  exit;
  //end;
  SetCameraPacketSize;

  // Start driver capture stream
  err := PvCaptureStart(FCamHandle);
  if (err <> ePvErrSuccess) then begin
    state := False;
    raise Exception.Create('Could not start driver capture stream!');
    //exit;
  end;

  // Queue frames. No FrameDoneCB callback function.
  for i := 0 to FRAMESCOUNT - 1 do begin
    err := PvCaptureQueueFrame(FCamHandle, @FFrames[i], nil);
  end;

  //// Determines how frames are triggered
  //str1 := 'FrameStartTriggerMode';
  //str2 := PvTriggerModeConsts[FTriggerMode];
  //err := PvAttrEnumSet(FCamHandle,@str1[1],@str2[1]);
  //if (err <> ePvErrSuccess) then begin
  //  state := false;
  //  raise Exception.create('CameraStart: failed to set camera attributes - FrameStartTriggerMode!');
  //  //exit;
  //end;
  SetCameraTriggerMode;

  SetCameraFrameRate;

  // Determines how many frame triggers the camera receives
  str1 := 'AcquisitionMode';
  str2 := PvAcquisitionModeConsts[FAcquisitionMode];
  err := PvAttrEnumSet(FCamHandle, @str1[1], @str2[1]);
  if (err <> ePvErrSuccess) then begin
    state := False;
    raise Exception.Create('CameraStart: failed to set camera attributes - AcquisitionMode!');
    //exit;
  end;

  //Get info about the camera sensor - move this to a procedure named something like LoadCameraInfo
  str1 := 'SensorWidth';
  str2 := 'SensorHeight';
  GetUint32Attribute(@str1[1], @FSensorWidth);
  GetUint32Attribute(@str2[1], @FSensorHeight);

  // Reset camera pixel format
  //SetCameraPixelFormat;

  // Readies camera to receive frame triggers
  str1 := 'AcquisitionStart';
  err := PvCommandRun(FCamHandle, @str1[1]);
  if (err <> ePvErrSuccess) then begin
    state := False;
    raise Exception.Create('CameraStart: failed to set camera attributes!');
    //exit;
  end;

  if CapThread <> nil then
    CapThread.Free;
  CapThread := TSdpoPvCameraCaptureThread.Create(True);
  //CapThread.OnTerminate := @CapThread.StoppingThread;
  CapThread.Owner := Self;
  CapThread.Start;
  //CapThread.Resume;


  //str:='ExposureValue';
  //try
  //  SetUint32Attribute(@str[1],10000);
  //  GetUint32Attribute(@str[1],@exposure);
  //  AddDebug(str+' '+IntToStr(exposure));
  //except on
  //  E: exception do begin
  //    AddDebug(E.message);
  //  end;
  //end;
end;

procedure TSdpoPvCamera.DeviceClose;
begin
  // stop capture thread
  if CapThread <> nil then begin
    CapThread.FreeOnTerminate := False;
    FClosing := True;
    CapThread.Terminate;
    //CapThread.WaitFor;   // TODO: dar um timeout simpatico se a thread pendurar
    while FClosing do begin
      Application.ProcessMessages;
    end;
    CapThread.Free;
    CapThread := nil;
  end;

  UnSetup;
  FActive := False;
  //FCamHandle:=Nil;
  //FCamInfo:=Nil;
end;

procedure TSdpoPvCamera.SetActive(state: boolean);
begin
  if state = FActive then
    exit;

  if state then
    DeviceOpen(state)
  else
    DeviceClose;

  FActive := state;
end;

procedure TSdpoPvCamera.SetCameraUID(const AValue: integer);
var
  was_active: boolean;
begin
  if AValue = FUniqueID then
    exit;

  was_active := Active;
  Active := False;
  FUniqueID := AValue;
  Active := was_active;
end;

procedure TSdpoPvCamera.SetCameraModel(const AValue: string);
var
  was_active: boolean;
begin
  if AValue = FModel then
    exit;

  was_active := Active;
  Active := False;
  FModel := AValue;
  Active := was_active;
end;

procedure TSdpoPvCamera.SetCameraPixelFormat;
var
  str1: string;
  str2: string;
begin
  str1 := 'PixelFormat';
  str2 := PvPixelFormatConsts[FPixelFormat];
  SetEnumAttribute(@str1[1], @str2[1]);
end;

procedure TSdpoPvCamera.SetCameraTriggerMode;
var
  str1: string;
  str2: string;
begin
  // Determines how frames are triggered
  str1 := 'FrameStartTriggerMode';
  str2 := PvTriggerModeConsts[FTriggerMode];
  SetEnumAttribute(@str1[1], @str2[1]);
end;

procedure TSdpoPvCamera.SetFrameRate(const AValue: single);
begin
  if AValue = FFrameRate then
    exit;
  FFrameRate := AValue;

  if Active then
    SetCameraFrameRate;
end;

procedure TSdpoPvCamera.SetCameraFrameRate;
var
  str1: string;
begin
  // Determines how frames are triggered
  str1 := 'FrameRate';
  if FFrameRate > 0 then
    SetFloat32Attribute(@str1[1], FFrameRate);
end;

procedure TSdpoPvCamera.SetPixelFormat(const AValue: TPvPixelFormat);
begin
  if AValue = FPixelFormat then
    exit;
  FPixelFormat := AValue;

  if Active then
    SetCameraPixelFormat;
end;

procedure TSdpoPvCamera.SetTriggerMode(const AValue: TPvTriggerMode);
begin
  if AValue = FTriggerMode then
    exit;
  FTriggerMode := AValue;

  if Active then
    SetCameraTriggerMode;
end;

procedure TSdpoPvCamera.SetPacketSize(const AValue: integer);
begin
  if FPacketSize = AValue then
    exit;
  FPacketSize := AValue;

  if Active then
    SetCameraPacketSize;
end;

procedure TSdpoPvCamera.SetCameraPacketSize;
var
  err: tPvErr;
begin
  // Set packet size
  err := PvCaptureAdjustPacketSize(FCamHandle, FPacketSize);
  if (err <> ePvErrSuccess) then begin
    raise Exception.Create('Error while adjusting packet size!');
  end;
end;

procedure TSdpoPvCamera.SetStreamBytesPerSecond(const AValue: integer);
var
  str1: string;
begin
  if FStreamBytesPerSecond = AValue then
    exit;
  FStreamBytesPerSecond := AValue;

  str1 := 'StreamBytesPerSecond';
  if Active then
    SetUint32Attribute(@str1[1], FStreamBytesPerSecond);
end;

procedure TSdpoPvCamera.SetExposureMode(const AValue: TPvExposureMode);
var
  str1, str2: string;
begin
  if FExposureMode = AValue then
    exit;
  FExposureMode := AValue;

  str1 := 'ExposureMode';
  str2 := PvExposureModeConsts[FExposureMode];

  if Active then
    SetEnumAttribute(@str1[1], @str2[1]);
end;

procedure TSdpoPvCamera.SetExposureValue(const AValue: Longword);
var
  str1: string;
begin
  if FExposureValue = AValue then
    exit;
  FExposureValue := AValue;

  str1 := 'ExposureValue';
  if Active then
    SetUint32Attribute(@str1[1], FExposureValue);
end;


procedure TSdpoPvCamera.SetDecimation(const ValueX, ValueY: Longword);
var str1: string;
begin
  str1 := 'DecimationHorizontal';
  if Active then
    SetUint32Attribute(@str1[1], ValueX);

  str1 := 'DecimationVertical';
  if Active then
    SetUint32Attribute(@str1[1], ValueY);
end;


procedure TSdpoPvCamera.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FAPI) then
    API := nil;
  inherited;
end;

{ TSdpoPvAPI }

procedure TSdpoPvAPI.AddDebug(s: string);
begin
  if FDebugList <> nil then
    FDebugList.Add(s);
end;

procedure TSdpoPvAPI.Update;
begin
  if not FInitialized then
    exit;
  DeviceOpen;
end;

function TSdpoPvAPI.GetFirstCamera: PtPvCameraInfoEx;
begin
  if not FInitialized then begin
    Result := nil;
    exit;
  end;

  AddDebug('GetFirstCamera');
  if FCameraNum < 1 then begin
    Result := nil;
  end else begin
    Result := @FCameraList[0];
  end;
end;

function TSdpoPvAPI.GetCameraByUID(uid: culong): PtPvCameraInfoEx;
var
  i: integer;
begin
  if not FInitialized then begin
    Result := nil;
    exit;
  end;

  AddDebug('GetCameraByUID');
  if FCameraNum < 1 then begin
    Result := nil;
  end else begin
    Result := nil;
    for i := 0 to FCameraNum - 1 do begin
      if FCameraList[i].UniqueId = uid then begin
        Result := @FCameraList[i];
        break;
      end;
    end;
  end;
end;

function TSdpoPvAPI.GetCameraByName(model: string): PtPvCameraInfoEx;
var
  i: integer;
  str: string;
begin
  if not FInitialized then begin
    Result := nil;
    exit;
  end;
  AddDebug('GetCameraByName');
  if FCameraNum < 1 then begin
    Result := nil;
  end else begin
    Result := nil;
    for i := 0 to FCameraNum - 1 do begin
      str := CharArrayToString(FCameraList[i].ModelName, 32);
      //AddDebug('Compare: 1 '+str+' 2 '+model);
      if str = model then begin
        Result := @FCameraList[i];
        break;
      end;
    end;
  end;
end;

procedure TSdpoPvAPI.GetAvailableCamerasUID(Sender: TStringList);
var
  Conf: tPvIpSettings;
  lErr: tPvErr;
  i: integer;
begin
  if not FInitialized then
    exit;

  FCameraNum := PvCameraListEx(@FCameraList[0], MAXCAMERALIST, nil, SizeOf(tPvCameraInfoEx));

  for i := 0 to FCameraNum - 1 do begin
    lErr := PvCameraIpSettingsGet(FCameraList[i].UniqueId, @Conf);
    if lErr = ePvErrSuccess then begin
      if (FCameraList[i].PermittedAccess and ePvAccessMaster) > 0 then begin
        Sender.Append(IntToStr(FCameraList[i].UniqueId));
      end;
    end;
  end;
end;

procedure TSdpoPvAPI.ListAvailableCameras;
var
  Conf: tPvIpSettings;
  lErr: tPvErr;
  i: integer;
  //  txt: String;
begin
  if not FInitialized then
    exit;

  FCameraNum := PvCameraListEx(@FCameraList[0], MAXCAMERALIST, nil, SizeOf(tPvCameraInfoEx));

  if FCameraNum > 0 then begin
    for i := 0 to FCameraNum - 1 do begin
      lErr := PvCameraIpSettingsGet(FCameraList[i].UniqueId, @Conf);
      if lErr = ePvErrSuccess then begin
        if (FCameraList[i].PermittedAccess and ePvAccessMaster) > 0 then begin
          AddDebug(CharArrayToString(@FCameraList[i].SerialNumber, 32));
          AddDebug(Format('   Unique ID = %d, available, %d', [FCameraList[i].UniqueId,
            FCameraList[i].PermittedAccess]));
        end else begin
          AddDebug(CharArrayToString(@FCameraList[i].SerialNumber, 32));
          AddDebug(Format('   Unique ID = %d, in use, %d', [FCameraList[i].UniqueId,
            FCameraList[i].PermittedAccess]));
        end;
      end else begin
        AddDebug(CharArrayToString(@FCameraList[i].SerialNumber, 32));
        AddDebug(Format('   Unique ID = %d, unavailable', [FCameraList[i].UniqueId]));
      end;
    end;
  end else
    AddDebug('No cameras detected ...');
end;

procedure TSdpoPvAPI.Open;
begin
  Initialized := True;
end;

procedure TSdpoPvAPI.Close;
begin
  Initialized := False;
end;

procedure TSdpoPvAPI.DeviceOpen;
var
  ret: tPvErr;
begin

  if not FInitialized then begin
    ret := PvInitialize;
    if ret = ePvErrSuccess then begin
      FInitialized := True;
    end else begin
      FInitialized := False;
      //Raise exception
      raise Exception.Create('Could not Initialize PvAPI!');
    end;
  end;

  if FInitialized then begin
    ListAvailableCameras;
    //if FCameraNum = 0 then state := false;
  end;
end;

procedure TSdpoPvAPI.DeviceClose;
begin
  if FInitialized then begin
    PvUnInitialize;
    FInitialized := False;
  end;
end;


procedure TSdpoPvAPI.SetDebugList(dl: TStrings);
begin
  FDebugList := dl;
end;

constructor TSdpoPvAPI.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInitialized := False;
  //FActive:=false;
  //CapThread := nil;
  FDebugList := nil;
  FCameraNum := 0;

  //ret := PvInitialize;
  //if ret = ePvErrSuccess then begin
  //  FInitialized:=true;
  //end else begin
  //  FInitialized:=false;
  //end;
end;

destructor TSdpoPvAPI.Destroy;
begin
  if FInitialized then
    PvUnInitialize;
  inherited Destroy;
end;

//procedure TSdpoPvAPI.SetActive(state: boolean);
//begin
//  if state=FActive then exit;

//  if state then DeviceOpen(state)
//  else DeviceClose;

//  FActive:=state;
//end;

procedure TSdpoPvAPI.SetInitialized(state: boolean);
begin
  if state = FInitialized then
    exit;

  if state then
    DeviceOpen
  else
    DeviceClose;

  //FInitialized:=state;
end;

// ---------------------------------------------------------------
//     Capture Thread Code

procedure TSdpoPvCameraCaptureThread.CallEvent;
begin
  if Assigned(Owner.FOnFrame) then begin
    Owner.FCurFrame := VideoBufferIndex;
    Owner.FOnFrame(Owner, PByte(Owner.FFrames[VideoBufferIndex].ImageBuffer));
  end;
end;

procedure TSdpoPvCameraCaptureThread.Execute;
var
  errCode: tPvErr;
  Last: culong;
begin
  Owner.CapThreadPID := fpGetPID;
  Owner.FClosing := False;
  CurFrame := 0;
  Last := 0;
  while not Terminated do begin

    errCode := PvCaptureWaitForFrameDone(Owner.FCamHandle, @Owner.FFrames[CurFrame], 100);

    if errCode <> ePvErrTimeout then begin
      if errCode <> ePvErrSuccess then begin
        break;
      end else begin  // frame success
        //if Owner.FFrames[CurFrame].Status <> ePvErrSuccess then ;

        if Owner.FFrames[CurFrame].Status <> ePvErrCancelled then begin

          //Check for gaps in FrameCount due to image returning from camera with no frame queued.
          //This should never happen, as we use a multiple frame circular buffer.
          if Last + 1 <> Owner.FFrames[CurFrame].FrameCount then begin
            //Note missing frame
            //GCamera.Discarded++;
          end;

          Last := Owner.FFrames[CurFrame].FrameCount;

          VideoBufferIndex := CurFrame;
          Synchronize(@CallEvent);

          //Requeue [Index] frame of FRAMESCOUNT num frames
          errCode := PvCaptureQueueFrame(Owner.FCamHandle, @Owner.FFrames[CurFrame], nil);

          if errCode <> ePvErrSuccess then begin
            break;
          end else begin
            Inc(CurFrame);
            if CurFrame = FRAMESCOUNT then
              CurFrame := 0;
          end;
        end else begin
          break;
        end;
      end;
    end;
  end;

  if not Owner.FClosing then begin
    FreeOnTerminate := False;
    Owner.FActive := False;
    Owner.FAPI.Update;
    Owner.UnSetup;
    Terminate;
  end;

  Owner.FClosing := False;
end;


initialization

{$i sdpopvapi.lrs}

end.

























































































