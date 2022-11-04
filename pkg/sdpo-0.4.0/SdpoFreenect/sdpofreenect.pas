{ SdpoFreenect v1

  CopyRight (C) 2011 Paulo Costa

  This library is Free software; you can rediStribute it and/or modify it
  under the terms of the GNU Library General Public License (LGPL) as published
  by the Free Software Foundation; either version 2 of the License, or (at your
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
unit sdpofreenect;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, LResources, Forms, BaseUnix, freenect, LCLIntf;

const
  VIDEO_BUFFERS = 4;

type
  FreenectVideoFormat = (
    FREENECT_VIDEO_RGB := 0,
    FREENECT_VIDEO_BAYER := 1,
    FREENECT_VIDEO_IR_8BIT := 2,
    FREENECT_VIDEO_IR_10BIT := 3,
    FREENECT_VIDEO_IR_10BIT_PACKED := 4,
    FREENECT_VIDEO_YUV_RGB := 5,
    FREENECT_VIDEO_YUV_RAW := 6
  );

type
  TSdpoFreenectFrameEvent = procedure(Sender: TObject; FramePtr: PByte) of object;

type
  TSdpoFreenect = class;

  TSdpoFreenectCaptureThread = class(TThread)
  public
    Owner: TSdpoFreenect;
    insideVideoCallback: integer;
    VideoBufferIndex, DepthBufferIndex: integer;
    EventedVideoBufferIndex, EventedDepthBufferIndex: integer;
  protected

    procedure CallVideoEvent;
    procedure CallDepthEvent;
    procedure Execute; override;
  end;

  { TSdpoFreenect }

  TSdpoFreenect = class(TComponent)
  private
    FOnVideoFrame: TSdpoFreenectFrameEvent;
    FOnDepthFrame: TSdpoFreenectFrameEvent;
    FVideo, FDepth: boolean;
    FVideoTimeStamp, FDepthTimeStamp: uint32_t;

    f_ctx: Pfreenect_context;
    f_dev: Pfreenect_device;
    freenect_led: integer;

    FActive: boolean;
    FUpdatePeriod: integer;
    FOrientationSystem: boolean;

    FVideoWidth, FVideoHeight: integer;
    FDepthWidth, FDepthHeight: integer;

    FCurrentVideoFormat, FRequestedVideoFormat: freenect_video_format;

    FUserDeviceNumber: integer;
    FDevicesCount: integer;
    FAccelerometerX, FAccelerometerY, FAccelerometerZ, FTilt: double;
    FRequestedTilt, FTiltReference: double;
    FTiltStatus: freenect_tilt_status_code;

    DebugList: TStrings;

    CapThread: TSdpoFreenectCaptureThread;
    CapThreadPID: TPid;

    VideoBuffer: array[0..VIDEO_BUFFERS - 1] of pbyte;
    VideoBufferLength: integer;
    DepthBuffer: array[0..VIDEO_BUFFERS - 1] of pbyte;
    DepthBufferLength: integer;

    procedure DeviceOpen;
    procedure DeviceClose;
    procedure SetActive(state: boolean);

  public
    FClosing: boolean;
    ProcessEventsCount: integer;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Open;
    procedure Close;

    procedure SetDeviceNumber(devNum: integer);
    procedure SetVideo(videoOn: boolean);
    procedure SetDepth(depthOn: boolean);
    procedure SetVideoFormat(newVideoFormat: FreenectVideoFormat);
    function GetVideoFormat: FreenectVideoFormat;

    procedure SetDebugList(dl: TStrings);
    procedure AddDebug(s: string);

    property Device: Pfreenect_device read f_dev;
    property VideoWidth: integer read FVideoWidth;
    property VideoHeight: integer read FVideoHeight;
    property DepthWidth: integer read FDepthWidth;
    property DepthHeight: integer read FDepthHeight;

    property AccelerometerX: double read FAccelerometerX;
    property AccelerometerY: double read FAccelerometerY;
    property AccelerometerZ: double read FAccelerometerZ;
    property Tilt: double read FTilt;
    property TiltStatus: freenect_tilt_status_code read FTiltStatus;

    property VideoTimeStamp: uint32_t read FVideoTimeStamp;
    property DepthTimeStamp: uint32_t read FDepthTimeStamp;


  published
    property Active: boolean read FActive write SetActive;
    property DeviceNumber: integer read FUserDeviceNumber write SetDeviceNumber;
    property Video: boolean read FVideo write SetVideo default true;
    property Depth: boolean read FDepth write SetDepth default true;
    property VideoFormat: FreenectVideoFormat read getVideoFormat write SetVideoFormat;
    property TiltReference: double read FTiltReference write FRequestedTilt;
    property UpdateTiltPeriod: integer read FUpdatePeriod write FUpdatePeriod;
    property OrientationSystem: boolean read FOrientationSystem write FOrientationSystem;

    property OnDepthFrame: TSdpoFreenectFrameEvent read FOnDepthFrame write FOnDepthFrame;
    property OnVideoFrame: TSdpoFreenectFrameEvent read FOnVideoFrame write FOnVideoFrame;
  end;

procedure Register;


implementation


procedure Register;
begin
  RegisterComponents('5dpo',[TSdpoFreenect]);
end;

{ TSdpoFreenect }

procedure TSdpoFreenect.AddDebug(s: string);
begin
  if DebugList<>nil then DebugList.Add(s);
end;

procedure TSdpoFreenect.Close;
begin
  Active:=false;
end;

constructor TSdpoFreenect.Create(AOwner: TComponent);
var i: integer;
begin
  inherited Create(AOwner);
  CapThread := nil;
  DebugList := nil;
  FUpdatePeriod := 60;
  FClosing := false;

  // TODO: fix this with the right structure
  FVideoWidth := 640;
  FVideoheight := 480;
  VideoBufferLength := FVideoWidth * FVideoheight * 3;

  FDepthWidth := 640;
  FDepthheight := 480;
  DepthBufferLength := FDepthWidth * FDepthheight * 3;

  for i := 0 to VIDEO_BUFFERS - 1 do begin
    getmem(VideoBuffer[i], VideoBufferLength);
    getmem(depthBuffer[i], depthBufferLength);
  end;

  FVideo := true;
  FDepth := true;
end;

destructor TSdpoFreenect.Destroy;
var i: integer;
begin
  for i := 0 to VIDEO_BUFFERS - 1 do begin
    freemem(VideoBuffer[i]);
    freemem(depthBuffer[i]);
  end;
  Close;
  inherited Destroy;
end;


procedure updateAccelerometer(freenect: TSdpoFreenect);
var state: Pfreenect_raw_tilt_state;
begin
  with freenect do begin
    freenect_update_tilt_state(f_dev);
    state := freenect_get_tilt_state(f_dev);
    freenect_get_mks_accel(state, @FAccelerometerX, @FAccelerometerY, @FAccelerometerZ);

    FTiltStatus := freenect_get_tilt_status(state);
    if state^.tilt_angle <> -128 then begin // mostly when moving a -128 value appears and should not be shown?
      FTilt := freenect_get_tilt_degs(state);
    end;

    if FTiltReference <> FRequestedTilt then begin
      FTiltReference := FRequestedTilt;
      freenect_set_tilt_degs(f_dev, FRequestedTilt);
    end;
  end;
end;

//void depth_cb(freenect_device *dev, freenect_depth *depth, uint32_t timestamp)
procedure videoCallback(dev: Pfreenect_device; depth: Pointer; timestamp: uint32_t); cdecl;
var freenect: TSdpoFreenect;
begin
  freenect := TSdpoFreenect(freenect_get_user(dev));

  freenect.CapThread.EventedVideoBufferIndex := freenect.CapThread.VideoBufferIndex; // Get current buffer
  inc(freenect.CapThread.VideoBufferIndex);    // Swap to the next
  if freenect.CapThread.VideoBufferIndex >= VIDEO_BUFFERS then
    freenect.CapThread.VideoBufferIndex := 0;
  freenect_set_video_buffer(freenect.f_dev, freenect.VideoBuffer[freenect.CapThread.VideoBufferIndex]);

  freenect.FVideoTimeStamp := timestamp;
  freenect.CapThread.Synchronize(@(freenect.CapThread.CallVideoEvent));
end;

procedure depthCallback(dev: Pfreenect_device; video: Pointer; timestamp: uint32_t); cdecl;
var freenect: TSdpoFreenect;
begin
  freenect := TSdpoFreenect(freenect_get_user(dev));

  freenect.CapThread.EventedDepthBufferIndex := freenect.CapThread.DepthBufferIndex; // Get current buffer
  inc(freenect.CapThread.DepthBufferIndex);    // Swap to the next
  if freenect.CapThread.DepthBufferIndex >= VIDEO_BUFFERS then
    freenect.CapThread.DepthBufferIndex := 0;
  freenect_set_depth_buffer(freenect.f_dev, freenect.DepthBuffer[freenect.CapThread.DepthBufferIndex]);

  freenect.FDepthTimeStamp := timestamp;
  freenect.CapThread.Synchronize(@(freenect.CapThread.CallDepthEvent));
end;



procedure TSdpoFreenect.DeviceOpen;
var ret: integer;
    freenect_angle: double;
    s: string;
begin
  AddDebug('init');

  ret := freenect_init(@f_ctx, nil);
  if (ret < 0) then begin
    raise Exception.create('freenect_init() failed');
  end;

  try
    freenect_set_log_level(f_ctx, FREENECT_LOG_DEBUG);
    if FOrientationSystem then begin
      freenect_select_subdevices(f_ctx, freenect_device_flags(ord(FREENECT_DEVICE_MOTOR) or ord(FREENECT_DEVICE_CAMERA)));
    end else begin
      freenect_select_subdevices(f_ctx, FREENECT_DEVICE_CAMERA); //Only the camera
    end;

    FDevicesCount := freenect_num_devices(f_ctx);
    AddDebug(format('Number of devices found: %d', [FDevicesCount]));

    FUserDeviceNumber := 0;
    if (FDevicesCount < 1) then begin
      raise Exception.create('Bad number of devices: ' + inttostr(FUserDeviceNumber));
    end;

    if (freenect_open_device(f_ctx, @f_dev, FUserDeviceNumber) < 0) then begin
      raise Exception.create(format('Could not open device number %d!', [FUserDeviceNumber]));
    end;

    if FOrientationSystem then begin
      freenect_angle := 0;
      freenect_set_tilt_degs(f_dev, freenect_angle);
      freenect_set_led(f_dev, LED_RED); // If the motor is diabled the LED is also disabled ???
    end;

    freenect_set_depth_callback(f_dev, @depthCallback);
    freenect_set_video_callback(f_dev, @videoCallback);

    freenect_set_user(f_dev, self); // "pointer" to this TSdpoFreenect class

    freenect_set_video_mode(f_dev, freenect_find_video_mode(FREENECT_RESOLUTION_MEDIUM, FRequestedVideoFormat));
    FCurrentVideoFormat := freenect_get_current_video_mode(f_dev)._i0.video_format;
    if FCurrentVideoFormat <> FRequestedVideoFormat then begin
      writestr(s, FRequestedVideoFormat);
      raise Exception.create(format('Could not Set Video Format: %s', [s]));
    end;

    freenect_set_depth_mode(f_dev, freenect_find_depth_mode(FREENECT_RESOLUTION_MEDIUM, FREENECT_DEPTH_11BIT));

    // launch capture thread
    CapThread := TSdpoFreenectCaptureThread.Create(true);  // Create it suspended
    CapThread.Owner := Self;

    CapThread.VideoBufferIndex := 0;
    CapThread.DepthBufferIndex := 0;

    freenect_set_video_buffer(f_dev, VideoBuffer[CapThread.VideoBufferIndex]);
    freenect_set_depth_buffer(f_dev, DepthBuffer[CapThread.DepthBufferIndex]);

    if FDepth then freenect_start_depth(f_dev);
    if FVideo then freenect_start_video(f_dev);

    CapThread.Resume;

  except on
    E: exception do begin
      freenect_shutdown(f_ctx);
      ret := -1;
      AddDebug(E.message);
    end;
  end;
end;

procedure TSdpoFreenect.DeviceClose;
begin

  // stop capture thread
  if CapThread <> nil then begin
    CapThread.FreeOnTerminate:=false;
    FClosing:=true;
    CapThread.Terminate;
    //CapThread.WaitFor;
    while FClosing do begin // TODO: nice timeout for a hanged thread...
      Application.ProcessMessages;
    end;

    if FVideo then freenect_stop_video(f_dev);
    if FDepth then freenect_stop_depth(f_dev);

    freenect_close_device(f_dev);
    freenect_shutdown(f_ctx);

    CapThread.Free;
    CapThread:=nil;
  end;

end;

procedure TSdpoFreenect.Open;
begin
  Active:=true;
end;

procedure TSdpoFreenect.SetActive(state: boolean);
begin
  if state=FActive then exit;

  if state then DeviceOpen
  else DeviceClose;

  FActive:=state;
end;


procedure TSdpoFreenect.SetDebugList(dl: TStrings);
begin
  DebugList := dl;
end;

procedure TSdpoFreenect.SetDeviceNumber(devNum: integer);
var was_active: boolean;
begin
  if devNum = FUserDeviceNumber then exit;
  was_active := Active;
  Active := false;
  FUserDeviceNumber := devNum;
  Active := was_active;
end;

procedure TSdpoFreenect.SetVideo(videoOn: boolean);
var was_active: boolean;
begin
  if videoOn = FVideo then exit;
  was_active := Active;
  Active := false;
  FVideo := videoOn;
  Active := was_active;
end;


procedure TSdpoFreenect.SetDepth(depthOn: boolean);
var was_active: boolean;
begin
  if depthOn = FDepth then exit;
  was_active := Active;
  Active := false;
  FDepth := depthOn;
  Active := was_active;
end;

procedure TSdpoFreenect.SetVideoFormat(newVideoFormat: FreenectVideoFormat);
begin
  FRequestedVideoFormat := freenect_video_format(newVideoFormat);
  if not FActive then begin
    FCurrentVideoFormat := FRequestedVideoFormat;
  end;
end;

function TSdpoFreenect.GetVideoFormat: FreenectVideoFormat;
begin
  result := FreenectVideoFormat(FCurrentVideoFormat);
end;



// ---------------------------------------------------------------
//     Capture Thread Code

procedure TSdpoFreenectCaptureThread.CallVideoEvent;
begin
  if Assigned(Owner.FOnVideoFrame) then
    Owner.FOnVideoFrame(Owner, Owner.VideoBuffer[EventedVideoBufferIndex]);
end;


procedure TSdpoFreenectCaptureThread.CallDepthEvent;
begin
  if Assigned(Owner.FOnDepthFrame) then
    Owner.FOnDepthFrame(Owner, Owner.DepthBuffer[EventedDepthBufferIndex]);
end;


procedure TSdpoFreenectCaptureThread.Execute;
var ret: integer;
    lastTick, actTick: DWord;
    //Req,Rem : TimeSpec;
begin
  Owner.CapThreadPID := fpGetPID;
  lastTick := GetTickCount();

  while not Terminated do begin

    with Owner do begin
      if FVideo and (FRequestedVideoFormat <> FCurrentVideoFormat) then begin
        freenect_stop_video(f_dev);
        freenect_set_video_mode(f_dev, freenect_find_video_mode(FREENECT_RESOLUTION_MEDIUM, FRequestedVideoFormat));
        freenect_start_video(f_dev);
        FCurrentVideoFormat := FRequestedVideoFormat;
      end;

      if FVideo or FDepth then begin  // If there is a video or depth stream open...
        ret := freenect_process_events(f_ctx);
        if ret < 0 then begin
          break;
        end;
        inc(ProcessEventsCount);

        if FOrientationSystem then begin
          actTick := GetTickCount();
          if actTick - lastTick > FUpdatePeriod then begin
            updateAccelerometer(self.Owner);
            lastTick := actTick;
          end;
        end;
      end else begin                  // if not then keep the Accelerometer updates
        //Req.tv_sec := 0;
        //Req.tv_nsec := FUpdatePeriod * 1000000;
        //FpNanoSleep(@req,@rem);
        //ThreadSwitch();
        Sleep(FUpdatePeriod);
        if FOrientationSystem then
          updateAccelerometer(self.Owner);
      end;
    end;

  end;
  
  Owner.FClosing:=false;
end;


initialization

{$i TSdpoFreenect.lrs}

end.
