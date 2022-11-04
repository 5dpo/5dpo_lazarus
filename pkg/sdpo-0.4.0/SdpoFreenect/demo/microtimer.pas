{ microtimer v1

  CopyRight (C) 2012 Paulo Costa

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
unit microtimer;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils; 

function getMiliTime: int64;
function getMicroTime: int64;

var
  PerformanceFrequency: int64;

implementation

{$IFDEF MSWINDOWS}
uses windows;
{$ELSE}
uses unix;
{$ENDIF}


function getMicroTime: int64;
{$IFDEF MSWINDOWS}
var tv: int64;
begin
  queryPerformanceCounter(tv);
  result := tv div PerformanceFrequency;
end;
{$ELSE}
var tv: ttimeval;
begin
  fpgettimeofday(@tv, nil);
  result := int64(tv.tv_sec) * 1000000 + tv.tv_usec;
end;
{$ENDIF}

function getMiliTime: int64;
begin
  result := getMicroTime() div 1000;
end;


initialization

{$IFDEF MSWINDOWS}
  QueryPerformanceFrequency(PerformanceFrequency);
  PerformanceFrequency := PerformanceFrequency div 1000000;
{$ENDIF}


end.
