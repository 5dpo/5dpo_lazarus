{ SdpoVideo4l2 v0.1.2

  CopyRight (C) 2007-2008 Paulo Costa, Paulo Malheiros and Paulo Marques,
  Bernd Kreuss (libv4l2 integration)

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
  me at paco@fe.up.pt
}
unit SdpoVideo4L2;

{$mode objfpc}{$H+}

interface

uses videodev2, Classes, SysUtils, LResources, Forms, BaseUnix, dynlibs;

const
  VIDEO_BUFFERS = 4;

  // --> NOTE: To use V4L2 controls add 'videodev2' in uses section of your project

  // raw bayer controls
  V4L2_CID_DISABLE_COLOR_PROCESSING =	(V4L2_CID_PRIVATE_BASE+14);
  V4L2_CID_RAW_DATA_BITS_PER_PIXEL  =	(V4L2_CID_PRIVATE_BASE+15);

type
  TUVCPixelFormat=(uvcpf_RGB332,uvcpf_RGB555
      ,uvcpf_RGB565,uvcpf_RGB555X,uvcpf_RGB565X,uvcpf_BGR24
      ,uvcpf_RGB24,uvcpf_BGR32,uvcpf_RGB32,uvcpf_GREY
      ,uvcpf_YVU410,uvcpf_YVU420,uvcpf_YUYV,uvcpf_UYVY
      ,uvcpf_YUV422P,uvcpf_YUV411P,uvcpf_Y41P,uvcpf_NV12
      ,uvcpf_NV21,uvcpf_YUV410,uvcpf_YUV420,uvcpf_YYUV
      ,uvcpf_HI240,uvcpf_SBGGR8,uvcpf_MJPEG,uvcpf_JPEG
      ,uvcpf_DV,uvcpf_MPEG,uvcpf_WNVA,uvcpf_SN9C10X);

  TUVCPixelFormatFunc = function : LongInt;

const
  ConstsUVCPixelFormat: array[TUVCPixelFormat] of TUVCPixelFormatFunc = (@V4L2_PIX_FMT_RGB332,@V4L2_PIX_FMT_RGB555
      ,@V4L2_PIX_FMT_RGB565,@V4L2_PIX_FMT_RGB555X,@V4L2_PIX_FMT_RGB565X,@V4L2_PIX_FMT_BGR24
      ,@V4L2_PIX_FMT_RGB24,@V4L2_PIX_FMT_BGR32,@V4L2_PIX_FMT_RGB32,@V4L2_PIX_FMT_GREY
      ,@V4L2_PIX_FMT_YVU410,@V4L2_PIX_FMT_YVU420,@V4L2_PIX_FMT_YUYV,@V4L2_PIX_FMT_UYVY
      ,@V4L2_PIX_FMT_YUV422P,@V4L2_PIX_FMT_YUV411P,@V4L2_PIX_FMT_Y41P,@V4L2_PIX_FMT_NV12
      ,@V4L2_PIX_FMT_NV21,@V4L2_PIX_FMT_YUV410,@V4L2_PIX_FMT_YUV420,@V4L2_PIX_FMT_YYUV
      ,@V4L2_PIX_FMT_HI240,@V4L2_PIX_FMT_SBGGR8,@V4L2_PIX_FMT_MJPEG,@V4L2_PIX_FMT_JPEG
      ,@V4L2_PIX_FMT_DV,@V4L2_PIX_FMT_MPEG,@V4L2_PIX_FMT_WNVA,@V4L2_PIX_FMT_SN9C10X);

type
  TSdpoVideo4L2FrameEvent = procedure(Sender: TObject; FramePtr: PByte) of object;

type
  TSdpoVideo4L2 = class;

  TSdpoVideo4L2CaptureThread=class(TThread)
  public
    Owner: TSdpoVideo4L2;
    CurFrame: integer;
    VideoBufferIndex: integer;
  protected
    procedure CallEvent;
    procedure Execute; override;
  end;

  { TSdpoVideo4L2 }

  TSdpoVideo4L2=class(TComponent)
  private
    FOnFrame: TSdpoVideo4L2FrameEvent;

    FActive: boolean;
    FHandle: integer;
    FDevice: string;
    FWidth, FHeight: integer;
    FFrameRate: integer;
    FBayerMode: boolean;
    FPixelFormat: TUVCPixelFormat;

    // structures to hold video parameters
    DebugList: TStrings;

    CapThread: TSdpoVideo4L2CaptureThread;
    //CapThreadPID: __pid_t;
    CapThreadPID: TPid;

    VideoBuffer: array[0..VIDEO_BUFFERS - 1] of pbyte;
    VideoBufferLength: integer;

    // these pocedure addresses can be pointed to the libv4l2 wrapper
    // or to the built in RTL functions, depending on the UseLibv4l property
    FDynOpen: function (path: PChar; flags: cInt): cInt; cdecl;
    FDynClose: function (fd: cInt): cInt; cdecl;
    FDynIoctl: function (fd: cInt; Ndx: TIOCtlRequest; Data: Pointer): cInt; cdecl;
    FDynMmap: function (start: pointer; len: size_t; prot: cint; flags: cint; fd: cint; offst: off_t): pointer; cdecl;
    FDynMunmap: function (start: pointer; len: size_t): cInt; cdecl;
    FLibv4lHandle: TLibHandle;
    FUseLibv4l: Boolean;

    procedure ResetProcAddresses;
    procedure SetUseLibv4l(Use: Boolean);

    procedure DeviceOpen;
    procedure DeviceClose;
    procedure SetActive(state: boolean);

  public
    FClosing: boolean;
    UserControls: array of v4l2_queryctrl;
  
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Open;
    procedure Close;

    procedure SetDevice(devname: string);
    procedure SetFrameRate(value: integer);
    procedure SetBayerMode(value: boolean);
    procedure SetPixelFormat(value: TUVCPixelFormat);

    procedure SetDebugList(dl: TStrings);
    procedure AddDebug(s: string);

    procedure GetUserControls;
    function GetFeatureValue(feature: LongWord): integer;
    procedure SetFeatureValue(feature: LongWord; value: integer);
    function TrySetFeatureValue(feature: LongWord; value: integer): boolean;
    function Ioctl(Request: TIOCtlRequest; Data: Pointer): Integer;
  published
    property Active: boolean read FActive write SetActive;
    property Handle: integer read FHandle;
    property Device: string read FDevice write SetDevice;
    property Width: integer read FWidth write FWidth;
    property Height: integer read FHeight write FHeight;
    property FrameRate: integer read FFrameRate write SetFrameRate;
    property BayerMode: boolean read FBayerMode write SetBayerMode;
    property PixelFormat: TUVCPixelFormat read FPixelFormat write SetPixelFormat;
    property UseLibV4l: Boolean read FUseLibv4l write SetUseLibv4l;

    property OnFrame: TSdpoVideo4L2FrameEvent read FOnFrame write FOnFrame;
  end;

procedure Register;


implementation

{ we need these functions with cdecl calling convention, so we can simply
  swap their addresses at runtime with their counterparts from libv4l2
  if the user sets UseLibv4l to True. }

function _FpOpen(path: PChar; flags: cInt): cInt; cdecl;
begin
  Result := FpOpen(path, flags);
end;

function _FpClose(fd: cInt): cInt; cdecl;
begin
  Result := FpClose(fd);
end;

function _FpIOCtl(Handle: cint; Ndx: TIOCtlRequest; Data: Pointer): cint; cdecl;
begin
  Result := FpIOCtl(Handle, Ndx, Data);
end;

function _Fpmmap(start: pointer; len: size_t; prot: cint; flags: cint; fd: cint; offst: off_t): pointer; cdecl;
begin
  Result := Fpmmap(start, len, prot, flags, fd, offst);
end;

function _Fpmunmap(start: pointer; len: size_t): cint; cdecl;
begin
  Result := Fpmunmap(start, len);
end;

procedure Register;
begin
  RegisterComponents('5dpo',[TSdpoVideo4L2]);
end;

{ TSdpoVideo4L2 }

procedure TSdpoVideo4L2.AddDebug(s: string);
begin
  if DebugList<>nil then DebugList.Add(s);
end;

procedure TSdpoVideo4L2.Close;
begin
  Active:=false;
end;

constructor TSdpoVideo4L2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ResetProcAddresses;
  FLibv4lHandle := NilHandle;
  FHandle := -1;
  CapThread := nil;
  DebugList := nil;
  FFrameRate := 25;
  FClosing := false;
  FPixelFormat := uvcpf_YUYV;
end;

destructor TSdpoVideo4L2.Destroy;
begin
  Close;
  if FUseLibv4l and (FLibv4lHandle <> NilHandle) then
    UnloadLibrary(FLibv4lHandle);
  inherited Destroy;
end;


procedure TSdpoVideo4L2.SetPixelFormat(value: TUVCPixelFormat);
var was_active: boolean;
begin
  if value=FPixelFormat then exit;
  was_active:=Active;
  Active:=false;
  FPixelFormat:=value;
  Active:=was_active;
end;


procedure TSdpoVideo4L2.GetUserControls;
var queryctrl: v4l2_queryctrl;
    i, id, cnt: integer;
begin
  if FHandle = -1 then exit;

  // Dry run to find how many controls are available
  cnt := 0;
  fillbyte(queryctrl, sizeof(queryctrl), 0);
  queryctrl.id := V4L2_CTRL_FLAG_NEXT_CTRL;
  while FDynIoctl(FHandle, VIDIOC_QUERYCTRL, @queryctrl) = 0 do begin
    AddDebug(pchar(@queryctrl.name[0]) + format(' (%d): [%d, %d]',[queryctrl._type, queryctrl.minimum, queryctrl.maximum] ));
    id := queryctrl.id or V4L2_CTRL_FLAG_NEXT_CTRL;
    fillbyte(queryctrl, sizeof(queryctrl), 0);
    queryctrl.id := id;
    inc(cnt);
  end;

  // Now fill the UserControls array with the ones available
  i := 0;
  SetLength(UserControls, cnt);
  fillbyte(queryctrl, sizeof(queryctrl), 0);
  queryctrl.id := V4L2_CTRL_FLAG_NEXT_CTRL;
  while FDynIoctl(FHandle, VIDIOC_QUERYCTRL, @queryctrl) = 0 do begin
    UserControls[i] := queryctrl;
    id := queryctrl.id or V4L2_CTRL_FLAG_NEXT_CTRL;
    fillbyte(queryctrl, sizeof(queryctrl), 0);
    queryctrl.id := id;
    inc(i);
  end;

end;


procedure TSdpoVideo4L2.DeviceOpen;
var fmt: v4l2_format;
    parms: v4l2_streamparm;
    reqbuf: v4l2_requestbuffers;
    vbuf: v4l2_buffer;
    i: integer;
begin
  FHandle := FDynOpen(pchar(FDevice), O_RDWR);
  if FHandle = -1 then
    raise Exception.create('could not open video device ' + FDevice);

  try
    // set video format
    FillChar(fmt, sizeof(v4l2_format), 0);
    fmt._type := V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width := FWidth;
    fmt.fmt.pix.height := FHeight;
    {if FPixelFormat = uvcpf_GREY then
      fmt.fmt.pix.pixelformat := V4L2_PIX_FMT_GREY
    else
      fmt.fmt.pix.pixelformat := V4L2_PIX_FMT_YUYV;}

    fmt.fmt.pix.pixelformat := ConstsUVCPixelFormat[FPixelFormat]();

    fmt.fmt.pix.field := V4L2_FIELD_ANY;
    if FDynIoctl(FHandle, VIDIOC_S_FMT, @fmt) < 0 then
      raise Exception.Create('could not set video format');

    // set the proterty values to what the driver was able to provide
    FWidth := fmt.fmt.pix.width;
    FHeight := fmt.fmt.pix.height;

    // set frame rate
    FillChar(parms, sizeof(v4l2_streamparm), 0);
    parms._type := V4L2_BUF_TYPE_VIDEO_CAPTURE;
    parms.parm.capture.timeperframe.numerator := 1;
    parms.parm.capture.timeperframe.denominator := FFrameRate;
    if FDynIoctl(FHandle, VIDIOC_S_PARM, @parms) = -1 then
      raise Exception.Create('could not set desired frame rate');

    // set up buffers
    FillChar(reqbuf, sizeof(v4l2_requestbuffers), 0);
    reqbuf.count := VIDEO_BUFFERS;
    reqbuf._type := V4L2_BUF_TYPE_VIDEO_CAPTURE;
    reqbuf.memory := V4L2_MEMORY_MMAP;
    if FDynIoctl(FHandle, VIDIOC_REQBUFS, @reqbuf) < 0 then
      raise Exception.Create('could not set up video buffers');

    // mmap the buffers into process memory
    for i := 0 to VIDEO_BUFFERS - 1 do begin
      FillChar(vbuf, sizeof(v4l2_buffer), 0);
      vbuf.index := i;
      vbuf._type := V4L2_BUF_TYPE_VIDEO_CAPTURE;
      vbuf.memory := V4L2_MEMORY_MMAP;
      if FDynIoctl(FHandle, VIDIOC_QUERYBUF, @vbuf) < 0 then
        raise Exception.Create('Could not query video buffer');

      VideoBufferLength:=vbuf.length;
      VideoBuffer[i] := FDynMmap(nil, vbuf.length, PROT_READ, MAP_SHARED, FHandle, vbuf.m.offset);
      if VideoBuffer[i] = MAP_FAILED then
        raise Exception.Create('Could not mmap video buffer');
    end;

    // queue the buffers
    for i := 0 to VIDEO_BUFFERS - 1 do begin
      FillChar(vbuf, sizeof(v4l2_buffer), 0);
      vbuf.index := i;
      vbuf._type := V4L2_BUF_TYPE_VIDEO_CAPTURE;
      vbuf.memory := V4L2_MEMORY_MMAP;
      if FDynIoctl(FHandle, VIDIOC_QBUF, @vbuf) < 0 then
        raise Exception.Create('Could not queue video buffer');
    end;

    // set bayer mode
    if FBayerMode then begin
      SetFeatureValue(V4L2_CID_DISABLE_COLOR_PROCESSING, ord(FBayerMode));
      if FBayerMode then
        SetFeatureValue(V4L2_CID_RAW_DATA_BITS_PER_PIXEL, 0); // set 8 bits per pixel
    end;


    i := V4L2_BUF_TYPE_VIDEO_CAPTURE;
    if FDynIoctl(FHandle, VIDIOC_STREAMON, @i) < 0 then
      raise Exception.Create('Could not start streaming');

    // launch capture thread
    CapThread := TSdpoVideo4L2CaptureThread.Create(true);
    CapThread.Owner := Self;
    CapThread.Resume;

  except on
    E: exception do begin
      FDynClose(FHandle);
      FHandle := -1;
      AddDebug(E.message);
    end;
  end;
end;

procedure TSdpoVideo4L2.DeviceClose;
var value,i: integer;
begin
  // stop capture thread
  if CapThread <> nil then begin
    CapThread.FreeOnTerminate:=false;
    FClosing:=true;
    CapThread.Terminate;
    //CapThread.WaitFor;   // TODO: dar um timeout simpatico se a thread pendurar
    while FClosing do begin
      Application.ProcessMessages;
    end;
    CapThread.Free;
    CapThread:=nil;
  end;

  if FHandle <> -1 then begin
    value := V4L2_BUF_TYPE_VIDEO_CAPTURE;
    FDynIoctl(FHandle, VIDIOC_STREAMOFF, @value);

    for i := 0 to VIDEO_BUFFERS - 1 do begin
      if VideoBuffer[i] <> MAP_FAILED then
        FDynMunmap(VideoBuffer[i],VideoBufferLength);
    end;

    FDynClose(FHandle);
    FHandle := -1;
  end;
end;

procedure TSdpoVideo4L2.Open;
begin
  Active:=true;
end;

procedure TSdpoVideo4L2.SetActive(state: boolean);
begin
  if state=FActive then exit;

  if state then DeviceOpen
  else DeviceClose;

  FActive:=state;
end;

procedure TSdpoVideo4L2.ResetProcAddresses;
begin
  FDynOpen := @_FpOpen;
  FDynClose := @_FpClose;
  FDynIoctl := @_FpIOCtl;
  FDynMmap := @_Fpmmap;
  FDynMunmap := @_Fpmunmap;
end;

procedure TSdpoVideo4L2.SetUseLibv4l(Use: Boolean);
begin
  if Use and (not FUseLibv4l) then begin
    FLibv4lHandle := LoadLibrary('libv4l2.so.0');
    if FLibv4lHandle = NilHandle then
      raise Exception.Create('Could not load libv4l2.so.0');
    Pointer(FDynOpen) := GetProcAddress(FLibv4lHandle, 'v4l2_open');
    Pointer(FDynClose) := GetProcAddress(FLibv4lHandle, 'v4l2_close');
    Pointer(FDynIoctl) := GetProcAddress(FLibv4lHandle, 'v4l2_ioctl');
    Pointer(FDynMmap) := GetProcAddress(FLibv4lHandle, 'v4l2_mmap');
    Pointer(FDynMunmap) := GetProcAddress(FLibv4lHandle, 'v4l2_munmap');
    FUseLibv4l := True;
  end;
  if (not use) and FUseLibv4l then begin
    ResetProcAddresses;
    UnloadLibrary(FLibv4lHandle);
    FUseLibv4l := False;
  end;
end;

procedure TSdpoVideo4L2.SetDebugList(dl: TStrings);
begin
  DebugList:=dl;
end;

procedure TSdpoVideo4L2.SetDevice(devname: string);
var was_active: boolean;
begin
  if devname = FDevice then exit;
  was_active := Active;
  Active := false;
  FDevice := devname;
  Active := was_active;
end;

procedure TSdpoVideo4L2.SetFrameRate(value: integer);
var was_active: boolean;
begin
  if value = FFrameRate then exit;
  was_active := Active;
  Active := false;
  FFrameRate := value;
  Active := was_active;
end;

procedure TSdpoVideo4L2.SetBayerMode(value: boolean);
var was_active: boolean;
begin
  if value = FBayerMode then exit;
  was_active := Active;
  Active := false;
  FBayerMode := value;
  Active := was_active;
end;

function TSdpoVideo4L2.GetFeatureValue(feature: LongWord): integer;
var control_s: v4l2_control;
begin
  result := 0;
  if FHandle = -1 then exit;
  control_s.id := feature;
  if FDynIoctl(FHandle, VIDIOC_G_CTRL, @control_s) < 0 then
    raise Exception.Create('Could not get feature '+ inttohex(feature, 8));
  result := control_s.value;
end;

procedure TSdpoVideo4L2.SetFeatureValue(feature: LongWord; value: integer);
var control_s: v4l2_control;
begin
  if FHandle = -1 then exit;
  control_s.id := feature;
  control_s.value := value;
  if FDynIoctl(FHandle, VIDIOC_S_CTRL, @control_s) < 0 then
    raise Exception.Create('Could not set feature '+ inttohex(feature, 8) + ' to value ' + inttostr(value));
end;

function TSdpoVideo4L2.TrySetFeatureValue(feature: LongWord; value: integer): boolean;
var control_s: v4l2_control;
begin
  result := false;
  if FHandle = -1 then exit;
  control_s.id := feature;
  control_s.value := value;
  if not (FDynIoctl(FHandle, VIDIOC_S_CTRL, @control_s) < 0) then
    result := true;
end;

function TSdpoVideo4L2.Ioctl(Request: TIOCtlRequest; Data: Pointer): Integer;
begin
  Result := FDynIoctl(FHandle, Request, Data);
end;


// ---------------------------------------------------------------
//     Capture Thread Code

procedure TSdpoVideo4L2CaptureThread.CallEvent;
begin
  if Assigned(Owner.FOnFrame) then
    Owner.FOnFrame(Owner,Owner.VideoBuffer[VideoBufferIndex]);
end;

procedure TSdpoVideo4L2CaptureThread.Execute;
var vbuf: v4l2_buffer;
begin
  Owner.CapThreadPID := fpGetPID;

  CurFrame := 0;
  while not Terminated do begin
    // get the ready to use buffer
    FillChar(vbuf, sizeof(v4l2_buffer), 0);
    vbuf._type := V4L2_BUF_TYPE_VIDEO_CAPTURE;
    vbuf.memory := V4L2_MEMORY_MMAP;
    if Owner.FDynIoctl(Owner.FHandle, VIDIOC_DQBUF, @vbuf) < 0 then
    //if Owner.FDynIoctl(Owner.FHandle, VIDIOC_QBUF, @vbuf) < 0 then
      break;

    // if there was no data, don't send it upwards
    if vbuf.bytesused > 0 then begin
      VideoBufferIndex := vbuf.index;
      Synchronize(@CallEvent);
    end;

    // re-submit the buffer
    if Owner.FDynIoctl(Owner.FHandle, VIDIOC_QBUF, @vbuf) < 0 then
      break;

    Inc(CurFrame);
  end;
  
  Owner.FClosing:=false;
end;

initialization
{$i TSdpoVideo4L2.lrs}

end.
