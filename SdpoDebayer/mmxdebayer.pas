{ mmxdebayer v1

  CopyRight (C) 2012 Paulo Marques, Paulo Costa

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
unit mmxdebayer;

interface

  const
    External_library='mmxdebayer';

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{$ifndef MMXDEBAYER_H}
{$define MMXDEBAYER_H}  

procedure debayer32(src:pbyte; dest:pbyte; width:longint; height:longint; offset:longint);cdecl;external External_library name 'debayer32';
procedure debayer32_gbrg(src:pbyte; dest:pbyte; width:longint; height:longint; offset:longint);cdecl;external External_library name 'debayer32_gbrg';

procedure debayer16(src:pbyte; dest:pbyte; width:longint; height:longint; offset:longint);cdecl;external External_library name 'debayer16';
procedure debayer16_gbrg(src:pbyte; dest:pbyte; width:longint; height:longint; offset:longint);cdecl;external External_library name 'debayer16_gbrg';

procedure rgb16to32(src:pbyte; dest:pbyte; width:longint; height:longint; offset:longint);cdecl;external External_library name 'rgb16to32';

procedure yuv_rgb16(src:pbyte; dest:pbyte; width:longint; height:longint; offset:longint);cdecl;external External_library name 'yuv_rgb16';
procedure yuv_rgb32(src:pbyte; dest:pbyte; width:longint; height:longint; offset:longint);cdecl;external External_library name 'yuv_rgb32';

procedure debayer32_lum(src:pbyte; dest:pbyte; dest_lum:pbyte; width:longint; height:longint; offset:longint);cdecl;external External_library name 'debayer32_lum';

{$endif}

implementation


end.
