
unit videodev2;
interface

uses BaseUnix;

{
  Automatically converted by H2Pas 1.0.0 from /home/robot/plm/videodev2.tmp.h
  The following command line parameters were used:
    -e
    -p
    -D
    -w
    -o
    /home/robot/plm/videodev2.pas
    /home/robot/plm/videodev2.tmp.h
}

  const
    //External_library='kernel32'; {Setup as you need}
    External_library='videodev2'; {Setup as you need}

  { Pointers to basic pascal types, inserted by h2pas conversion program.}
  Type
    PLongint  = ^Longint;
    PSmallInt = ^SmallInt;
    PByte     = ^Byte;
    PWord     = ^Word;
    PDWord    = ^DWord;
    PDouble   = ^Double;

  {Type
  Pv4l2_audio  = ^v4l2_audio;
  Pv4l2_audioout  = ^v4l2_audioout;
  Pv4l2_buf_type  = ^v4l2_buf_type;
  Pv4l2_buffer  = ^v4l2_buffer;
  Pv4l2_capability  = ^v4l2_capability;
  Pv4l2_captureparm  = ^v4l2_captureparm;
  Pv4l2_chip_ident_old  = ^v4l2_chip_ident_old;
  Pv4l2_clip  = ^v4l2_clip;
  Pv4l2_colorfx  = ^v4l2_colorfx;
  Pv4l2_colorspace  = ^v4l2_colorspace;
  Pv4l2_control  = ^v4l2_control;
  Pv4l2_crop  = ^v4l2_crop;
  Pv4l2_cropcap  = ^v4l2_cropcap;
  Pv4l2_ctrl_type  = ^v4l2_ctrl_type;
  Pv4l2_dbg_chip_ident  = ^v4l2_dbg_chip_ident;
  Pv4l2_dbg_match  = ^v4l2_dbg_match;
  Pv4l2_dbg_register  = ^v4l2_dbg_register;
  Pv4l2_enc_idx  = ^v4l2_enc_idx;
  Pv4l2_enc_idx_entry  = ^v4l2_enc_idx_entry;
  Pv4l2_encoder_cmd  = ^v4l2_encoder_cmd;
  Pv4l2_exposure_auto_type  = ^v4l2_exposure_auto_type;
  Pv4l2_ext_control  = ^v4l2_ext_control;
  Pv4l2_ext_controls  = ^v4l2_ext_controls;
  Pv4l2_field  = ^v4l2_field;
  Pv4l2_fmtdesc  = ^v4l2_fmtdesc;
  Pv4l2_format  = ^v4l2_format;
  Pv4l2_fract  = ^v4l2_fract;
  Pv4l2_framebuffer  = ^v4l2_framebuffer;
  Pv4l2_frequency  = ^v4l2_frequency;
  Pv4l2_frmival_stepwise  = ^v4l2_frmival_stepwise;
  Pv4l2_frmivalenum  = ^v4l2_frmivalenum;
  Pv4l2_frmivaltypes  = ^v4l2_frmivaltypes;
  Pv4l2_frmsize_discrete  = ^v4l2_frmsize_discrete;
  Pv4l2_frmsize_stepwise  = ^v4l2_frmsize_stepwise;
  Pv4l2_frmsizeenum  = ^v4l2_frmsizeenum;
  Pv4l2_frmsizetypes  = ^v4l2_frmsizetypes;
  Pv4l2_hw_freq_seek  = ^v4l2_hw_freq_seek;
  Pv4l2_input  = ^v4l2_input;
  Pv4l2_jpegcompression  = ^v4l2_jpegcompression;
  Pv4l2_memory  = ^v4l2_memory;
  Pv4l2_modulator  = ^v4l2_modulator;
  Pv4l2_mpeg_audio_ac3_bitrate  = ^v4l2_mpeg_audio_ac3_bitrate;
  Pv4l2_mpeg_audio_crc  = ^v4l2_mpeg_audio_crc;
  Pv4l2_mpeg_audio_emphasis  = ^v4l2_mpeg_audio_emphasis;
  Pv4l2_mpeg_audio_encoding  = ^v4l2_mpeg_audio_encoding;
  Pv4l2_mpeg_audio_l1_bitrate  = ^v4l2_mpeg_audio_l1_bitrate;
  Pv4l2_mpeg_audio_l2_bitrate  = ^v4l2_mpeg_audio_l2_bitrate;
  Pv4l2_mpeg_audio_l3_bitrate  = ^v4l2_mpeg_audio_l3_bitrate;
  Pv4l2_mpeg_audio_mode  = ^v4l2_mpeg_audio_mode;
  Pv4l2_mpeg_audio_mode_extension  = ^v4l2_mpeg_audio_mode_extension;
  Pv4l2_mpeg_audio_sampling_freq  = ^v4l2_mpeg_audio_sampling_freq;
  Pv4l2_mpeg_cx2341x_video_chroma_spatial_filter_type  = ^v4l2_mpeg_cx2341x_video_chroma_spatial_filter_type;
  Pv4l2_mpeg_cx2341x_video_luma_spatial_filter_type  = ^v4l2_mpeg_cx2341x_video_luma_spatial_filter_type;
  Pv4l2_mpeg_cx2341x_video_median_filter_type  = ^v4l2_mpeg_cx2341x_video_median_filter_type;
  Pv4l2_mpeg_cx2341x_video_spatial_filter_mode  = ^v4l2_mpeg_cx2341x_video_spatial_filter_mode;
  Pv4l2_mpeg_cx2341x_video_temporal_filter_mode  = ^v4l2_mpeg_cx2341x_video_temporal_filter_mode;
  Pv4l2_mpeg_stream_type  = ^v4l2_mpeg_stream_type;
  Pv4l2_mpeg_stream_vbi_fmt  = ^v4l2_mpeg_stream_vbi_fmt;
  Pv4l2_mpeg_video_aspect  = ^v4l2_mpeg_video_aspect;
  Pv4l2_mpeg_video_bitrate_mode  = ^v4l2_mpeg_video_bitrate_mode;
  Pv4l2_mpeg_video_encoding  = ^v4l2_mpeg_video_encoding;
  Pv4l2_output  = ^v4l2_output;
  Pv4l2_outputparm  = ^v4l2_outputparm;
  Pv4l2_pix_format  = ^v4l2_pix_format;
  Pv4l2_power_line_frequency  = ^v4l2_power_line_frequency;
  Pv4l2_priority  = ^v4l2_priority;
  Pv4l2_queryctrl  = ^v4l2_queryctrl;
  Pv4l2_querymenu  = ^v4l2_querymenu;
  Pv4l2_rect  = ^v4l2_rect;
  Pv4l2_requestbuffers  = ^v4l2_requestbuffers;
  Pv4l2_sliced_vbi_cap  = ^v4l2_sliced_vbi_cap;
  Pv4l2_sliced_vbi_data  = ^v4l2_sliced_vbi_data;
  Pv4l2_sliced_vbi_format  = ^v4l2_sliced_vbi_format;
  Pv4l2_standard  = ^v4l2_standard;
  Pv4l2_std_id  = ^v4l2_std_id;
  Pv4l2_streamparm  = ^v4l2_streamparm;
  Pv4l2_timecode  = ^v4l2_timecode;
  Pv4l2_tuner  = ^v4l2_tuner;
  Pv4l2_tuner_type  = ^v4l2_tuner_type;
  Pv4l2_vbi_format  = ^v4l2_vbi_format;
  Pv4l2_window  = ^v4l2_window;}

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

{$ifndef __LINUX_VIDEODEV2_H}
{$define __LINUX_VIDEODEV2_H}


  {
   *  Video for Linux Two header file
   *
   *  Copyright (C) 1999-2007 the contributors
   *
   *  This program is free software; you can redistribute it and/or modify
   *  it under the terms of the GNU General Public License as published by
   *  the Free Software Foundation; either version 2 of the License, or
   *  (at your option) any later version.
   *
   *  This program is distributed in the hope that it will be useful,
   *  but WITHOUT ANY WARRANTY; without even the implied warranty of
   *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   *  GNU General Public License for more details.
   *
   *  Alternatively you can redistribute this file under the terms of the
   *  BSD license as stated below:
   *
   *  Redistribution and use in source and binary forms, with or without
   *  modification, are permitted provided that the following conditions
   *  are met:
   *  1. Redistributions of source code must retain the above copyright
   *     notice, this list of conditions and the following disclaimer.
   *  2. Redistributions in binary form must reproduce the above copyright
   *     notice, this list of conditions and the following disclaimer in
   *     the documentation and/or other materials provided with the
   *     distribution.
   *  3. The names of its contributors may not be used to endorse or promote
   *     products derived from this software without specific prior written
   *     permission.
   *
   *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
   *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
   *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
   *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
   *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
   *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
   *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
   *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
   *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
   *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
   *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
   *
   *	Header file for v4l or V4L2 drivers and applications
   * with public API.
   * All kernel-specific stuff were moved to media/v4l2-dev.h, so
   * no #if __KERNEL tests are allowed here
   *
   *	See http://linuxtv.org for more info
   *
   *	Author: Bill Dirks <bill@thedirks.org>
   *		Justin Schoeman
   *              Hans Verkuil <hverkuil@xs4all.nl>
   *		et al.
    }

  {
   * Common stuff for both V4L1 and V4L2
   * Moved from videodev.h
    }

  const
     VIDEO_MAX_FRAME = 32;
{$ifndef __KERNEL__}
  { These defines are V4L1 specific and should not be used with the V4L2 API!
     They will be removed from this header in the future.  }

  const
     VID_TYPE_CAPTURE = 1;
  { Can capture  }
     VID_TYPE_TUNER = 2;
  { Can tune  }
     VID_TYPE_TELETEXT = 4;
  { Does teletext  }
     VID_TYPE_OVERLAY = 8;
  { Overlay onto frame buffer  }
     VID_TYPE_CHROMAKEY = 16;
  { Overlay by chromakey  }
     VID_TYPE_CLIPPING = 32;
  { Can clip  }
     VID_TYPE_FRAMERAM = 64;
  { Uses the frame buffer memory  }
     VID_TYPE_SCALES = 128;
  { Scalable  }
     VID_TYPE_MONOCHROME = 256;
  { Monochrome only  }
     VID_TYPE_SUBCAPTURE = 512;
  { Can capture subareas of the image  }
     VID_TYPE_MPEG_DECODER = 1024;
  { Can decode MPEG streams  }
     VID_TYPE_MPEG_ENCODER = 2048;
  { Can encode MPEG streams  }
     VID_TYPE_MJPEG_DECODER = 4096;
  { Can decode MJPEG streams  }
     VID_TYPE_MJPEG_ENCODER = 8192;
  { Can encode MJPEG streams  }
{$endif}

  {#include <linux/compiler.h> /* need  */ }

  const
     _IOC_NRBITS = 8;
     _IOC_TYPEBITS = 8;
     _IOC_SIZEBITS = 14;
     _IOC_DIRBITS = 2;
     _IOC_NRMASK = (1 shl _IOC_NRBITS)-1;
     _IOC_TYPEMASK = (1 shl _IOC_TYPEBITS)-1;
     _IOC_SIZEMASK = (1 shl _IOC_SIZEBITS)-1;
     _IOC_DIRMASK = (1 shl _IOC_DIRBITS)-1;
     _IOC_NRSHIFT = 0;
     _IOC_TYPESHIFT = _IOC_NRSHIFT+_IOC_NRBITS;
     _IOC_SIZESHIFT = _IOC_TYPESHIFT+_IOC_TYPEBITS;
     _IOC_DIRSHIFT = _IOC_SIZESHIFT+_IOC_SIZEBITS;
  {
   * Direction bits.
    }
     _IOC_NONE = 0;
     _IOC_WRITE = 1;
     _IOC_READ = 2;
  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOC(dir,_type,nr,size : longint) : longint;

  { used to create numbers  }
  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IO(_type,nr : longint) : longint;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOR(_type,nr,size : longint) : longint;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOW(_type,nr,size : longint) : longint;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOWR(_type,nr,size : longint) : longint;

  { used to decode ioctl numbers..  }
  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOC_DIR(nr : longint) : longint;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOC_TYPE(nr : longint) : longint;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOC_NR(nr : longint) : longint;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOC_SIZE(nr : longint) : longint;

  { ...and for the drivers/sound files...  }

  const
     IOC_IN = _IOC_WRITE shl _IOC_DIRSHIFT;
     IOC_OUT = _IOC_READ shl _IOC_DIRSHIFT;
     IOC_INOUT = (_IOC_WRITE or _IOC_READ) shl _IOC_DIRSHIFT;
     IOCSIZE_MASK = _IOC_SIZEMASK shl _IOC_SIZESHIFT;
     IOCSIZE_SHIFT = _IOC_SIZESHIFT;


  {
   *	M I S C E L L A N E O U S
    }

  type
    __u8 = byte;
    __s8 = shortint;
    __u16 = word;
    __s16 = smallint;
    __u32 = LongWord;
    __s32 = integer;
    __u64 = Int64;
    __s64 = Int64;

  {  Four-character-code (FOURCC)  }
  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function v4l2_fourcc(a,b,c,d : char) : longint;

  {
   *	E N U M S
    }

  type
     v4l2_field =  Longint;
     Const
       V4L2_FIELD_ANY = 0;
       V4L2_FIELD_NONE = 1;
       V4L2_FIELD_TOP = 2;
       V4L2_FIELD_BOTTOM = 3;
       V4L2_FIELD_INTERLACED = 4;
       V4L2_FIELD_SEQ_TB = 5;
       V4L2_FIELD_SEQ_BT = 6;
       V4L2_FIELD_ALTERNATE = 7;
       V4L2_FIELD_INTERLACED_TB = 8;
       V4L2_FIELD_INTERLACED_BT = 9;

  {#define V4L2_FIELD_HAS_TOP(field) ((field) == V4L2_FIELD_TOP || (field) == V4L2_FIELD_INTERLACED || (field) == V4L2_FIELD_INTERLACED_TB || (field) == V4L2_FIELD_INTERLACED_BT || (field) == V4L2_FIELD_SEQ_TB	|| (field) == V4L2_FIELD_SEQ_BT) }
  {
  #define V4L2_FIELD_HAS_BOTTOM(field)	\
  	((field) == V4L2_FIELD_BOTTOM 	||\
  	 (field) == V4L2_FIELD_INTERLACED ||\
  	 (field) == V4L2_FIELD_INTERLACED_TB ||\
  	 (field) == V4L2_FIELD_INTERLACED_BT ||\
  	 (field) == V4L2_FIELD_SEQ_TB	||\
  	 (field) == V4L2_FIELD_SEQ_BT)
  #define V4L2_FIELD_HAS_BOTH(field)	\
  	((field) == V4L2_FIELD_INTERLACED ||\
  	 (field) == V4L2_FIELD_INTERLACED_TB ||\
  	 (field) == V4L2_FIELD_INTERLACED_BT ||\
  	 (field) == V4L2_FIELD_SEQ_TB ||\
  	 (field) == V4L2_FIELD_SEQ_BT) }
//{$if 1 /*KEEP*/}
  { Experimental  }
//{$endif}

  type
     v4l2_buf_type =  Longint;
     Const
       V4L2_BUF_TYPE_VIDEO_CAPTURE = 1;
       V4L2_BUF_TYPE_VIDEO_OUTPUT = 2;
       V4L2_BUF_TYPE_VIDEO_OVERLAY = 3;
       V4L2_BUF_TYPE_VBI_CAPTURE = 4;
       V4L2_BUF_TYPE_VBI_OUTPUT = 5;
       V4L2_BUF_TYPE_SLICED_VBI_CAPTURE = 6;
       V4L2_BUF_TYPE_SLICED_VBI_OUTPUT = 7;
       V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY = 8;
       V4L2_BUF_TYPE_PRIVATE = $80;


  type
     v4l2_ctrl_type =  Longint;
     Const
       V4L2_CTRL_TYPE_INTEGER = 1;
       V4L2_CTRL_TYPE_BOOLEAN = 2;
       V4L2_CTRL_TYPE_MENU = 3;
       V4L2_CTRL_TYPE_BUTTON = 4;
       V4L2_CTRL_TYPE_INTEGER64 = 5;
       V4L2_CTRL_TYPE_CTRL_CLASS = 6;


  type
     v4l2_tuner_type =  Longint;
     Const
       V4L2_TUNER_RADIO = 1;
       V4L2_TUNER_ANALOG_TV = 2;
       V4L2_TUNER_DIGITAL_TV = 3;


  type
     v4l2_memory =  Longint;
     Const
       V4L2_MEMORY_MMAP = 1;
       V4L2_MEMORY_USERPTR = 2;
       V4L2_MEMORY_OVERLAY = 3;

  { see also http://vektor.theorem.ca/graphics/ycbcr/  }
  { ITU-R 601 -- broadcast NTSC/PAL  }
  { 1125-Line (US) HDTV  }
  { HD and modern captures.  }
  { broken BT878 extents (601, luma range 16-253 instead of 16-235)  }
  { These should be useful.  Assume 601 extents.  }
  { I know there will be cameras that send this.  So, this is
  	 * unspecified chromaticities and full 0-255 on each of the
  	 * Y'CbCr components
  	  }
  { For RGB colourspaces, this is probably a good start.  }

  type
     v4l2_colorspace =  Longint;
     Const
       V4L2_COLORSPACE_SMPTE170M = 1;
       V4L2_COLORSPACE_SMPTE240M = 2;
       V4L2_COLORSPACE_REC709 = 3;
       V4L2_COLORSPACE_BT878 = 4;
       V4L2_COLORSPACE_470_SYSTEM_M = 5;
       V4L2_COLORSPACE_470_SYSTEM_BG = 6;
       V4L2_COLORSPACE_JPEG = 7;
       V4L2_COLORSPACE_SRGB = 8;

  { not initialized  }

  type
     v4l2_priority =  Longint;
     Const
       V4L2_PRIORITY_UNSET = 0;
       V4L2_PRIORITY_BACKGROUND = 1;
       V4L2_PRIORITY_INTERACTIVE = 2;
       V4L2_PRIORITY_RECORD = 3;
       V4L2_PRIORITY_DEFAULT = V4L2_PRIORITY_INTERACTIVE;


  type
     Pv4l2_rect = ^v4l2_rect;
     v4l2_rect = record
          left : __s32;
          top : __s32;
          width : __s32;
          height : __s32;
       end;

     Pv4l2_fract = ^v4l2_fract;
     v4l2_fract = record
          numerator : __u32;
          denominator : __u32;
       end;

  {
   *	D R I V E R   C A P A B I L I T I E S
    }
  { i.e. "bttv"  }
  { i.e. "Hauppauge WinTV"  }
  { "PCI:" + pci_name(pci_dev)  }
  { should use KERNEL_VERSION()  }
  { Device capabilities  }
     Pv4l2_capability = ^v4l2_capability;
     v4l2_capability = record
          driver : array[0..15] of __u8;
          card : array[0..31] of __u8;
          bus_info : array[0..31] of __u8;
          version : __u32;
          capabilities : __u32;
          reserved : array[0..3] of __u32;
       end;

  { Values for 'capabilities' field  }

  const
     V4L2_CAP_VIDEO_CAPTURE = $00000001;
  { Is a video capture device  }
     V4L2_CAP_VIDEO_OUTPUT = $00000002;
  { Is a video output device  }
     V4L2_CAP_VIDEO_OVERLAY = $00000004;
  { Can do video overlay  }
     V4L2_CAP_VBI_CAPTURE = $00000010;
  { Is a raw VBI capture device  }
     V4L2_CAP_VBI_OUTPUT = $00000020;
  { Is a raw VBI output device  }
     V4L2_CAP_SLICED_VBI_CAPTURE = $00000040;
  { Is a sliced VBI capture device  }
     V4L2_CAP_SLICED_VBI_OUTPUT = $00000080;
  { Is a sliced VBI output device  }
     V4L2_CAP_RDS_CAPTURE = $00000100;
  { RDS data capture  }
     V4L2_CAP_VIDEO_OUTPUT_OVERLAY = $00000200;
  { Can do video output overlay  }
     V4L2_CAP_HW_FREQ_SEEK = $00000400;
  { Can do hardware frequency seek   }
     V4L2_CAP_TUNER = $00010000;
  { has a tuner  }
     V4L2_CAP_AUDIO = $00020000;
  { has audio support  }
     V4L2_CAP_RADIO = $00040000;
  { is a radio device  }
     V4L2_CAP_READWRITE = $01000000;
  { read/write systemcalls  }
     V4L2_CAP_ASYNCIO = $02000000;
  { async I/O  }
     V4L2_CAP_STREAMING = $04000000;
  { streaming I/O ioctls  }
  {
   *	V I D E O   I M A G E   F O R M A T
    }
  { for padding, zero if unused  }
  { private data, depends on pixelformat  }

  type
     Pv4l2_pix_format = ^v4l2_pix_format;
     v4l2_pix_format = record
          width : __u32;
          height : __u32;
          pixelformat : __u32;
          field : v4l2_field;
          bytesperline : __u32;
          sizeimage : __u32;
          colorspace : v4l2_colorspace;
          priv : __u32;
       end;

  {      Pixel format         FOURCC                        depth  Description   }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB332 : longint;
      { return type might be wrong }

  {  8  RGB-3-3-2      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB444 : longint;
      { return type might be wrong }

  { 16  xxxxrrrr ggggbbbb  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB555 : longint;
      { return type might be wrong }

  { 16  RGB-5-5-5      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB565 : longint;
      { return type might be wrong }

  { 16  RGB-5-6-5      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB555X : longint;
      { return type might be wrong }

  { 16  RGB-5-5-5 BE   }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB565X : longint;
      { return type might be wrong }

  { 16  RGB-5-6-5 BE   }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_BGR24 : longint;
      { return type might be wrong }

  { 24  BGR-8-8-8      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB24 : longint;
      { return type might be wrong }

  { 24  RGB-8-8-8      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_BGR32 : longint;
      { return type might be wrong }

  { 32  BGR-8-8-8-8    }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB32 : longint;
      { return type might be wrong }

  { 32  RGB-8-8-8-8    }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_GREY : longint;
      { return type might be wrong }

  {  8  Greyscale      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_Y16 : longint;
      { return type might be wrong }

  { 16  Greyscale      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_PAL8 : longint;
      { return type might be wrong }

  {  8  8-bit palette  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YVU410 : longint;
      { return type might be wrong }

  {  9  YVU 4:1:0      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YVU420 : longint;
      { return type might be wrong }

  { 12  YVU 4:2:0      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUYV : longint;
      { return type might be wrong }

  { 16  YUV 4:2:2      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_UYVY : longint;
      { return type might be wrong }

  { 16  YUV 4:2:2      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_VYUY : longint;
      { return type might be wrong }

  { 16  YUV 4:2:2      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV422P : longint;
      { return type might be wrong }

  { 16  YVU422 planar  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV411P : longint;
      { return type might be wrong }

  { 16  YVU411 planar  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_Y41P : longint;
      { return type might be wrong }

  { 12  YUV 4:1:1      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV444 : longint;
      { return type might be wrong }

  { 16  xxxxyyyy uuuuvvvv  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV555 : longint;
      { return type might be wrong }

  { 16  YUV-5-5-5      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV565 : longint;
      { return type might be wrong }

  { 16  YUV-5-6-5      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV32 : longint;
      { return type might be wrong }

  { 32  YUV-8-8-8-8    }
  { two planes -- one Y, one Cr + Cb interleaved   }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_NV12 : longint;
      { return type might be wrong }

  { 12  Y/CbCr 4:2:0   }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_NV21 : longint;
      { return type might be wrong }

  { 12  Y/CrCb 4:2:0   }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_NV16 : longint;
      { return type might be wrong }

  { 16  Y/CbCr 4:2:2   }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_NV61 : longint;
      { return type might be wrong }

  { 16  Y/CrCb 4:2:2   }
  {  The following formats are not defined in the V4L2 specification  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV410 : longint;
      { return type might be wrong }

  {  9  YUV 4:1:0      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV420 : longint;
      { return type might be wrong }

  { 12  YUV 4:2:0      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YYUV : longint;
      { return type might be wrong }

  { 16  YUV 4:2:2      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_HI240 : longint;
      { return type might be wrong }

  {  8  8-bit color    }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_HM12 : longint;
      { return type might be wrong }

  {  8  YUV 4:2:0 16x16 macroblocks  }
  { see http://www.siliconimaging.com/RGB%20Bayer.htm  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_SBGGR8 : longint;
      { return type might be wrong }

  {  8  BGBG.. GRGR..  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_SGBRG8 : longint;
      { return type might be wrong }

  {  8  GBGB.. RGRG..  }
  {
   * 10bit raw bayer, expanded to 16 bits
   * xxxxrrrrrrrrrrxxxxgggggggggg xxxxggggggggggxxxxbbbbbbbbbb...
    }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_SGRBG10 : longint;
      { return type might be wrong }

  { 10bit raw bayer DPCM compressed to 8 bits  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_SGRBG10DPCM8 : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function V4L2_PIX_FMT_SBGGR16 : longint;
      { return type might be wrong }

  { 16  BGBG.. GRGR..  }
  { compressed formats  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_MJPEG : longint;
      { return type might be wrong }

  { Motion-JPEG    }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_JPEG : longint;
      { return type might be wrong }

  { JFIF JPEG      }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_DV : longint;
      { return type might be wrong }

  { 1394           }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_MPEG : longint;
      { return type might be wrong }

  { MPEG-1/2/4     }
  {  Vendor-specific formats    }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_WNVA : longint;
      { return type might be wrong }

  { Winnov hw compress  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_SN9C10X : longint;
      { return type might be wrong }

  { SN9C10x compression  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_PWC1 : longint;
      { return type might be wrong }

  { pwc older webcam  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_PWC2 : longint;
      { return type might be wrong }

  { pwc newer webcam  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_ET61X251 : longint;
      { return type might be wrong }

  { ET61X251 compression  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_SPCA501 : longint;
      { return type might be wrong }

  { YUYV per line  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_SPCA505 : longint;
      { return type might be wrong }

  { YYUV per line  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_SPCA508 : longint;
      { return type might be wrong }

  { YUVY per line  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_SPCA561 : longint;
      { return type might be wrong }

  { compressed GBRG bayer  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_PAC207 : longint;
      { return type might be wrong }

  { compressed BGGR bayer  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_MR97310A : longint;
      { return type might be wrong }

  { compressed BGGR bayer  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_PJPG : longint;
      { return type might be wrong }

  { Pixart 73xx JPEG  }
  { was #define dname def_expr }
  function V4L2_PIX_FMT_YVYU : longint;
      { return type might be wrong }

  { 16  YVU 4:2:2      }
  {
   *	F O R M A T   E N U M E R A T I O N
    }
  { Format number       }
  { buffer type         }
  { Description string  }
  { Format fourcc       }

  type
     Pv4l2_fmtdesc = ^v4l2_fmtdesc;
     v4l2_fmtdesc = record
          index : __u32;
          _type : v4l2_buf_type;
          flags : __u32;
          description : array[0..31] of __u8;
          pixelformat : __u32;
          reserved : array[0..3] of __u32;
       end;


  const
     V4L2_FMT_FLAG_COMPRESSED = $0001;
//{$if 1 /*KEEP*/}
  { Experimental Frame Size and frame rate enumeration  }
  {
   *	F R A M E   S I Z E   E N U M E R A T I O N
    }

  type
     v4l2_frmsizetypes =  Longint;
     Const
       V4L2_FRMSIZE_TYPE_DISCRETE = 1;
       V4L2_FRMSIZE_TYPE_CONTINUOUS = 2;
       V4L2_FRMSIZE_TYPE_STEPWISE = 3;

  { Frame width [pixel]  }
  { Frame height [pixel]  }

  type
     Pv4l2_frmsize_discrete = ^v4l2_frmsize_discrete;
     v4l2_frmsize_discrete = record
          width : __u32;
          height : __u32;
       end;

  { Minimum frame width [pixel]  }
  { Maximum frame width [pixel]  }
  { Frame width step size [pixel]  }
  { Minimum frame height [pixel]  }
  { Maximum frame height [pixel]  }
  { Frame height step size [pixel]  }
     Pv4l2_frmsize_stepwise = ^v4l2_frmsize_stepwise;
     v4l2_frmsize_stepwise = record
          min_width : __u32;
          max_width : __u32;
          step_width : __u32;
          min_height : __u32;
          max_height : __u32;
          step_height : __u32;
       end;

  { Frame size number  }
  { Pixel format  }
  { Frame size type the device supports.  }
  {union 					/* Frame size */ }
  {	struct v4l2_frmsize_discrete	discrete; }
  {; }
  { Reserved space for future use  }
     Pv4l2_frmsizeenum = ^v4l2_frmsizeenum;
     v4l2_frmsizeenum = record
          index : __u32;
          pixel_format : __u32;
          _type : __u32;
          stepwise : v4l2_frmsize_stepwise;
          reserved : array[0..1] of __u32;
       end;

  {
   *	F R A M E   R A T E   E N U M E R A T I O N
    }
     v4l2_frmivaltypes =  Longint;
     Const
       V4L2_FRMIVAL_TYPE_DISCRETE = 1;
       V4L2_FRMIVAL_TYPE_CONTINUOUS = 2;
       V4L2_FRMIVAL_TYPE_STEPWISE = 3;

  { Minimum frame interval [s]  }
  { Maximum frame interval [s]  }
  { Frame interval step size [s]  }

  type
     Pv4l2_frmival_stepwise = ^v4l2_frmival_stepwise;
     v4l2_frmival_stepwise = record
          min : v4l2_fract;
          max : v4l2_fract;
          step : v4l2_fract;
       end;

  { Frame format index  }
  { Pixel format  }
  { Frame width  }
  { Frame height  }
  { Frame interval type the device supports.  }
  {union 					/* Frame interval */ }
  {	struct v4l2_fract		discrete; }
  {; }
  { Reserved space for future use  }
     Pv4l2_frmivalenum = ^v4l2_frmivalenum;
     v4l2_frmivalenum = record
          index : __u32;
          pixel_format : __u32;
          width : __u32;
          height : __u32;
          _type : __u32;
          stepwise : v4l2_frmival_stepwise;
          reserved : array[0..1] of __u32;
       end;

//{$endif}
  {
   *	T I M E C O D E
    }

  type
     Pv4l2_timecode = ^v4l2_timecode;
     v4l2_timecode = record
          _type : __u32;
          flags : __u32;
          frames : __u8;
          seconds : __u8;
          minutes : __u8;
          hours : __u8;
          userbits : array[0..3] of __u8;
       end;

  {  Type   }

  const
     V4L2_TC_TYPE_24FPS = 1;
     V4L2_TC_TYPE_25FPS = 2;
     V4L2_TC_TYPE_30FPS = 3;
     V4L2_TC_TYPE_50FPS = 4;
     V4L2_TC_TYPE_60FPS = 5;
  {  Flags   }
     V4L2_TC_FLAG_DROPFRAME = $0001;
  { "drop-frame" mode  }
     V4L2_TC_FLAG_COLORFRAME = $0002;
     V4L2_TC_USERBITS_field = $000C;
     V4L2_TC_USERBITS_USERDEFINED = $0000;
     V4L2_TC_USERBITS_8BITCHARS = $0008;
  { The above is based on SMPTE timecodes  }
  { Number of APP segment to be written,
  				 * must be 0..15  }
  { Length of data in JPEG APPn segment  }
  { Data in the JPEG APPn segment.  }
  { Length of data in JPEG COM segment  }
  { Data in JPEG COM segment  }
  { Which markers should go into the JPEG
  				 * output. Unless you exactly know what
  				 * you do, leave them untouched.
  				 * Inluding less markers will make the
  				 * resulting code smaller, but there will
  				 * be fewer aplications which can read it.
  				 * The presence of the APP and COM marker
  				 * is influenced by APP_len and COM_len
  				 * ONLY, not by this property!  }

  const
     V4L2_JPEG_MARKER_DHT = 1 shl 3;     { Define Huffman Tables  }
     V4L2_JPEG_MARKER_DQT = 1 shl 4;     { Define Quantization Tables  }
     V4L2_JPEG_MARKER_DRI = 1 shl 5;     { Define Restart Interval  }
     V4L2_JPEG_MARKER_COM = 1 shl 6;     { Comment segment  }
     V4L2_JPEG_MARKER_APP = 1 shl 7;     { App segment, driver will }
  { allways use APP0  }

  type
     Pv4l2_jpegcompression = ^v4l2_jpegcompression;
     v4l2_jpegcompression = record
          quality : longint;
          APPn : longint;
          APP_len : longint;
          APP_data : array[0..59] of char;
          COM_len : longint;
          COM_data : array[0..59] of char;
          jpeg_markers : __u32;
       end;

  {
   *	M E M O R Y - M A P P I N G   B U F F E R S
    }
     Pv4l2_requestbuffers = ^v4l2_requestbuffers;
     v4l2_requestbuffers = record
          count : __u32;
          _type : v4l2_buf_type;
          memory : v4l2_memory;
          reserved : array[0..1] of __u32;
       end;

  { memory location  }
     Pv4l2_buffer = ^v4l2_buffer;
     v4l2_buffer = record
          index : __u32;
          _type : v4l2_buf_type;
          bytesused : __u32;
          flags : __u32;
          field : v4l2_field;
          timestamp : timeval;
          timecode : v4l2_timecode;
          sequence : __u32;
          memory : v4l2_memory;
          m : record
              case longint of
                0 : ( offset : __u32 );
                {$ifdef CPU32}
                1 : ( userptr : dword );
                {$ENDIF}
                {$ifdef CPU64}
                1 : ( userptr : __u64 );
                {$ENDIF}
              end;
          length : __u32;
          input : __u32;
          reserved : __u32;
       end;

  {  Flags for 'flags' field  }

  const
     V4L2_BUF_FLAG_MAPPED = $0001;
  { Buffer is mapped (flag)  }
     V4L2_BUF_FLAG_QUEUED = $0002;
  { Buffer is queued for processing  }
     V4L2_BUF_FLAG_DONE = $0004;
  { Buffer is ready  }
     V4L2_BUF_FLAG_KEYFRAME = $0008;
  { Image is a keyframe (I-frame)  }
     V4L2_BUF_FLAG_PFRAME = $0010;
  { Image is a P-frame  }
     V4L2_BUF_FLAG_BFRAME = $0020;
  { Image is a B-frame  }
     V4L2_BUF_FLAG_TIMECODE = $0100;
  { timecode field is valid  }
     V4L2_BUF_FLAG_INPUT = $0200;
  { input field is valid  }
  {
   *	O V E R L A Y   P R E V I E W
    }
  { FIXME: in theory we should pass something like PCI device + memory
   * region + offset instead of some physical address  }

  type
     Pv4l2_framebuffer = ^v4l2_framebuffer;
     v4l2_framebuffer = record
          capability : __u32;
          flags : __u32;
          base : pointer;
          fmt : v4l2_pix_format;
       end;

  {  Flags for the 'capability' field. Read only  }

  const
     V4L2_FBUF_CAP_EXTERNOVERLAY = $0001;
     V4L2_FBUF_CAP_CHROMAKEY = $0002;
     V4L2_FBUF_CAP_LIST_CLIPPING = $0004;
     V4L2_FBUF_CAP_BITMAP_CLIPPING = $0008;
     V4L2_FBUF_CAP_LOCAL_ALPHA = $0010;
     V4L2_FBUF_CAP_GLOBAL_ALPHA = $0020;
     V4L2_FBUF_CAP_LOCAL_INV_ALPHA = $0040;
  {  Flags for the 'flags' field.  }
     V4L2_FBUF_FLAG_PRIMARY = $0001;
     V4L2_FBUF_FLAG_OVERLAY = $0002;
     V4L2_FBUF_FLAG_CHROMAKEY = $0004;
     V4L2_FBUF_FLAG_LOCAL_ALPHA = $0008;
     V4L2_FBUF_FLAG_GLOBAL_ALPHA = $0010;
     V4L2_FBUF_FLAG_LOCAL_INV_ALPHA = $0020;
  {struct v4l2_clip	__user *next; }

  type
     Pv4l2_clip = ^v4l2_clip;
     v4l2_clip = record
          c : v4l2_rect;
          next : Pv4l2_clip;
       end;

  {struct v4l2_clip	__user *clips; }
  {void			__user *bitmap; }
     Pv4l2_window = ^v4l2_window;
     v4l2_window = record
          w : v4l2_rect;
          field : v4l2_field;
          chromakey : __u32;
          clips : Pv4l2_clip;
          clipcount : __u32;
          bitmap : pointer;
          global_alpha : __u8;
       end;

  {
   *	C A P T U R E   P A R A M E T E R S
    }
  {  Supported modes  }
  {  Current mode  }
  {  Time per frame in .1us units  }
  {  Driver-specific extensions  }
  {  # of buffers for read  }
     Pv4l2_captureparm = ^v4l2_captureparm;
     v4l2_captureparm = record
          capability : __u32;
          capturemode : __u32;
          timeperframe : v4l2_fract;
          extendedmode : __u32;
          readbuffers : __u32;
          reserved : array[0..3] of __u32;
       end;

  {  Flags for 'capability' and 'capturemode' fields  }

  const
     V4L2_MODE_HIGHQUALITY = $0001;
  {  High quality imaging mode  }
     V4L2_CAP_TIMEPERFRAME = $1000;
  {  timeperframe field is supported  }
  {  Supported modes  }
  {  Current mode  }
  {  Time per frame in seconds  }
  {  Driver-specific extensions  }
  {  # of buffers for write  }

  type
     Pv4l2_outputparm = ^v4l2_outputparm;
     v4l2_outputparm = record
          capability : __u32;
          outputmode : __u32;
          timeperframe : v4l2_fract;
          extendedmode : __u32;
          writebuffers : __u32;
          reserved : array[0..3] of __u32;
       end;

  {
   *	I N P U T   I M A G E   C R O P P I N G
    }
     Pv4l2_cropcap = ^v4l2_cropcap;
     v4l2_cropcap = record
          _type : v4l2_buf_type;
          bounds : v4l2_rect;
          defrect : v4l2_rect;
          pixelaspect : v4l2_fract;
       end;

     Pv4l2_crop = ^v4l2_crop;
     v4l2_crop = record
          _type : v4l2_buf_type;
          c : v4l2_rect;
       end;

  {
   *      A N A L O G   V I D E O   S T A N D A R D
    }

     Pv4l2_std_id = ^v4l2_std_id;
     v4l2_std_id = __u64;
  { one bit for each  }
  { was #define dname def_expr }
  function V4L2_STD_PAL_B : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_PAL_B1 : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_PAL_G : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_PAL_H : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_PAL_I : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_PAL_D : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_PAL_D1 : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_PAL_K : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_PAL_M : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_PAL_N : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_PAL_Nc : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_PAL_60 : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_NTSC_M : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_NTSC_M_JP : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_NTSC_443 : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_NTSC_M_KR : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_B : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_D : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_G : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_H : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_K : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_K1 : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_L : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_LC : v4l2_std_id;

  { ATSC/HDTV  }
  { was #define dname def_expr }
  function V4L2_STD_ATSC_8_VSB : v4l2_std_id;

  { was #define dname def_expr }
  function V4L2_STD_ATSC_16_VSB : v4l2_std_id;

  { FIXME:
     Although std_id is 64 bits, there is an issue on PPC32 architecture that
     makes switch(__u64) to break. So, there's a hack on v4l2-common.c rounding
     this value to 32 bits.
     As, currently, the max value is for V4L2_STD_ATSC_16_VSB (30 bits wide),
     it should work fine. However, if needed to add more than two standards,
     v4l2-common.c should be fixed.
    }
  { some merged standards  }

  {const
     V4L2_STD_NTSC = (V4L2_STD_NTSC_M or V4L2_STD_NTSC_M_JP) or V4L2_STD_NTSC_M_KR;

     V4L2_STD_MN = ((V4L2_STD_PAL_M or V4L2_STD_PAL_N) or V4L2_STD_PAL_Nc) or V4L2_STD_NTSC;
     V4L2_STD_B = (V4L2_STD_PAL_B or V4L2_STD_PAL_B1) or V4L2_STD_SECAM_B;
     V4L2_STD_GH = ((V4L2_STD_PAL_G or V4L2_STD_PAL_H) or V4L2_STD_SECAM_G) or V4L2_STD_SECAM_H;
     V4L2_STD_DK = V4L2_STD_PAL_DK or V4L2_STD_SECAM_DK;
     V4L2_STD_PAL_BG = (V4L2_STD_PAL_B or V4L2_STD_PAL_B1) or V4L2_STD_PAL_G;
     V4L2_STD_PAL_DK = (V4L2_STD_PAL_D or V4L2_STD_PAL_D1) or V4L2_STD_PAL_K;
     V4L2_STD_PAL = ((V4L2_STD_PAL_BG or V4L2_STD_PAL_DK) or V4L2_STD_PAL_H) or V4L2_STD_PAL_I;
     //V4L2_STD_NTSC = (V4L2_STD_NTSC_M or V4L2_STD_NTSC_M_JP) or V4L2_STD_NTSC_M_KR;
     V4L2_STD_SECAM_DK = (V4L2_STD_SECAM_D or V4L2_STD_SECAM_K) or V4L2_STD_SECAM_K1;
     V4L2_STD_SECAM = ((((V4L2_STD_SECAM_B or V4L2_STD_SECAM_G) or V4L2_STD_SECAM_H) or V4L2_STD_SECAM_DK) or V4L2_STD_SECAM_L) or V4L2_STD_SECAM_LC;
     V4L2_STD_525_60 = ((V4L2_STD_PAL_M or V4L2_STD_PAL_60) or V4L2_STD_NTSC) or V4L2_STD_NTSC_443;
     V4L2_STD_625_50 = ((V4L2_STD_PAL or V4L2_STD_PAL_N) or V4L2_STD_PAL_Nc) or V4L2_STD_SECAM;
     V4L2_STD_ATSC = V4L2_STD_ATSC_8_VSB or V4L2_STD_ATSC_16_VSB;
     V4L2_STD_UNKNOWN = 0;
     V4L2_STD_ALL = V4L2_STD_525_60 or V4L2_STD_625_50;}
  { Frames, not fields  }

  type
     Pv4l2_standard = ^v4l2_standard;
     v4l2_standard = record
          index : __u32;
          id : v4l2_std_id;
          name : array[0..23] of __u8;
          frameperiod : v4l2_fract;
          framelines : __u32;
          reserved : array[0..3] of __u32;
       end;

  {
   *	V I D E O   I N P U T S
    }
  {  Which input  }
  {  Label  }
  {  Type of input  }
  {  Associated audios (bitfield)  }
  {  Associated tuner  }
     Pv4l2_input = ^v4l2_input;
     v4l2_input = record
          index : __u32;
          name : array[0..31] of __u8;
          _type : __u32;
          audioset : __u32;
          tuner : __u32;
          std : v4l2_std_id;
          status : __u32;
          reserved : array[0..3] of __u32;
       end;

  {  Values for the 'type' field  }

  const
     V4L2_INPUT_TYPE_TUNER = 1;
     V4L2_INPUT_TYPE_CAMERA = 2;
  { field 'status' - general  }
     V4L2_IN_ST_NO_POWER = $00000001;
  { Attached device is off  }
     V4L2_IN_ST_NO_SIGNAL = $00000002;
     V4L2_IN_ST_NO_COLOR = $00000004;
  { field 'status' - analog  }
     V4L2_IN_ST_NO_H_LOCK = $00000100;
  { No horizontal sync lock  }
     V4L2_IN_ST_COLOR_KILL = $00000200;
  { Color killer is active  }
  { field 'status' - digital  }
     V4L2_IN_ST_NO_SYNC = $00010000;
  { No synchronization lock  }
     V4L2_IN_ST_NO_EQU = $00020000;
  { No equalizer lock  }
     V4L2_IN_ST_NO_CARRIER = $00040000;
  { Carrier recovery failed  }
  { field 'status' - VCR and set-top box  }
     V4L2_IN_ST_MACROVISION = $01000000;
  { Macrovision detected  }
     V4L2_IN_ST_NO_ACCESS = $02000000;
  { Conditional access denied  }
     V4L2_IN_ST_VTR = $04000000;
  { VTR time constant  }
  {
   *	V I D E O   O U T P U T S
    }
  {  Which output  }
  {  Label  }
  {  Type of output  }
  {  Associated audios (bitfield)  }
  {  Associated modulator  }

  type
     Pv4l2_output = ^v4l2_output;
     v4l2_output = record
          index : __u32;
          name : array[0..31] of __u8;
          _type : __u32;
          audioset : __u32;
          modulator : __u32;
          std : v4l2_std_id;
          reserved : array[0..3] of __u32;
       end;

  {  Values for the 'type' field  }

  const
     V4L2_OUTPUT_TYPE_MODULATOR = 1;
     V4L2_OUTPUT_TYPE_ANALOG = 2;
     V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY = 3;
  {
   *	C O N T R O L S
    }

  type
     Pv4l2_control = ^v4l2_control;
     v4l2_control = record
          id : __u32;
          value : __s32;
       end;

  {union  }
  {	__s32 value; }
  {	void *reserved; }
  {; }
  { __attribute__ ((packed)); }
     Pv4l2_ext_control = ^v4l2_ext_control;
     v4l2_ext_control = record
          id : __u32;
          reserved2 : array[0..1] of __u32;
          value64 : __s64;
       end;

     Pv4l2_ext_controls = ^v4l2_ext_controls;
     v4l2_ext_controls = record
          ctrl_class : __u32;
          count : __u32;
          error_idx : __u32;
          reserved : array[0..1] of __u32;
          controls : Pv4l2_ext_control;
       end;

  {  Values for ctrl_class field  }

  const
     V4L2_CTRL_CLASS_USER = $00980000;
  { Old-style 'user' controls  }
     V4L2_CTRL_CLASS_MPEG = $00990000;
  { MPEG-compression controls  }
     V4L2_CTRL_CLASS_CAMERA = $009a0000;
  { Camera class controls  }
     V4L2_CTRL_ID_MASK = $0fffffff;
  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  //function V4L2_CTRL_ID2CLASS(id : longint) : id;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  //function V4L2_CTRL_DRIVER_PRIV(id : longint) : longint;

  {  Used in the VIDIOC_QUERYCTRL ioctl for querying controls  }
  { Whatever  }
  { Note signedness  }

  type
     Pv4l2_queryctrl = ^v4l2_queryctrl;
     v4l2_queryctrl = record
          id : __u32;
          _type : v4l2_ctrl_type;
          name : array[0..31] of __u8;
          minimum : __s32;
          maximum : __s32;
          step : __s32;
          default_value : __s32;
          flags : __u32;
          reserved : array[0..1] of __u32;
       end;

  {  Used in the VIDIOC_QUERYMENU ioctl for querying menu items  }
  { Whatever  }
     Pv4l2_querymenu = ^v4l2_querymenu;
     v4l2_querymenu = record
          id : __u32;
          index : __u32;
          name : array[0..31] of __u8;
          reserved : __u32;
       end;

  {  Control flags   }

  const
     V4L2_CTRL_FLAG_DISABLED = $0001;
     V4L2_CTRL_FLAG_GRABBED = $0002;
     V4L2_CTRL_FLAG_READ_ONLY = $0004;
     V4L2_CTRL_FLAG_UPDATE = $0008;
     V4L2_CTRL_FLAG_INACTIVE = $0010;
     V4L2_CTRL_FLAG_SLIDER = $0020;
  {  Query flag, to be ORed with the control ID  }
     V4L2_CTRL_FLAG_NEXT_CTRL = $80000000;
  {  User-class control IDs defined by V4L2  }
     V4L2_CID_BASE = V4L2_CTRL_CLASS_USER or $900;
     V4L2_CID_USER_BASE = V4L2_CID_BASE;
  {  IDs reserved for driver specific controls  }
     V4L2_CID_PRIVATE_BASE = $08000000;
     V4L2_CID_USER_CLASS = V4L2_CTRL_CLASS_USER or 1;
     V4L2_CID_BRIGHTNESS = V4L2_CID_BASE+0;
     V4L2_CID_CONTRAST = V4L2_CID_BASE+1;
     V4L2_CID_SATURATION = V4L2_CID_BASE+2;
     V4L2_CID_HUE = V4L2_CID_BASE+3;
     V4L2_CID_AUDIO_VOLUME = V4L2_CID_BASE+5;
     V4L2_CID_AUDIO_BALANCE = V4L2_CID_BASE+6;
     V4L2_CID_AUDIO_BASS = V4L2_CID_BASE+7;
     V4L2_CID_AUDIO_TREBLE = V4L2_CID_BASE+8;
     V4L2_CID_AUDIO_MUTE = V4L2_CID_BASE+9;
     V4L2_CID_AUDIO_LOUDNESS = V4L2_CID_BASE+10;
  {#define V4L2_CID_BLACK_LEVEL		(V4L2_CID_BASE+11) /* Deprecated */ }
     V4L2_CID_AUTO_WHITE_BALANCE = V4L2_CID_BASE+12;
     V4L2_CID_DO_WHITE_BALANCE = V4L2_CID_BASE+13;
     V4L2_CID_RED_BALANCE = V4L2_CID_BASE+14;
     V4L2_CID_BLUE_BALANCE = V4L2_CID_BASE+15;
     V4L2_CID_GAMMA = V4L2_CID_BASE+16;
  {#define V4L2_CID_WHITENESS		(V4L2_CID_GAMMA) /* Deprecated */ }
     V4L2_CID_EXPOSURE = V4L2_CID_BASE+17;
     V4L2_CID_AUTOGAIN = V4L2_CID_BASE+18;
     V4L2_CID_GAIN = V4L2_CID_BASE+19;
     V4L2_CID_HFLIP = V4L2_CID_BASE+20;
     V4L2_CID_VFLIP = V4L2_CID_BASE+21;
  { Deprecated; use V4L2_CID_PAN_RESET and V4L2_CID_TILT_RESET  }
     V4L2_CID_HCENTER = V4L2_CID_BASE+22;
     V4L2_CID_VCENTER = V4L2_CID_BASE+23;
     V4L2_CID_POWER_LINE_FREQUENCY = V4L2_CID_BASE+24;

  type
     v4l2_power_line_frequency =  Longint;
     Const
       V4L2_CID_POWER_LINE_FREQUENCY_DISABLED = 0;
       V4L2_CID_POWER_LINE_FREQUENCY_50HZ = 1;
       V4L2_CID_POWER_LINE_FREQUENCY_60HZ = 2;

     V4L2_CID_HUE_AUTO = V4L2_CID_BASE+25;
     V4L2_CID_WHITE_BALANCE_TEMPERATURE = V4L2_CID_BASE+26;
     V4L2_CID_SHARPNESS = V4L2_CID_BASE+27;
     V4L2_CID_BACKLIGHT_COMPENSATION = V4L2_CID_BASE+28;
     V4L2_CID_CHROMA_AGC = V4L2_CID_BASE+29;
     V4L2_CID_COLOR_KILLER = V4L2_CID_BASE+30;
     V4L2_CID_COLORFX = V4L2_CID_BASE+31;

  type
     v4l2_colorfx =  Longint;
     Const
       V4L2_COLORFX_NONE = 0;
       V4L2_COLORFX_BW = 1;
       V4L2_COLORFX_SEPIA = 2;

  { last CID + 1  }
     V4L2_CID_LASTP1 = V4L2_CID_BASE+32;
  {  MPEG-class control IDs defined by V4L2  }
     V4L2_CID_MPEG_BASE = V4L2_CTRL_CLASS_MPEG or $900;
     V4L2_CID_MPEG_CLASS = V4L2_CTRL_CLASS_MPEG or 1;
  {  MPEG streams  }
     V4L2_CID_MPEG_STREAM_TYPE = V4L2_CID_MPEG_BASE+0;
  { MPEG-2 program stream  }
  { MPEG-2 transport stream  }
  { MPEG-1 system stream  }
  { MPEG-2 DVD-compatible stream  }
  { MPEG-1 VCD-compatible stream  }
  { MPEG-2 SVCD-compatible stream  }

  type
     v4l2_mpeg_stream_type =  Longint;
     Const
       V4L2_MPEG_STREAM_TYPE_MPEG2_PS = 0;
       V4L2_MPEG_STREAM_TYPE_MPEG2_TS = 1;
       V4L2_MPEG_STREAM_TYPE_MPEG1_SS = 2;
       V4L2_MPEG_STREAM_TYPE_MPEG2_DVD = 3;
       V4L2_MPEG_STREAM_TYPE_MPEG1_VCD = 4;
       V4L2_MPEG_STREAM_TYPE_MPEG2_SVCD = 5;

     V4L2_CID_MPEG_STREAM_PID_PMT = V4L2_CID_MPEG_BASE+1;
     V4L2_CID_MPEG_STREAM_PID_AUDIO = V4L2_CID_MPEG_BASE+2;
     V4L2_CID_MPEG_STREAM_PID_VIDEO = V4L2_CID_MPEG_BASE+3;
     V4L2_CID_MPEG_STREAM_PID_PCR = V4L2_CID_MPEG_BASE+4;
     V4L2_CID_MPEG_STREAM_PES_ID_AUDIO = V4L2_CID_MPEG_BASE+5;
     V4L2_CID_MPEG_STREAM_PES_ID_VIDEO = V4L2_CID_MPEG_BASE+6;
     V4L2_CID_MPEG_STREAM_VBI_FMT = V4L2_CID_MPEG_BASE+7;
  { No VBI in the MPEG stream  }
  { VBI in private packets, IVTV format  }

  type
     v4l2_mpeg_stream_vbi_fmt =  Longint;
     Const
       V4L2_MPEG_STREAM_VBI_FMT_NONE = 0;
       V4L2_MPEG_STREAM_VBI_FMT_IVTV = 1;

  {  MPEG audio  }
     V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ = V4L2_CID_MPEG_BASE+100;

  type
     v4l2_mpeg_audio_sampling_freq =  Longint;
     Const
       V4L2_MPEG_AUDIO_SAMPLING_FREQ_44100 = 0;
       V4L2_MPEG_AUDIO_SAMPLING_FREQ_48000 = 1;
       V4L2_MPEG_AUDIO_SAMPLING_FREQ_32000 = 2;

     V4L2_CID_MPEG_AUDIO_ENCODING = V4L2_CID_MPEG_BASE+101;

  type
     v4l2_mpeg_audio_encoding =  Longint;
     Const
       V4L2_MPEG_AUDIO_ENCODING_LAYER_1 = 0;
       V4L2_MPEG_AUDIO_ENCODING_LAYER_2 = 1;
       V4L2_MPEG_AUDIO_ENCODING_LAYER_3 = 2;
       V4L2_MPEG_AUDIO_ENCODING_AAC = 3;
       V4L2_MPEG_AUDIO_ENCODING_AC3 = 4;

     V4L2_CID_MPEG_AUDIO_L1_BITRATE = V4L2_CID_MPEG_BASE+102;

  type
     v4l2_mpeg_audio_l1_bitrate =  Longint;
     Const
       V4L2_MPEG_AUDIO_L1_BITRATE_32K = 0;
       V4L2_MPEG_AUDIO_L1_BITRATE_64K = 1;
       V4L2_MPEG_AUDIO_L1_BITRATE_96K = 2;
       V4L2_MPEG_AUDIO_L1_BITRATE_128K = 3;
       V4L2_MPEG_AUDIO_L1_BITRATE_160K = 4;
       V4L2_MPEG_AUDIO_L1_BITRATE_192K = 5;
       V4L2_MPEG_AUDIO_L1_BITRATE_224K = 6;
       V4L2_MPEG_AUDIO_L1_BITRATE_256K = 7;
       V4L2_MPEG_AUDIO_L1_BITRATE_288K = 8;
       V4L2_MPEG_AUDIO_L1_BITRATE_320K = 9;
       V4L2_MPEG_AUDIO_L1_BITRATE_352K = 10;
       V4L2_MPEG_AUDIO_L1_BITRATE_384K = 11;
       V4L2_MPEG_AUDIO_L1_BITRATE_416K = 12;
       V4L2_MPEG_AUDIO_L1_BITRATE_448K = 13;

     V4L2_CID_MPEG_AUDIO_L2_BITRATE = V4L2_CID_MPEG_BASE+103;

  type
     v4l2_mpeg_audio_l2_bitrate =  Longint;
     Const
       V4L2_MPEG_AUDIO_L2_BITRATE_32K = 0;
       V4L2_MPEG_AUDIO_L2_BITRATE_48K = 1;
       V4L2_MPEG_AUDIO_L2_BITRATE_56K = 2;
       V4L2_MPEG_AUDIO_L2_BITRATE_64K = 3;
       V4L2_MPEG_AUDIO_L2_BITRATE_80K = 4;
       V4L2_MPEG_AUDIO_L2_BITRATE_96K = 5;
       V4L2_MPEG_AUDIO_L2_BITRATE_112K = 6;
       V4L2_MPEG_AUDIO_L2_BITRATE_128K = 7;
       V4L2_MPEG_AUDIO_L2_BITRATE_160K = 8;
       V4L2_MPEG_AUDIO_L2_BITRATE_192K = 9;
       V4L2_MPEG_AUDIO_L2_BITRATE_224K = 10;
       V4L2_MPEG_AUDIO_L2_BITRATE_256K = 11;
       V4L2_MPEG_AUDIO_L2_BITRATE_320K = 12;
       V4L2_MPEG_AUDIO_L2_BITRATE_384K = 13;

     V4L2_CID_MPEG_AUDIO_L3_BITRATE = V4L2_CID_MPEG_BASE+104;

  type
     v4l2_mpeg_audio_l3_bitrate =  Longint;
     Const
       V4L2_MPEG_AUDIO_L3_BITRATE_32K = 0;
       V4L2_MPEG_AUDIO_L3_BITRATE_40K = 1;
       V4L2_MPEG_AUDIO_L3_BITRATE_48K = 2;
       V4L2_MPEG_AUDIO_L3_BITRATE_56K = 3;
       V4L2_MPEG_AUDIO_L3_BITRATE_64K = 4;
       V4L2_MPEG_AUDIO_L3_BITRATE_80K = 5;
       V4L2_MPEG_AUDIO_L3_BITRATE_96K = 6;
       V4L2_MPEG_AUDIO_L3_BITRATE_112K = 7;
       V4L2_MPEG_AUDIO_L3_BITRATE_128K = 8;
       V4L2_MPEG_AUDIO_L3_BITRATE_160K = 9;
       V4L2_MPEG_AUDIO_L3_BITRATE_192K = 10;
       V4L2_MPEG_AUDIO_L3_BITRATE_224K = 11;
       V4L2_MPEG_AUDIO_L3_BITRATE_256K = 12;
       V4L2_MPEG_AUDIO_L3_BITRATE_320K = 13;

     V4L2_CID_MPEG_AUDIO_MODE = V4L2_CID_MPEG_BASE+105;

  type
     v4l2_mpeg_audio_mode =  Longint;
     Const
       V4L2_MPEG_AUDIO_MODE_STEREO = 0;
       V4L2_MPEG_AUDIO_MODE_JOINT_STEREO = 1;
       V4L2_MPEG_AUDIO_MODE_DUAL = 2;
       V4L2_MPEG_AUDIO_MODE_MONO = 3;

     V4L2_CID_MPEG_AUDIO_MODE_EXTENSION = V4L2_CID_MPEG_BASE+106;

  type
     v4l2_mpeg_audio_mode_extension =  Longint;
     Const
       V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_4 = 0;
       V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_8 = 1;
       V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_12 = 2;
       V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_16 = 3;

     V4L2_CID_MPEG_AUDIO_EMPHASIS = V4L2_CID_MPEG_BASE+107;

  type
     v4l2_mpeg_audio_emphasis =  Longint;
     Const
       V4L2_MPEG_AUDIO_EMPHASIS_NONE = 0;
       V4L2_MPEG_AUDIO_EMPHASIS_50_DIV_15_uS = 1;
       V4L2_MPEG_AUDIO_EMPHASIS_CCITT_J17 = 2;

     V4L2_CID_MPEG_AUDIO_CRC = V4L2_CID_MPEG_BASE+108;

  type
     v4l2_mpeg_audio_crc =  Longint;
     Const
       V4L2_MPEG_AUDIO_CRC_NONE = 0;
       V4L2_MPEG_AUDIO_CRC_CRC16 = 1;

     V4L2_CID_MPEG_AUDIO_MUTE = V4L2_CID_MPEG_BASE+109;
     V4L2_CID_MPEG_AUDIO_AAC_BITRATE = V4L2_CID_MPEG_BASE+110;
     V4L2_CID_MPEG_AUDIO_AC3_BITRATE = V4L2_CID_MPEG_BASE+111;

  type
     v4l2_mpeg_audio_ac3_bitrate =  Longint;
     Const
       V4L2_MPEG_AUDIO_AC3_BITRATE_32K = 0;
       V4L2_MPEG_AUDIO_AC3_BITRATE_40K = 1;
       V4L2_MPEG_AUDIO_AC3_BITRATE_48K = 2;
       V4L2_MPEG_AUDIO_AC3_BITRATE_56K = 3;
       V4L2_MPEG_AUDIO_AC3_BITRATE_64K = 4;
       V4L2_MPEG_AUDIO_AC3_BITRATE_80K = 5;
       V4L2_MPEG_AUDIO_AC3_BITRATE_96K = 6;
       V4L2_MPEG_AUDIO_AC3_BITRATE_112K = 7;
       V4L2_MPEG_AUDIO_AC3_BITRATE_128K = 8;
       V4L2_MPEG_AUDIO_AC3_BITRATE_160K = 9;
       V4L2_MPEG_AUDIO_AC3_BITRATE_192K = 10;
       V4L2_MPEG_AUDIO_AC3_BITRATE_224K = 11;
       V4L2_MPEG_AUDIO_AC3_BITRATE_256K = 12;
       V4L2_MPEG_AUDIO_AC3_BITRATE_320K = 13;
       V4L2_MPEG_AUDIO_AC3_BITRATE_384K = 14;
       V4L2_MPEG_AUDIO_AC3_BITRATE_448K = 15;
       V4L2_MPEG_AUDIO_AC3_BITRATE_512K = 16;
       V4L2_MPEG_AUDIO_AC3_BITRATE_576K = 17;
       V4L2_MPEG_AUDIO_AC3_BITRATE_640K = 18;

  {  MPEG video  }
     V4L2_CID_MPEG_VIDEO_ENCODING = V4L2_CID_MPEG_BASE+200;

  type
     v4l2_mpeg_video_encoding =  Longint;
     Const
       V4L2_MPEG_VIDEO_ENCODING_MPEG_1 = 0;
       V4L2_MPEG_VIDEO_ENCODING_MPEG_2 = 1;
       V4L2_MPEG_VIDEO_ENCODING_MPEG_4_AVC = 2;

     V4L2_CID_MPEG_VIDEO_ASPECT = V4L2_CID_MPEG_BASE+201;

  type
     v4l2_mpeg_video_aspect =  Longint;
     Const
       V4L2_MPEG_VIDEO_ASPECT_1x1 = 0;
       V4L2_MPEG_VIDEO_ASPECT_4x3 = 1;
       V4L2_MPEG_VIDEO_ASPECT_16x9 = 2;
       V4L2_MPEG_VIDEO_ASPECT_221x100 = 3;

     V4L2_CID_MPEG_VIDEO_B_FRAMES = V4L2_CID_MPEG_BASE+202;
     V4L2_CID_MPEG_VIDEO_GOP_SIZE = V4L2_CID_MPEG_BASE+203;
     V4L2_CID_MPEG_VIDEO_GOP_CLOSURE = V4L2_CID_MPEG_BASE+204;
     V4L2_CID_MPEG_VIDEO_PULLDOWN = V4L2_CID_MPEG_BASE+205;
     V4L2_CID_MPEG_VIDEO_BITRATE_MODE = V4L2_CID_MPEG_BASE+206;

  type
     v4l2_mpeg_video_bitrate_mode =  Longint;
     Const
       V4L2_MPEG_VIDEO_BITRATE_MODE_VBR = 0;
       V4L2_MPEG_VIDEO_BITRATE_MODE_CBR = 1;

     V4L2_CID_MPEG_VIDEO_BITRATE = V4L2_CID_MPEG_BASE+207;
     V4L2_CID_MPEG_VIDEO_BITRATE_PEAK = V4L2_CID_MPEG_BASE+208;
     V4L2_CID_MPEG_VIDEO_TEMPORAL_DECIMATION = V4L2_CID_MPEG_BASE+209;
     V4L2_CID_MPEG_VIDEO_MUTE = V4L2_CID_MPEG_BASE+210;
     V4L2_CID_MPEG_VIDEO_MUTE_YUV = V4L2_CID_MPEG_BASE+211;
  {  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2  }
     V4L2_CID_MPEG_CX2341X_BASE = V4L2_CTRL_CLASS_MPEG or $1000;
     V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE = V4L2_CID_MPEG_CX2341X_BASE+0;

  type
     v4l2_mpeg_cx2341x_video_spatial_filter_mode =  Longint;
     Const
       V4L2_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE_MANUAL = 0;
       V4L2_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE_AUTO = 1;

     V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER = V4L2_CID_MPEG_CX2341X_BASE+1;
     V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE = V4L2_CID_MPEG_CX2341X_BASE+2;

  type
     v4l2_mpeg_cx2341x_video_luma_spatial_filter_type =  Longint;
     Const
       V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_OFF = 0;
       V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_1D_HOR = 1;
       V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_1D_VERT = 2;
       V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_2D_HV_SEPARABLE = 3;
       V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_2D_SYM_NON_SEPARABLE = 4;

     V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE = V4L2_CID_MPEG_CX2341X_BASE+3;

  type
     v4l2_mpeg_cx2341x_video_chroma_spatial_filter_type =  Longint;
     Const
       V4L2_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE_OFF = 0;
       V4L2_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE_1D_HOR = 1;

     V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE = V4L2_CID_MPEG_CX2341X_BASE+4;

  type
     v4l2_mpeg_cx2341x_video_temporal_filter_mode =  Longint;
     Const
       V4L2_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE_MANUAL = 0;
       V4L2_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE_AUTO = 1;

     V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER = V4L2_CID_MPEG_CX2341X_BASE+5;
     V4L2_CID_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE = V4L2_CID_MPEG_CX2341X_BASE+6;

  type
     v4l2_mpeg_cx2341x_video_median_filter_type =  Longint;
     Const
       V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_OFF = 0;
       V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_HOR = 1;
       V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_VERT = 2;
       V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_HOR_VERT = 3;
       V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_DIAG = 4;

     V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_BOTTOM = V4L2_CID_MPEG_CX2341X_BASE+7;
     V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_TOP = V4L2_CID_MPEG_CX2341X_BASE+8;
     V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_BOTTOM = V4L2_CID_MPEG_CX2341X_BASE+9;
     V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_TOP = V4L2_CID_MPEG_CX2341X_BASE+10;
     V4L2_CID_MPEG_CX2341X_STREAM_INSERT_NAV_PACKETS = V4L2_CID_MPEG_CX2341X_BASE+11;
  {  Camera class control IDs  }
     V4L2_CID_CAMERA_CLASS_BASE = V4L2_CTRL_CLASS_CAMERA or $900;
     V4L2_CID_CAMERA_CLASS = V4L2_CTRL_CLASS_CAMERA or 1;
     V4L2_CID_EXPOSURE_AUTO = V4L2_CID_CAMERA_CLASS_BASE+1;

  type
     v4l2_exposure_auto_type =  Longint;
     Const
       V4L2_EXPOSURE_AUTO = 0;
       V4L2_EXPOSURE_MANUAL = 1;
       V4L2_EXPOSURE_SHUTTER_PRIORITY = 2;
       V4L2_EXPOSURE_APERTURE_PRIORITY = 3;

     V4L2_CID_EXPOSURE_ABSOLUTE = V4L2_CID_CAMERA_CLASS_BASE+2;
     V4L2_CID_EXPOSURE_AUTO_PRIORITY = V4L2_CID_CAMERA_CLASS_BASE+3;
     V4L2_CID_PAN_RELATIVE = V4L2_CID_CAMERA_CLASS_BASE+4;
     V4L2_CID_TILT_RELATIVE = V4L2_CID_CAMERA_CLASS_BASE+5;
     V4L2_CID_PAN_RESET = V4L2_CID_CAMERA_CLASS_BASE+6;
     V4L2_CID_TILT_RESET = V4L2_CID_CAMERA_CLASS_BASE+7;
     V4L2_CID_PAN_ABSOLUTE = V4L2_CID_CAMERA_CLASS_BASE+8;
     V4L2_CID_TILT_ABSOLUTE = V4L2_CID_CAMERA_CLASS_BASE+9;
     V4L2_CID_FOCUS_ABSOLUTE = V4L2_CID_CAMERA_CLASS_BASE+10;
     V4L2_CID_FOCUS_RELATIVE = V4L2_CID_CAMERA_CLASS_BASE+11;
     V4L2_CID_FOCUS_AUTO = V4L2_CID_CAMERA_CLASS_BASE+12;
     V4L2_CID_ZOOM_ABSOLUTE = V4L2_CID_CAMERA_CLASS_BASE+13;
     V4L2_CID_ZOOM_RELATIVE = V4L2_CID_CAMERA_CLASS_BASE+14;
     V4L2_CID_ZOOM_CONTINUOUS = V4L2_CID_CAMERA_CLASS_BASE+15;
     V4L2_CID_PRIVACY = V4L2_CID_CAMERA_CLASS_BASE+16;
  {
   *	T U N I N G
    }

  type
     Pv4l2_tuner = ^v4l2_tuner;
     v4l2_tuner = record
          index : __u32;
          name : array[0..31] of __u8;
          _type : v4l2_tuner_type;
          capability : __u32;
          rangelow : __u32;
          rangehigh : __u32;
          rxsubchans : __u32;
          audmode : __u32;
          signal : __s32;
          afc : __s32;
          reserved : array[0..3] of __u32;
       end;

     Pv4l2_modulator = ^v4l2_modulator;
     v4l2_modulator = record
          index : __u32;
          name : array[0..31] of __u8;
          capability : __u32;
          rangelow : __u32;
          rangehigh : __u32;
          txsubchans : __u32;
          reserved : array[0..3] of __u32;
       end;

  {  Flags for the 'capability' field  }

  const
     V4L2_TUNER_CAP_LOW = $0001;
     V4L2_TUNER_CAP_NORM = $0002;
     V4L2_TUNER_CAP_STEREO = $0010;
     V4L2_TUNER_CAP_LANG2 = $0020;
     V4L2_TUNER_CAP_SAP = $0020;
     V4L2_TUNER_CAP_LANG1 = $0040;
  {  Flags for the 'rxsubchans' field  }
     V4L2_TUNER_SUB_MONO = $0001;
     V4L2_TUNER_SUB_STEREO = $0002;
     V4L2_TUNER_SUB_LANG2 = $0004;
     V4L2_TUNER_SUB_SAP = $0004;
     V4L2_TUNER_SUB_LANG1 = $0008;
  {  Values for the 'audmode' field  }
     V4L2_TUNER_MODE_MONO = $0000;
     V4L2_TUNER_MODE_STEREO = $0001;
     V4L2_TUNER_MODE_LANG2 = $0002;
     V4L2_TUNER_MODE_SAP = $0002;
     V4L2_TUNER_MODE_LANG1 = $0003;
     V4L2_TUNER_MODE_LANG1_LANG2 = $0004;

  type
     Pv4l2_frequency = ^v4l2_frequency;
     v4l2_frequency = record
          tuner : __u32;
          _type : v4l2_tuner_type;
          frequency : __u32;
          reserved : array[0..7] of __u32;
       end;

     Pv4l2_hw_freq_seek = ^v4l2_hw_freq_seek;
     v4l2_hw_freq_seek = record
          tuner : __u32;
          _type : v4l2_tuner_type;
          seek_upward : __u32;
          wrap_around : __u32;
          reserved : array[0..7] of __u32;
       end;

  {
   *	A U D I O
    }
     Pv4l2_audio = ^v4l2_audio;
     v4l2_audio = record
          index : __u32;
          name : array[0..31] of __u8;
          capability : __u32;
          mode : __u32;
          reserved : array[0..1] of __u32;
       end;

  {  Flags for the 'capability' field  }

  const
     V4L2_AUDCAP_STEREO = $00001;
     V4L2_AUDCAP_AVL = $00002;
  {  Flags for the 'mode' field  }
     V4L2_AUDMODE_AVL = $00001;

  type
     Pv4l2_audioout = ^v4l2_audioout;
     v4l2_audioout = record
          index : __u32;
          name : array[0..31] of __u8;
          capability : __u32;
          mode : __u32;
          reserved : array[0..1] of __u32;
       end;

  {
   *	M P E G   S E R V I C E S
   *
   *	NOTE: EXPERIMENTAL API
    }
//{$if 1 /*KEEP*/}

  const
     V4L2_ENC_IDX_FRAME_I = 0;
     V4L2_ENC_IDX_FRAME_P = 1;
     V4L2_ENC_IDX_FRAME_B = 2;
     V4L2_ENC_IDX_FRAME_MASK = $f;

  type
     Pv4l2_enc_idx_entry = ^v4l2_enc_idx_entry;
     v4l2_enc_idx_entry = record
          offset : __u64;
          pts : __u64;
          length : __u32;
          flags : __u32;
          reserved : array[0..1] of __u32;
       end;


  const
     V4L2_ENC_IDX_ENTRIES = 64;

  type
     Pv4l2_enc_idx = ^v4l2_enc_idx;
     v4l2_enc_idx = record
          entries : __u32;
          entries_cap : __u32;
          reserved : array[0..3] of __u32;
          entry : array[0..(V4L2_ENC_IDX_ENTRIES)-1] of v4l2_enc_idx_entry;
       end;


  const
     V4L2_ENC_CMD_START = 0;
     V4L2_ENC_CMD_STOP = 1;
     V4L2_ENC_CMD_PAUSE = 2;
     V4L2_ENC_CMD_RESUME = 3;
  { Flags for V4L2_ENC_CMD_STOP  }
     V4L2_ENC_CMD_STOP_AT_GOP_END = 1 shl 0;
  {union  }
  {; }

  type
     Pv4l2_encoder_cmd = ^v4l2_encoder_cmd;
     v4l2_encoder_cmd = record
          cmd : __u32;
          flags : __u32;
          raw : record
               data : array[0..7] of __u32;
            end;
       end;

//{$endif}
  {
   *	D A T A   S E R V I C E S   ( V B I )
   *
   *	Data services API by Michael Schimek
    }
  { Raw VBI  }
  { in 1 Hz  }
  { V4L2_PIX_FMT_*  }
  { V4L2_VBI_*  }
  { must be zero  }

  type
     Pv4l2_vbi_format = ^v4l2_vbi_format;
     v4l2_vbi_format = record
          sampling_rate : __u32;
          offset : __u32;
          samples_per_line : __u32;
          sample_format : __u32;
          start : array[0..1] of __s32;
          count : array[0..1] of __u32;
          flags : __u32;
          reserved : array[0..1] of __u32;
       end;

  {  VBI flags   }

  const
     V4L2_VBI_UNSYNC = 1 shl 0;
     V4L2_VBI_INTERLACED = 1 shl 1;
  { Sliced VBI
   *
   *    This implements is a proposal V4L2 API to allow SLICED VBI
   * required for some hardware encoders. It should change without
   * notice in the definitive implementation.
    }
  { service_lines[0][...] specifies lines 0-23 (1-23 used) of the first field
  	   service_lines[1][...] specifies lines 0-23 (1-23 used) of the second field
  				 (equals frame lines 313-336 for 625 line video
  				  standards, 263-286 for 525 line standards)  }
  { must be zero  }

  type
     Pv4l2_sliced_vbi_format = ^v4l2_sliced_vbi_format;
     v4l2_sliced_vbi_format = record
          service_set : __u16;
          service_lines : array[0..1] of array[0..23] of __u16;
          io_size : __u32;
          reserved : array[0..1] of __u32;
       end;

  { Teletext World System Teletext
     (WST), defined on ITU-R BT.653-2  }

  const
     V4L2_SLICED_TELETEXT_B = $0001;
  { Video Program System, defined on ETS 300 231 }
     V4L2_SLICED_VPS = $0400;
  { Closed Caption, defined on EIA-608  }
     V4L2_SLICED_CAPTION_525 = $1000;
  { Wide Screen System, defined on ITU-R BT1119.1  }
     V4L2_SLICED_WSS_625 = $4000;
     V4L2_SLICED_VBI_525 = V4L2_SLICED_CAPTION_525;
     V4L2_SLICED_VBI_625 = (V4L2_SLICED_TELETEXT_B or V4L2_SLICED_VPS) or V4L2_SLICED_WSS_625;
  { service_lines[0][...] specifies lines 0-23 (1-23 used) of the first field
  	   service_lines[1][...] specifies lines 0-23 (1-23 used) of the second field
  				 (equals frame lines 313-336 for 625 line video
  				  standards, 263-286 for 525 line standards)  }
  { must be 0  }

  type
     Pv4l2_sliced_vbi_cap = ^v4l2_sliced_vbi_cap;
     v4l2_sliced_vbi_cap = record
          service_set : __u16;
          service_lines : array[0..1] of array[0..23] of __u16;
          _type : v4l2_buf_type;
          reserved : array[0..2] of __u32;
       end;

  { 0: first field, 1: second field  }
  { 1-23  }
  { must be 0  }
     Pv4l2_sliced_vbi_data = ^v4l2_sliced_vbi_data;
     v4l2_sliced_vbi_data = record
          id : __u32;
          field : __u32;
          line : __u32;
          reserved : __u32;
          data : array[0..47] of __u8;
       end;

  {
   *	A G G R E G A T E   S T R U C T U R E S
    }
  {	Stream data format
    }
  { V4L2_BUF_TYPE_VIDEO_CAPTURE  }
  { V4L2_BUF_TYPE_VIDEO_OVERLAY  }
  { V4L2_BUF_TYPE_VBI_CAPTURE  }
  { V4L2_BUF_TYPE_SLICED_VBI_CAPTURE  }
  { user-defined  }
     Pv4l2_format = ^v4l2_format;
     v4l2_format = record
          _type : v4l2_buf_type;
          fmt : record
              case longint of
                 0 : ( pix : v4l2_pix_format );
                 1 : ( win : v4l2_window );
                 2 : ( vbi : v4l2_vbi_format );
                 3 : ( sliced : v4l2_sliced_vbi_format );
                 4 : ( raw_data : array[0..199] of __u8 );
              end;
       end;

  {	Stream type-dependent parameters
    }
  { user-defined  }
     Pv4l2_streamparm = ^v4l2_streamparm;
     v4l2_streamparm = record
          _type : v4l2_buf_type;
          parm : record
              case longint of
                 0 : ( capture : v4l2_captureparm );
                 1 : ( output : v4l2_outputparm );
                 2 : ( raw_data : array[0..199] of __u8 );
              end;
       end;

  {
   *	A D V A N C E D   D E B U G G I N G
   *
   *	NOTE: EXPERIMENTAL API, NEVER RELY ON THIS IN APPLICATIONS!
   *	FOR DEBUGGING, TESTING AND INTERNAL USE ONLY!
    }
  { VIDIOC_DBG_G_REGISTER and VIDIOC_DBG_S_REGISTER  }

  const
     V4L2_CHIP_MATCH_HOST = 0;
  { Match against chip ID on host (0 for the host)  }
     V4L2_CHIP_MATCH_I2C_DRIVER = 1;
  { Match against I2C driver name  }
     V4L2_CHIP_MATCH_I2C_ADDR = 2;
  { Match against I2C 7-bit address  }
     V4L2_CHIP_MATCH_AC97 = 3;
  { Match against anciliary AC97 chip  }
  { Match type  }
  { 	union      /* Match this chip, meaning determined by type */ }
  { 		__u32 addr; }
  { 	; }
  {  __attribute__ ((packed)); }

  type
     Pv4l2_dbg_match = ^v4l2_dbg_match;
     v4l2_dbg_match = record
          _type : __u32;
          name : array[0..31] of char;
       end;

  { register size in bytes  }
  { __attribute__ ((packed)); }
     Pv4l2_dbg_register = ^v4l2_dbg_register;
     v4l2_dbg_register = record
          match : v4l2_dbg_match;
          size : __u32;
          reg : __u64;
          val : __u64;
       end;

  { VIDIOC_DBG_G_CHIP_IDENT  }
  { chip identifier as specified in <media/v4l2-chip-ident.h>  }
  { chip revision, chip specific  }
  { __attribute__ ((packed)); }
     Pv4l2_dbg_chip_ident = ^v4l2_dbg_chip_ident;
     v4l2_dbg_chip_ident = record
          match : v4l2_dbg_match;
          ident : __u32;
          revision : __u32;
       end;

  { VIDIOC_G_CHIP_IDENT_OLD: Deprecated, do not use  }
  { Match type  }
  { Match this chip, meaning determined by match_type  }
  { chip identifier as specified in <media/v4l2-chip-ident.h>  }
  { chip revision, chip specific  }
     Pv4l2_chip_ident_old = ^v4l2_chip_ident_old;
     v4l2_chip_ident_old = record
          match_type : __u32;
          match_chip : __u32;
          ident : __u32;
          revision : __u32;
       end;

  {
   *	I O C T L   C O D E S   F O R   V I D E O   D E V I C E S
   *
    }
  {struct v4l2_capability }
  { was #define dname def_expr }
  function VIDIOC_QUERYCAP : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_RESERVED : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_ENUM_FMT : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_FMT : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_FMT : longint;
      { return type might be wrong }

  (*{ was #define dname def_expr }
  function VIDIOC_G_MPEGCOMP : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_MPEGCOMP : longint;
      { return type might be wrong }*)

  { was #define dname def_expr }
  function VIDIOC_REQBUFS : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_QUERYBUF : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_FBUF : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_FBUF : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_OVERLAY : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_QBUF : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_DQBUF : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_STREAMON : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_STREAMOFF : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_PARM : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_PARM : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_STD : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_STD : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_ENUMSTD : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_ENUMINPUT : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_CTRL : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_CTRL : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_TUNER : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_TUNER : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_AUDIO : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_AUDIO : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_QUERYCTRL : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_QUERYMENU : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_INPUT : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_INPUT : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_OUTPUT : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_OUTPUT : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_ENUMOUTPUT : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_AUDOUT : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_AUDOUT : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_MODULATOR : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_MODULATOR : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_FREQUENCY : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_FREQUENCY : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_CROPCAP : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_CROP : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_CROP : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_JPEGCOMP : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_JPEGCOMP : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_QUERYSTD : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_TRY_FMT : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_ENUMAUDIO : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_ENUMAUDOUT : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_PRIORITY : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_PRIORITY : longint;
      { return type might be wrong }




  { was #define dname def_expr }
  function VIDIOC_G_SLICED_VBI_CAP : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_LOG_STATUS : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_EXT_CTRLS : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_EXT_CTRLS : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_TRY_EXT_CTRLS : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_ENUM_FRAMESIZES : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_ENUM_FRAMEINTERVALS : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_ENC_INDEX : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_ENCODER_CMD : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_TRY_ENCODER_CMD : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_HW_FREQ_SEEK : longint;
      { return type might be wrong }

  { for compatibility, will go away some day  }
  { was #define dname def_expr }
  function VIDIOC_OVERLAY_OLD : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_PARM_OLD : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_S_CTRL_OLD : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_AUDIO_OLD : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_G_AUDOUT_OLD : longint;
      { return type might be wrong }

  { was #define dname def_expr }
  function VIDIOC_CROPCAP_OLD : longint;
      { return type might be wrong }

  { #define VIDIOC_G_SLICED_VBI_CAP _IOWR('V', 69, struct v4l2_sliced_vbi_cap) }
  { #define VIDIOC_LOG_STATUS         _IO('V', 70) }
  { #define VIDIOC_G_EXT_CTRLS	_IOWR('V', 71, struct v4l2_ext_controls) }
  { #define VIDIOC_S_EXT_CTRLS	_IOWR('V', 72, struct v4l2_ext_controls) }
  { #define VIDIOC_TRY_EXT_CTRLS	_IOWR('V', 73, struct v4l2_ext_controls) }
  { #define VIDIOC_ENUM_FRAMESIZES	_IOWR('V', 74, struct v4l2_frmsizeenum) }
  { #define VIDIOC_ENUM_FRAMEINTERVALS _IOWR('V', 75, struct v4l2_frmivalenum) }
  { #define VIDIOC_G_ENC_INDEX       _IOR('V', 76, struct v4l2_enc_idx) }
  { #define VIDIOC_ENCODER_CMD      _IOWR('V', 77, struct v4l2_encoder_cmd) }
  { #define VIDIOC_TRY_ENCODER_CMD  _IOWR('V', 78, struct v4l2_encoder_cmd) }
  { #define VIDIOC_S_HW_FREQ_SEEK	 _IOW('V', 82, struct v4l2_hw_freq_seek) }

  const
     BASE_VIDIOC_PRIVATE = 192;
  { 192-255 are private  }
{$endif}
  { __LINUX_VIDEODEV2_H  }

implementation

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOC(dir,_type,nr,size : longint) : longint;
    begin
       _IOC:=(((dir shl _IOC_DIRSHIFT) or (_type shl _IOC_TYPESHIFT)) or (nr shl _IOC_NRSHIFT)) or (size shl _IOC_SIZESHIFT);
    end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IO(_type,nr : longint) : longint;
    begin
       _IO:=_IOC(_IOC_NONE,_type,nr,0);
    end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOR(_type,nr,size : longint) : longint;
    begin
       _IOR:=_IOC(_IOC_READ,_type,nr,size);
    end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOW(_type,nr,size : longint) : longint;
    begin
       _IOW:=_IOC(_IOC_WRITE,_type,nr,size);
    end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOWR(_type,nr,size : longint) : longint;
    begin
       _IOWR:=_IOC(_IOC_READ or _IOC_WRITE,_type,nr,size);
    end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOC_DIR(nr : longint) : longint;
    begin
       _IOC_DIR:=(nr shr _IOC_DIRSHIFT) and _IOC_DIRMASK;
    end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOC_TYPE(nr : longint) : longint;
    begin
       _IOC_TYPE:=(nr shr _IOC_TYPESHIFT) and _IOC_TYPEMASK;
    end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOC_NR(nr : longint) : longint;
    begin
       _IOC_NR:=(nr shr _IOC_NRSHIFT) and _IOC_NRMASK;
    end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function _IOC_SIZE(nr : longint) : longint;
    begin
       _IOC_SIZE:=(nr shr _IOC_SIZESHIFT) and _IOC_SIZEMASK;
    end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  function v4l2_fourcc(a,b,c,d : char) : longint;
    begin
       v4l2_fourcc:=(((integer(ord(a)) shl 0) or (integer(ord(b)) shl 8)) or (integer(ord(c)) shl 16)) or (integer(ord(d)) shl 24);
    end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB332 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_RGB332:=v4l2_fourcc('R','G','B','1');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB444 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_RGB444:=v4l2_fourcc('R','4','4','4');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB555 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_RGB555:=v4l2_fourcc('R','G','B','O');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB565 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_RGB565:=v4l2_fourcc('R','G','B','P');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB555X : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_RGB555X:=v4l2_fourcc('R','G','B','Q');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB565X : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_RGB565X:=v4l2_fourcc('R','G','B','R');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_BGR24 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_BGR24:=v4l2_fourcc('B','G','R','3');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB24 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_RGB24:=v4l2_fourcc('R','G','B','3');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_BGR32 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_BGR32:=v4l2_fourcc('B','G','R','4');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_RGB32 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_RGB32:=v4l2_fourcc('R','G','B','4');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_GREY : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_GREY:=v4l2_fourcc('G','R','E','Y');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_Y16 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_Y16:=v4l2_fourcc('Y','1','6',' ');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_PAL8 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_PAL8:=v4l2_fourcc('P','A','L','8');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YVU410 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YVU410:=v4l2_fourcc('Y','V','U','9');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YVU420 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YVU420:=v4l2_fourcc('Y','V','1','2');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUYV : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YUYV:=v4l2_fourcc('Y','U','Y','V');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_UYVY : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_UYVY:=v4l2_fourcc('U','Y','V','Y');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_VYUY : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_VYUY:=v4l2_fourcc('V','Y','U','Y');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV422P : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YUV422P:=v4l2_fourcc('4','2','2','P');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV411P : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YUV411P:=v4l2_fourcc('4','1','1','P');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_Y41P : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_Y41P:=v4l2_fourcc('Y','4','1','P');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV444 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YUV444:=v4l2_fourcc('Y','4','4','4');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV555 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YUV555:=v4l2_fourcc('Y','U','V','O');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV565 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YUV565:=v4l2_fourcc('Y','U','V','P');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV32 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YUV32:=v4l2_fourcc('Y','U','V','4');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_NV12 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_NV12:=v4l2_fourcc('N','V','1','2');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_NV21 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_NV21:=v4l2_fourcc('N','V','2','1');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_NV16 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_NV16:=v4l2_fourcc('N','V','1','6');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_NV61 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_NV61:=v4l2_fourcc('N','V','6','1');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV410 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YUV410:=v4l2_fourcc('Y','U','V','9');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YUV420 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YUV420:=v4l2_fourcc('Y','U','1','2');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YYUV : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YYUV:=v4l2_fourcc('Y','Y','U','V');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_HI240 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_HI240:=v4l2_fourcc('H','I','2','4');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_HM12 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_HM12:=v4l2_fourcc('H','M','1','2');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_SBGGR8 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_SBGGR8:=v4l2_fourcc('B','A','8','1');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_SGBRG8 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_SGBRG8:=v4l2_fourcc('G','B','R','G');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_SGRBG10 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_SGRBG10:=v4l2_fourcc('B','A','1','0');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_SGRBG10DPCM8 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_SGRBG10DPCM8:=v4l2_fourcc('B','D','1','0');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_SBGGR16 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_SBGGR16:=v4l2_fourcc('B','Y','R','2');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_MJPEG : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_MJPEG:=v4l2_fourcc('M','J','P','G');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_JPEG : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_JPEG:=v4l2_fourcc('J','P','E','G');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_DV : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_DV:=v4l2_fourcc('d','v','s','d');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_MPEG : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_MPEG:=v4l2_fourcc('M','P','E','G');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_WNVA : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_WNVA:=v4l2_fourcc('W','N','V','A');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_SN9C10X : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_SN9C10X:=v4l2_fourcc('S','9','1','0');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_PWC1 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_PWC1:=v4l2_fourcc('P','W','C','1');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_PWC2 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_PWC2:=v4l2_fourcc('P','W','C','2');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_ET61X251 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_ET61X251:=v4l2_fourcc('E','6','2','5');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_SPCA501 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_SPCA501:=v4l2_fourcc('S','5','0','1');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_SPCA505 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_SPCA505:=v4l2_fourcc('S','5','0','5');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_SPCA508 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_SPCA508:=v4l2_fourcc('S','5','0','8');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_SPCA561 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_SPCA561:=v4l2_fourcc('S','5','6','1');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_PAC207 : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_PAC207:=v4l2_fourcc('P','2','0','7');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_MR97310A : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_MR97310A:=v4l2_fourcc('M','3','1','0');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_PJPG : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_PJPG:=v4l2_fourcc('P','J','P','G');
      end;

  { was #define dname def_expr }
  function V4L2_PIX_FMT_YVYU : longint;
      { return type might be wrong }
      begin
         V4L2_PIX_FMT_YVYU:=v4l2_fourcc('Y','V','Y','U');
      end;

  { was #define dname def_expr }
  function V4L2_STD_PAL_B : v4l2_std_id;
      begin
         V4L2_STD_PAL_B:=v4l2_std_id($00000001);
      end;

  { was #define dname def_expr }
  function V4L2_STD_PAL_B1 : v4l2_std_id;
      begin
         V4L2_STD_PAL_B1:=v4l2_std_id($00000002);
      end;

  { was #define dname def_expr }
  function V4L2_STD_PAL_G : v4l2_std_id;
      begin
         V4L2_STD_PAL_G:=v4l2_std_id($00000004);
      end;

  { was #define dname def_expr }
  function V4L2_STD_PAL_H : v4l2_std_id;
      begin
         V4L2_STD_PAL_H:=v4l2_std_id($00000008);
      end;

  { was #define dname def_expr }
  function V4L2_STD_PAL_I : v4l2_std_id;
      begin
         V4L2_STD_PAL_I:=v4l2_std_id($00000010);
      end;

  { was #define dname def_expr }
  function V4L2_STD_PAL_D : v4l2_std_id;
      begin
         V4L2_STD_PAL_D:=v4l2_std_id($00000020);
      end;

  { was #define dname def_expr }
  function V4L2_STD_PAL_D1 : v4l2_std_id;
      begin
         V4L2_STD_PAL_D1:=v4l2_std_id($00000040);
      end;

  { was #define dname def_expr }
  function V4L2_STD_PAL_K : v4l2_std_id;
      begin
         V4L2_STD_PAL_K:=v4l2_std_id($00000080);
      end;

  { was #define dname def_expr }
  function V4L2_STD_PAL_M : v4l2_std_id;
      begin
         V4L2_STD_PAL_M:=v4l2_std_id($00000100);
      end;

  { was #define dname def_expr }
  function V4L2_STD_PAL_N : v4l2_std_id;
      begin
         V4L2_STD_PAL_N:=v4l2_std_id($00000200);
      end;

  { was #define dname def_expr }
  function V4L2_STD_PAL_Nc : v4l2_std_id;
      begin
         V4L2_STD_PAL_Nc:=v4l2_std_id($00000400);
      end;

  { was #define dname def_expr }
  function V4L2_STD_PAL_60 : v4l2_std_id;
      begin
         V4L2_STD_PAL_60:=v4l2_std_id($00000800);
      end;

  { was #define dname def_expr }
  function V4L2_STD_NTSC_M : v4l2_std_id;
      begin
         V4L2_STD_NTSC_M:=v4l2_std_id($00001000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_NTSC_M_JP : v4l2_std_id;
      begin
         V4L2_STD_NTSC_M_JP:=v4l2_std_id($00002000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_NTSC_443 : v4l2_std_id;
      begin
         V4L2_STD_NTSC_443:=v4l2_std_id($00004000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_NTSC_M_KR : v4l2_std_id;
      begin
         V4L2_STD_NTSC_M_KR:=v4l2_std_id($00008000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_B : v4l2_std_id;
      begin
         V4L2_STD_SECAM_B:=v4l2_std_id($00010000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_D : v4l2_std_id;
      begin
         V4L2_STD_SECAM_D:=v4l2_std_id($00020000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_G : v4l2_std_id;
      begin
         V4L2_STD_SECAM_G:=v4l2_std_id($00040000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_H : v4l2_std_id;
      begin
         V4L2_STD_SECAM_H:=v4l2_std_id($00080000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_K : v4l2_std_id;
      begin
         V4L2_STD_SECAM_K:=v4l2_std_id($00100000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_K1 : v4l2_std_id;
      begin
         V4L2_STD_SECAM_K1:=v4l2_std_id($00200000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_L : v4l2_std_id;
      begin
         V4L2_STD_SECAM_L:=v4l2_std_id($00400000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_SECAM_LC : v4l2_std_id;
      begin
         V4L2_STD_SECAM_LC:=v4l2_std_id($00800000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_ATSC_8_VSB : v4l2_std_id;
      begin
         V4L2_STD_ATSC_8_VSB:=v4l2_std_id($01000000);
      end;

  { was #define dname def_expr }
  function V4L2_STD_ATSC_16_VSB : v4l2_std_id;
      begin
         V4L2_STD_ATSC_16_VSB:=v4l2_std_id($02000000);
      end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  {function V4L2_CTRL_ID2CLASS(id : longint) : id;
    begin
       V4L2_CTRL_ID2CLASS:=id(@($0fff0000));
    end;}

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }
  {function V4L2_CTRL_DRIVER_PRIV(id : longint) : longint;
    begin
       V4L2_CTRL_DRIVER_PRIV:=(id(@($ffff)))>=$1000;
    end;}

  { was #define dname def_expr }
  function VIDIOC_QUERYCAP : longint;
      { return type might be wrong }
      begin
         VIDIOC_QUERYCAP:=_IOR(ord('V'),0,sizeof(v4l2_capability));
      end;

  { was #define dname def_expr }
  function VIDIOC_RESERVED : longint;
      { return type might be wrong }
      begin
         VIDIOC_RESERVED:=_IO(ord('V'),1);
      end;

  { was #define dname def_expr }
  function VIDIOC_ENUM_FMT : longint;
      { return type might be wrong }
      begin
         VIDIOC_ENUM_FMT:=_IOWR(ord('V'),2,sizeof(v4l2_fmtdesc));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_FMT : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_FMT:=_IOWR(ord('V'),4,sizeof(v4l2_format));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_FMT : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_FMT:=_IOWR(ord('V'),5,sizeof(v4l2_format));
      end;

  (*{ was #define dname def_expr }
  function VIDIOC_G_MPEGCOMP : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_MPEGCOMP:=_IOR(ord('V'),6,sizeof(v4l2_mpeg_compression));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_MPEGCOMP : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_MPEGCOMP:=_IOW(ord('V'),7,sizeof(v4l2_mpeg_compression));
      end;*)

  { was #define dname def_expr }
  function VIDIOC_REQBUFS : longint;
      { return type might be wrong }
      begin
         VIDIOC_REQBUFS:=_IOWR(ord('V'),8,sizeof(v4l2_requestbuffers));
      end;

  { was #define dname def_expr }
  function VIDIOC_QUERYBUF : longint;
      { return type might be wrong }
      begin
         VIDIOC_QUERYBUF:=_IOWR(ord('V'),9,sizeof(v4l2_buffer));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_FBUF : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_FBUF:=_IOR(ord('V'),10,sizeof(v4l2_framebuffer));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_FBUF : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_FBUF:=_IOW(ord('V'),11,sizeof(v4l2_framebuffer));
      end;

  { was #define dname def_expr }
  function VIDIOC_OVERLAY : longint;
      { return type might be wrong }
      begin
         VIDIOC_OVERLAY:=_IOW(ord('V'),14,sizeof(longint));
      end;

  { was #define dname def_expr }
  function VIDIOC_QBUF : longint;
      { return type might be wrong }
      begin
         VIDIOC_QBUF:=_IOWR(ord('V'),15,sizeof(v4l2_buffer));
      end;

  { was #define dname def_expr }
  function VIDIOC_DQBUF : longint;
      { return type might be wrong }
      begin
         VIDIOC_DQBUF:=_IOWR(ord('V'),17,sizeof(v4l2_buffer));
      end;

  { was #define dname def_expr }
  function VIDIOC_STREAMON : longint;
      { return type might be wrong }
      begin
         VIDIOC_STREAMON:=_IOW(ord('V'),18,sizeof(longint));
      end;

  { was #define dname def_expr }
  function VIDIOC_STREAMOFF : longint;
      { return type might be wrong }
      begin
         VIDIOC_STREAMOFF:=_IOW(ord('V'),19,sizeof(longint));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_PARM : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_PARM:=_IOWR(ord('V'),21,sizeof(v4l2_streamparm));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_PARM : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_PARM:=_IOWR(ord('V'),22,sizeof(v4l2_streamparm));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_STD : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_STD:=_IOR(ord('V'),23,sizeof(v4l2_std_id));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_STD : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_STD:=_IOW(ord('V'),24,sizeof(v4l2_std_id));
      end;

  { was #define dname def_expr }
  function VIDIOC_ENUMSTD : longint;
      { return type might be wrong }
      begin
         VIDIOC_ENUMSTD:=_IOWR(ord('V'),25,sizeof(v4l2_standard));
      end;

  { was #define dname def_expr }
  function VIDIOC_ENUMINPUT : longint;
      { return type might be wrong }
      begin
         VIDIOC_ENUMINPUT:=_IOWR(ord('V'),26,sizeof(v4l2_input));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_CTRL : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_CTRL:=_IOWR(ord('V'),27,sizeof(v4l2_control));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_CTRL : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_CTRL:=_IOWR(ord('V'),28,sizeof(v4l2_control));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_TUNER : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_TUNER:=_IOWR(ord('V'),29,sizeof(v4l2_tuner));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_TUNER : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_TUNER:=_IOW(ord('V'),30,sizeof(v4l2_tuner));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_AUDIO : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_AUDIO:=_IOR(ord('V'),33,sizeof(v4l2_audio));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_AUDIO : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_AUDIO:=_IOW(ord('V'),34,sizeof(v4l2_audio));
      end;

  { was #define dname def_expr }
  function VIDIOC_QUERYCTRL : longint;
      { return type might be wrong }
      begin
         VIDIOC_QUERYCTRL:=_IOWR(ord('V'),36,sizeof(v4l2_queryctrl));
      end;

  { was #define dname def_expr }
  function VIDIOC_QUERYMENU : longint;
      { return type might be wrong }
      begin
         VIDIOC_QUERYMENU:=_IOWR(ord('V'),37,sizeof(v4l2_querymenu));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_INPUT : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_INPUT:=_IOR(ord('V'),38,sizeof(longint));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_INPUT : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_INPUT:=_IOWR(ord('V'),39,sizeof(longint));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_OUTPUT : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_OUTPUT:=_IOR(ord('V'),46,sizeof(longint));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_OUTPUT : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_OUTPUT:=_IOWR(ord('V'),47,sizeof(longint));
      end;

  { was #define dname def_expr }
  function VIDIOC_ENUMOUTPUT : longint;
      { return type might be wrong }
      begin
         VIDIOC_ENUMOUTPUT:=_IOWR(ord('V'),48,sizeof(v4l2_output));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_AUDOUT : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_AUDOUT:=_IOR(ord('V'),49,sizeof(v4l2_audioout));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_AUDOUT : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_AUDOUT:=_IOW(ord('V'),50,sizeof(v4l2_audioout));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_MODULATOR : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_MODULATOR:=_IOWR(ord('V'),54,sizeof(v4l2_modulator));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_MODULATOR : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_MODULATOR:=_IOW(ord('V'),55,sizeof(v4l2_modulator));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_FREQUENCY : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_FREQUENCY:=_IOWR(ord('V'),56,sizeof(v4l2_frequency));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_FREQUENCY : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_FREQUENCY:=_IOW(ord('V'),57,sizeof(v4l2_frequency));
      end;

  { was #define dname def_expr }
  function VIDIOC_CROPCAP : longint;
      { return type might be wrong }
      begin
         VIDIOC_CROPCAP:=_IOWR(ord('V'),58,sizeof(v4l2_cropcap));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_CROP : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_CROP:=_IOWR(ord('V'),59,sizeof(v4l2_crop));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_CROP : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_CROP:=_IOW(ord('V'),60,sizeof(v4l2_crop));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_JPEGCOMP : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_JPEGCOMP:=_IOR(ord('V'),61,sizeof(v4l2_jpegcompression));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_JPEGCOMP : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_JPEGCOMP:=_IOW(ord('V'),62,sizeof(v4l2_jpegcompression));
      end;

  { was #define dname def_expr }
  function VIDIOC_QUERYSTD : longint;
      { return type might be wrong }
      begin
         VIDIOC_QUERYSTD:=_IOR(ord('V'),63,sizeof(v4l2_std_id));
      end;

  { was #define dname def_expr }
  function VIDIOC_TRY_FMT : longint;
      { return type might be wrong }
      begin
         VIDIOC_TRY_FMT:=_IOWR(ord('V'),64,sizeof(v4l2_format));
      end;

  { was #define dname def_expr }
  function VIDIOC_ENUMAUDIO : longint;
      { return type might be wrong }
      begin
         VIDIOC_ENUMAUDIO:=_IOWR(ord('V'),65,sizeof(v4l2_audio));
      end;

  { was #define dname def_expr }
  function VIDIOC_ENUMAUDOUT : longint;
      { return type might be wrong }
      begin
         VIDIOC_ENUMAUDOUT:=_IOWR(ord('V'),66,sizeof(v4l2_audioout));
      end;


  { was #define dname def_expr }
  function VIDIOC_G_SLICED_VBI_CAP : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_SLICED_VBI_CAP:=_IOWR(ord('V'),69,sizeof(v4l2_sliced_vbi_cap));
      end;
  { #define VIDIOC_G_SLICED_VBI_CAP _IOWR('V', 69, struct v4l2_sliced_vbi_cap) }
  { #define VIDIOC_LOG_STATUS         _IO('V', 70) }
  { #define VIDIOC_G_EXT_CTRLS	_IOWR('V', 71, struct v4l2_ext_controls) }
  { was #define dname def_expr }
  function VIDIOC_LOG_STATUS : longint;
      { return type might be wrong }
      begin
         VIDIOC_LOG_STATUS:=_IO(ord('V'),70);
      end;

  { was #define dname def_expr }
  function VIDIOC_G_EXT_CTRLS : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_EXT_CTRLS:=_IOW(ord('V'),71,sizeof(v4l2_ext_controls));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_EXT_CTRLS : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_EXT_CTRLS:=_IOWR(ord('V'),72,sizeof(v4l2_ext_controls));
      end;
  { #define VIDIOC_S_EXT_CTRLS	_IOWR('V', 72, struct v4l2_ext_controls) }
  { #define VIDIOC_TRY_EXT_CTRLS	_IOWR('V', 73, struct v4l2_ext_controls) }
  { #define VIDIOC_ENUM_FRAMESIZES	_IOWR('V', 74, struct v4l2_frmsizeenum) }
  { was #define dname def_expr }
  function VIDIOC_TRY_EXT_CTRLS : longint;
      { return type might be wrong }
      begin
         VIDIOC_TRY_EXT_CTRLS:=_IOWR(ord('V'),73,sizeof(v4l2_ext_controls));
      end;

  { was #define dname def_expr }
  function VIDIOC_ENUM_FRAMESIZES : longint;
      { return type might be wrong }
      begin
         VIDIOC_ENUM_FRAMESIZES:=_IOWR(ord('V'),74,sizeof(v4l2_frmsizeenum));
      end;

  { was #define dname def_expr }
  function VIDIOC_ENUM_FRAMEINTERVALS : longint;
      { return type might be wrong }
      begin
         VIDIOC_ENUM_FRAMEINTERVALS:=_IOW(ord('V'),75,sizeof(v4l2_frmivalenum));
      end;
  { #define VIDIOC_ENUM_FRAMEINTERVALS _IOWR('V', 75, struct v4l2_frmivalenum) }
  { #define VIDIOC_G_ENC_INDEX       _IOR('V', 76, struct v4l2_enc_idx) }
  { #define VIDIOC_ENCODER_CMD      _IOWR('V', 77, struct v4l2_encoder_cmd) }
  { was #define dname def_expr }
  function VIDIOC_G_ENC_INDEX : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_ENC_INDEX:=_IOR(ord('V'),76,sizeof(v4l2_enc_idx));
      end;

  { was #define dname def_expr }
  function VIDIOC_ENCODER_CMD : longint;
      { return type might be wrong }
      begin
         VIDIOC_ENCODER_CMD:=_IOW(ord('V'),77,sizeof(v4l2_encoder_cmd));
      end;

  { was #define dname def_expr }
  function VIDIOC_TRY_ENCODER_CMD : longint;
      { return type might be wrong }
      begin
         VIDIOC_TRY_ENCODER_CMD:=_IOW(ord('V'),78,sizeof(v4l2_encoder_cmd));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_HW_FREQ_SEEK : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_HW_FREQ_SEEK:=_IOW(ord('V'),82,sizeof(v4l2_hw_freq_seek));
      end;
  { #define VIDIOC_G_SLICED_VBI_CAP _IOWR('V', 69, struct v4l2_sliced_vbi_cap) }
  { #define VIDIOC_LOG_STATUS         _IO('V', 70) }
  { #define VIDIOC_G_EXT_CTRLS	_IOWR('V', 71, struct v4l2_ext_controls) }
  { #define VIDIOC_S_EXT_CTRLS	_IOWR('V', 72, struct v4l2_ext_controls) }
  { #define VIDIOC_TRY_EXT_CTRLS	_IOWR('V', 73, struct v4l2_ext_controls) }
  { #define VIDIOC_ENUM_FRAMESIZES	_IOWR('V', 74, struct v4l2_frmsizeenum) }
  { #define VIDIOC_ENUM_FRAMEINTERVALS _IOWR('V', 75, struct v4l2_frmivalenum) }
  { #define VIDIOC_G_ENC_INDEX       _IOR('V', 76, struct v4l2_enc_idx) }
  { #define VIDIOC_ENCODER_CMD      _IOWR('V', 77, struct v4l2_encoder_cmd) }
  { #define VIDIOC_TRY_ENCODER_CMD  _IOWR('V', 78, struct v4l2_encoder_cmd) }

  { was #define dname def_expr }
  function VIDIOC_G_PRIORITY : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_PRIORITY:=_IOR(ord('V'),67,sizeof(v4l2_priority));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_PRIORITY : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_PRIORITY:=_IOW(ord('V'),68,sizeof(v4l2_priority));
      end;

  { was #define dname def_expr }
  function VIDIOC_OVERLAY_OLD : longint;
      { return type might be wrong }
      begin
         VIDIOC_OVERLAY_OLD:=_IOWR(ord('V'),14,sizeof(longint));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_PARM_OLD : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_PARM_OLD:=_IOW(ord('V'),22,sizeof(v4l2_streamparm));
      end;

  { was #define dname def_expr }
  function VIDIOC_S_CTRL_OLD : longint;
      { return type might be wrong }
      begin
         VIDIOC_S_CTRL_OLD:=_IOW(ord('V'),28,sizeof(v4l2_control));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_AUDIO_OLD : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_AUDIO_OLD:=_IOWR(ord('V'),33,sizeof(v4l2_audio));
      end;

  { was #define dname def_expr }
  function VIDIOC_G_AUDOUT_OLD : longint;
      { return type might be wrong }
      begin
         VIDIOC_G_AUDOUT_OLD:=_IOWR(ord('V'),49,sizeof(v4l2_audioout));
      end;

  { was #define dname def_expr }
  function VIDIOC_CROPCAP_OLD : longint;
      { return type might be wrong }
      begin
         VIDIOC_CROPCAP_OLD:=_IOR(ord('V'),58,sizeof(v4l2_cropcap));
      end;



end.
