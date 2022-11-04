{ freenect v1

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
unit freenect;

{$mode objfpc}{$H+}

interface

uses
  ctypes;

const
  library_name = 'freenect';

  FREENECT_COUNTS_PER_G = 819;

{$PACKRECORDS C}

type
  int8_t = cint8;
  int16_t = cint16;
  int32_t = cint32;

  uint8_t = cint8;
  uint16_t = cint16;
  uint32_t = cint32;

  freenect_device_flags = (
  FREENECT_DEVICE_MOTOR := 1,
  FREENECT_DEVICE_CAMERA := 2,
  FREENECT_DEVICE_AUDIO := 4
);

freenect_video_format = (
  FREENECT_VIDEO_RGB := 0,
  FREENECT_VIDEO_BAYER := 1,
  FREENECT_VIDEO_IR_8BIT := 2,
  FREENECT_VIDEO_IR_10BIT := 3,
  FREENECT_VIDEO_IR_10BIT_PACKED := 4,
  FREENECT_VIDEO_YUV_RGB := 5,
  FREENECT_VIDEO_YUV_RAW := 6,
  FREENECT_VIDEO_DUMMY := 2147483647
);

freenect_resolution = (
  FREENECT_RESOLUTION_LOW := 0,
  FREENECT_RESOLUTION_MEDIUM := 1,
  FREENECT_RESOLUTION_HIGH := 2,
  FREENECT_RESOLUTION_DUMMY := 2147483647
);

freenect_loglevel = (
  FREENECT_LOG_FATAL := 0,
  FREENECT_LOG_ERROR := 1,
  FREENECT_LOG_WARNING := 2,
  FREENECT_LOG_NOTICE := 3,
  FREENECT_LOG_INFO := 4,
  FREENECT_LOG_DEBUG := 5,
  FREENECT_LOG_SPEW := 6,
  FREENECT_LOG_FLOOD := 7
);

freenect_depth_format = (
  FREENECT_DEPTH_11BIT := 0,
  FREENECT_DEPTH_10BIT := 1,
  FREENECT_DEPTH_11BIT_PACKED := 2,
  FREENECT_DEPTH_10BIT_PACKED := 3,
  FREENECT_DEPTH_DUMMY := 2147483647
);

freenect_led_options = (
  LED_OFF := 0,
  LED_GREEN := 1,
  LED_RED := 2,
  LED_YELLOW := 3,
  LED_BLINK_GREEN := 4,
  LED_BLINK_RED_YELLOW := 6
);

freenect_tilt_status_code = (
  TILT_STATUS_STOPPED := 0,
  TILT_STATUS_LIMIT := 1,
  TILT_STATUS_MOVING := 4
);


  Pfreenect_frame_mode_s1 = ^freenect_frame_mode_s1;
  freenect_frame_mode_s1 = record
    case longint of
      0 : ( dummy: int32_t);
      1 : ( video_format: freenect_video_format);
      2 : ( depth_format: freenect_depth_format);
  end;

  Pfreenect_frame_mode = ^freenect_frame_mode;
  freenect_frame_mode = record
    reserved: uint32_t;
    resolution: freenect_resolution;
    _i0: freenect_frame_mode_s1;
    bytes: int32_t;
    width: int16_t;
    height: int16_t;
    data_bits_per_pixel: int8_t;
    padding_bits_per_pixel: int8_t;
    framerate: int8_t;
    is_valid: int8_t;
  end;

  Pfreenect_raw_tilt_state = ^freenect_raw_tilt_state;
  freenect_raw_tilt_state = record
    accelerometer_x: int16_t;
    accelerometer_y: int16_t;
    accelerometer_z: int16_t;
    tilt_angle: int8_t;
    tilt_status: freenect_tilt_status_code;
  end;

  P_freenect_context = ^_freenect_context;
  _freenect_context = record
  end;

  PPfreenect_context = ^Pfreenect_context;
  Pfreenect_context = ^freenect_context;
  freenect_context = _freenect_context;
  P_freenect_device = ^_freenect_device;
  _freenect_device = record
  end;

  PPfreenect_device = ^Pfreenect_device;
  Pfreenect_device = ^freenect_device;
  freenect_device = _freenect_device;
//  freenect_usb_context = libusb_context;
  Pfreenect_usb_context = pointer;

  //typedef void (*freenect_log_cb)(freenect_context *dev, freenect_loglevel level, const char *msg);
  //typedef void (*freenect_depth_cb)(freenect_device *dev, void *depth, uint32_t timestamp);
  //typedef void (*freenect_video_cb)(freenect_device *dev, void *video, uint32_t timestamp);

  // Typedef for logging callback functions
  freenect_log_cb = procedure(dev: Pfreenect_context; level: freenect_loglevel; msg: Pchar); cdecl;

  // Typedef for depth image received event callbacks
  freenect_depth_cb = procedure(dev: Pfreenect_device; depth: Pointer; timestamp: uint32_t); cdecl;

  // Typedef for video image received event callbacks
  freenect_video_cb = procedure(dev: Pfreenect_device; video: Pointer; timestamp: uint32_t); cdecl;



function  freenect_init(ctx: PPfreenect_context; usb_ctx: Pfreenect_usb_context): cint; cdecl; external library_name name 'freenect_init';
function  freenect_shutdown(ctx: Pfreenect_context): cint; cdecl; external library_name name 'freenect_shutdown';
procedure freenect_set_log_level(ctx: Pfreenect_context; level: freenect_loglevel); cdecl; external library_name name 'freenect_set_log_level';
procedure freenect_set_log_callback(ctx: Pfreenect_context; cb: freenect_log_cb); cdecl; external library_name name 'freenect_set_log_callback';
function  freenect_process_events(ctx: Pfreenect_context): cint; cdecl; external library_name name 'freenect_process_events';
function  freenect_num_devices(ctx: Pfreenect_context): cint; cdecl; external library_name name 'freenect_num_devices';
procedure freenect_select_subdevices(ctx: Pfreenect_context; subdevs: freenect_device_flags); cdecl; external library_name name 'freenect_select_subdevices';
function  freenect_open_device(ctx: Pfreenect_context; dev: PPfreenect_device; index: cint): cint; cdecl; external library_name name 'freenect_open_device';
function  freenect_close_device(dev: Pfreenect_device): cint; cdecl; external library_name name 'freenect_close_device';
procedure freenect_set_user(dev: Pfreenect_device; user: Pointer); cdecl; external library_name name 'freenect_set_user';
function  freenect_get_user(dev: Pfreenect_device): Pointer; cdecl; external library_name name 'freenect_get_user';
procedure freenect_set_depth_callback(dev: Pfreenect_device; cb: freenect_depth_cb); cdecl; external library_name name 'freenect_set_depth_callback';
procedure freenect_set_video_callback(dev: Pfreenect_device; cb: freenect_video_cb); cdecl; external library_name name 'freenect_set_video_callback';
function  freenect_set_depth_buffer(dev: Pfreenect_device; buf: Pointer): cint; cdecl; external library_name name 'freenect_set_depth_buffer';
function  freenect_set_video_buffer(dev: Pfreenect_device; buf: Pointer): cint; cdecl; external library_name name 'freenect_set_video_buffer';
function  freenect_start_depth(dev: Pfreenect_device): cint; cdecl; external library_name name 'freenect_start_depth';
function  freenect_start_video(dev: Pfreenect_device): cint; cdecl; external library_name name 'freenect_start_video';
function  freenect_stop_depth(dev: Pfreenect_device): cint; cdecl; external library_name name 'freenect_stop_depth';
function  freenect_stop_video(dev: Pfreenect_device): cint; cdecl; external library_name name 'freenect_stop_video';
function  freenect_update_tilt_state(dev: Pfreenect_device): cint; cdecl; external library_name name 'freenect_update_tilt_state';
function  freenect_get_tilt_state(dev: Pfreenect_device): Pfreenect_raw_tilt_state; cdecl; external library_name name 'freenect_get_tilt_state';
function  freenect_get_tilt_degs(state: Pfreenect_raw_tilt_state): double; cdecl; external library_name name 'freenect_get_tilt_degs';
function  freenect_set_tilt_degs(dev: Pfreenect_device; angle: double): cint; cdecl; external library_name name 'freenect_set_tilt_degs';
function  freenect_get_tilt_status(state: Pfreenect_raw_tilt_state): freenect_tilt_status_code; cdecl; external library_name name 'freenect_get_tilt_status';
function  freenect_set_led(dev: Pfreenect_device; option: freenect_led_options): cint; cdecl; external library_name name 'freenect_set_led';
procedure freenect_get_mks_accel(state: Pfreenect_raw_tilt_state; x: Pdouble; y: Pdouble; z: Pdouble); cdecl; external library_name name 'freenect_get_mks_accel';
function  freenect_get_video_mode_count: cint; cdecl; external library_name name 'freenect_get_video_mode_count';
function  freenect_get_video_mode(mode_num: cint): freenect_frame_mode; cdecl; external library_name name 'freenect_get_video_mode';
function  freenect_get_current_video_mode(dev: Pfreenect_device): freenect_frame_mode; cdecl; external library_name name 'freenect_get_current_video_mode';
function  freenect_find_video_mode(res: freenect_resolution; fmt: freenect_video_format): freenect_frame_mode; cdecl; external library_name name 'freenect_find_video_mode';
function  freenect_set_video_mode(dev: Pfreenect_device; mode: freenect_frame_mode): cint; cdecl; external library_name name 'freenect_set_video_mode';
function  freenect_get_depth_mode_count(): cint; cdecl; external library_name name 'freenect_get_depth_mode_count';
function  freenect_get_depth_mode(mode_num: cint): freenect_frame_mode; cdecl; external library_name name 'freenect_get_depth_mode';
function  freenect_get_current_depth_mode(dev: Pfreenect_device): freenect_frame_mode; cdecl; external library_name name 'freenect_get_current_depth_mode';
function  freenect_find_depth_mode(res: freenect_resolution; fmt: freenect_depth_format): freenect_frame_mode; cdecl; external library_name name 'freenect_find_depth_mode';
function  freenect_set_depth_mode(dev: Pfreenect_device; mode: freenect_frame_mode): cint; cdecl; external library_name name 'freenect_set_depth_mode';

// Inline Functions

implementation


end.

