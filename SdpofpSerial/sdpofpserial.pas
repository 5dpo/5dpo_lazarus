{ SdpofpSerial v1

  CopyRight (C) 2019 Paulo Costa

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

unit sdpofpserial;

{$mode objfpc}{$H+}

interface

uses
{$IFDEF LINUX}
  Classes,
{$IFDEF UseCThreads}
  cthreads,
{$ENDIF}
{$ELSE}
  Classes,
{$ENDIF}
  serial, sysutils, LResources, Forms, Controls, Graphics, Dialogs;

const
  BAD_SERIAL_HANDLE = 0;


type
  TBaudRate=(br___300, br___600, br__1200, br__2400, br__4800, br__9600, br_19200,
             br_38400, br_57600, br115200, br230400, br460800, br921600);
  TDataBits=(db8bits,db7bits,db6bits,db5bits);
  TFlowControl=(fcNone,fcXonXoff,fcHardware);
  TStopBits=(sbOne,sbTwo);

  TModemSignal = (msRI,msCD,msCTS,msDSR);
  TModemSignals = Set of TModemSignal;

const
  ConstsBaud: array[TBaudRate] of integer = (
    300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200,
    230400, 460800, 921600);

  ConstsBits: array[TDataBits] of integer = (8, 7 , 6, 5);
  ConstsStopBits: array[TStopBits] of integer = (1, 2);


type
  TSdpofpSerial = class;

  TSdpofpSerialReadThread = class(TThread)
  public
    MustDie: boolean;
    Owner: TSdpofpSerial;

    //buffer: array[0..2048 - 1] of byte;
    //count: LongInt;

  protected
    procedure CallEvent;
    procedure Execute; override;
  published
    property Terminated;
  end;

  { TSdpofpSerial }

  TSdpofpSerial = class(TComponent)
  private
    FActive: boolean;
    FSerialHandle: TSerialHandle;
    FDevice: string;

    FBaudRate: TBaudRate;
    FDataBits: TDataBits;
    FParity: TParityType;
    FStopBits: TStopBits;
    
    FFlowFlags: TSerialFlags;

    FOnRxData: TNotifyEvent;
    ReadThread: TSdpofpSerialReadThread;

    FAltBaudRate: integer;

    buffer: array[0..2048 - 1] of byte;
    count: LongInt;

    procedure DeviceOpen;
    procedure DeviceClose;

    procedure ComException(str: string);
    function BaudRateValue: integer;

  protected
    procedure SetActive(state: boolean);
    procedure SetBaudRate(br: TBaudRate);
    procedure SetAltBaudRate(altbr: integer);
    procedure SetDataBits(db: TDataBits);
    procedure SetParity(pr: TParityType);
    procedure SetFlowControl(fc: TSerialFlags);
    procedure SetStopBits(sb: TStopBits);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Open;
    procedure Close;

    // read data from port
    function ReadData: string;
//    function ReadBuffer(var buf; size: integer): integer;

    // write data to port
    function WriteData(data: string): integer;
    function WriteBuffer(var buf; size: integer): integer;

    // read pin states
    function ModemSignals: TModemSignals;
    function GetDSR: boolean;
    function GetCTS: boolean;
    function GetRing: boolean;
    function GetCarrier: boolean;

    // set pin states
//    procedure SetRTSDTR(RtsState, DtrState: boolean);
    procedure SetDTR(OnOff: boolean);
    procedure SetRTS(OnOff: boolean);
    procedure SetBreak(OnOff: boolean);

  published
    property Active: boolean read FActive write SetActive;

    property BaudRate: TBaudRate read FBaudRate write SetBaudRate; // default br115200;
    property AltBaudRate: integer read FAltBaudRate write SetAltBaudRate; // default br115200;
    property DataBits: TDataBits read FDataBits write SetDataBits;
    property Parity: TParityType read FParity write SetParity;
    property FlowControl: TSerialFlags read FFlowFlags write SetFlowControl;
    property StopBits: TStopBits read FStopBits write SetStopBits;
    
    property SerialHandle: TSerialHandle read FSerialHandle write FSerialHandle;
    property Device: string read FDevice write FDevice;

    property OnRxData: TNotifyEvent read FOnRxData write FOnRxData;
  end;

procedure Register;

implementation

{ TSdpofpSerial }

procedure TSdpofpSerial.Close;
begin
  Active := false;
end;

procedure TSdpofpSerial.DeviceClose;
begin
  if FSerialHandle = BAD_SERIAL_HANDLE then exit;

  // stop capture thread
  if Assigned(ReadThread) then begin
    ReadThread.FreeOnTerminate := false;
    ReadThread.MustDie := true;
    while not ReadThread.Terminated do begin
      Application.ProcessMessages;
    end;
    ReadThread.Free;
    ReadThread := nil;
  end;

  // close device
  SerFlushInput(FSerialHandle);
  SerFlushOutput(FSerialHandle);
  SerClose(FSerialHandle);
end;

constructor TSdpofpSerial.Create(AOwner: TComponent);
begin
  inherited;
  ReadThread := nil;
  FFlowFlags := [];
  {$IFDEF LINUX}
  FDevice:='/dev/ttyS0';
  {$ELSE}
  FDevice:='COM1';
  {$ENDIF}
  //FBaudRate := br115200;
  FAltBaudRate := 0;
end;


destructor TSdpofpSerial.Destroy;
begin
  Close;
  inherited;
end;

procedure TSdpofpSerial.Open;
begin
  Active := true;
end;

procedure TSdpofpSerial.DeviceOpen;
var ParityType: TParityType;
begin
  FSerialHandle := SerOpen(FDevice);
  if FSerialHandle = BAD_SERIAL_HANDLE then
    raise Exception.Create('Could not open device '+ FDevice);

//  procedure SerSetParams(Handle: TSerialHandle; BitsPerSec: LongInt;
//    ByteSize: Integer; Parity: TParityType; StopBits: Integer;
//    Flags: TSerialFlags);

  //(NoneParity, OddParity, EvenParity);
  ParityType := NoneParity;

  SerSetParams(FSerialHandle,
               BaudRateValue(),
               ConstsBits[FDataBits],
               ParityType,
               ConstsStopBits[FStopBits],
               FFlowFlags);

  // Launch Thread
  ReadThread := TSdpofpSerialReadThread.Create(true);
  ReadThread.Owner := Self;
  ReadThread.MustDie := false;
  ReadThread.start;
end;


function TSdpofpSerial.ReadData: string;
var i: integer;
begin
  result := '';
  if count <= 0 then exit;
  if ReadThread.MustDie then exit;
  SetLength(result, count);
  for i := 0 to count - 1 do begin
    result[i + 1] := chr(buffer[i]);
  end;
end;


procedure TSdpofpSerial.SetActive(state: boolean);
begin
  if state=FActive then exit;

  if state then DeviceOpen
  else DeviceClose;

  FActive:=state;
end;

procedure TSdpofpSerial.SetBaudRate(br: TBaudRate);
begin
  if FSerialHandle <> BAD_SERIAL_HANDLE then begin
    SerSetParams(FSerialHandle, BaudRateValue(), ConstsBits[FDataBits], FParity,
                 ConstsStopBits[FStopBits], FFlowFlags);
  end;
  FBaudRate := br;
end;

procedure TSdpofpSerial.SetAltBaudRate(altbr: integer);
begin
  FAltBaudRate := altbr;
  if FSerialHandle <> BAD_SERIAL_HANDLE then begin
    SerSetParams(FSerialHandle, BaudRateValue(), ConstsBits[FDataBits], FParity,
                 ConstsStopBits[FStopBits], FFlowFlags);
  end;
end;


procedure TSdpofpSerial.SetDataBits(db: TDataBits);
begin
  if FSerialHandle <> BAD_SERIAL_HANDLE then begin
    SerSetParams(FSerialHandle, BaudRateValue(), ConstsBits[FDataBits], FParity,
                 ConstsStopBits[FStopBits], FFlowFlags);
  end;
  FDataBits := db;
end;

procedure TSdpofpSerial.SetFlowControl(fc: TSerialFlags);
begin
  if FSerialHandle <> BAD_SERIAL_HANDLE then begin
    SerSetParams(FSerialHandle, BaudRateValue(), ConstsBits[FDataBits], FParity,
                 ConstsStopBits[FStopBits], FFlowFlags);
  end;
  FFlowFlags := fc;
end;


procedure TSdpofpSerial.SetParity(pr: TParityType);
begin
  if FSerialHandle <> BAD_SERIAL_HANDLE then begin
    SerSetParams(FSerialHandle, BaudRateValue(), ConstsBits[FDataBits], FParity,
                 ConstsStopBits[FStopBits], FFlowFlags);
  end;
  FParity := pr;
end;

procedure TSdpofpSerial.SetStopBits(sb: TStopBits);
begin
  if FSerialHandle <> BAD_SERIAL_HANDLE then begin
    SerSetParams(FSerialHandle, BaudRateValue(), ConstsBits[FDataBits], FParity,
                 ConstsStopBits[FStopBits], FFlowFlags);
  end;
  FStopBits := sb;
end;

function TSdpofpSerial.WriteBuffer(var buf; size: integer): integer;
begin
//  if FSynSer.Handle=BAD_SERIAL_HANDLE then
 //   ComException('can not write to a closed port.');
  result:= SerWrite(FSerialHandle, buf, size);
end;

function TSdpofpSerial.WriteData(data: string): integer;
var numBytes: LongInt;
begin
  result := 0;
  if FSerialHandle = BAD_SERIAL_HANDLE then exit;
  numBytes := Length(data);
  result := SerWrite(FSerialHandle, (@data[1])^, numBytes);
end;

function TSdpofpSerial.ModemSignals: TModemSignals;
begin
  result := [];
  if SerGetCTS(FSerialHandle) then result := result + [ msCTS ];
  if SerGetCD(FSerialHandle) then result := result + [ msCD ];
  if SerGetRI(FSerialHandle) then result := result + [ msRI ];
  if SerGetDSR(FSerialHandle) then result := result + [ msDSR ];
end;

function TSdpofpSerial.GetDSR: boolean;
begin
  result := SerGetDSR(FSerialHandle);
end;

function TSdpofpSerial.GetCTS: boolean;
begin
  result := SerGetCTS(FSerialHandle);
end;

function TSdpofpSerial.GetRing: boolean;
begin
  result := SerGetRI(FSerialHandle);
end;

function TSdpofpSerial.GetCarrier: boolean;
begin
  result := SerGetCD(FSerialHandle);
end;

procedure TSdpofpSerial.SetBreak(OnOff: boolean);
begin
  //SerBreak(FSerialHandle);
end;


procedure TSdpofpSerial.SetDTR(OnOff: boolean);
begin
  SerSetDTR(FSerialHandle, OnOff);
end;


procedure TSdpofpSerial.SetRTS(OnOff: boolean);
begin
  SerSetRTS(FSerialHandle, OnOff);
end;


procedure TSdpofpSerial.ComException(str: string);
begin
  raise Exception.Create('ComPort error: '+str);
end;

function TSdpofpSerial.BaudRateValue: integer;
begin
  if FAltBaudRate > 0 then begin
    result := FAltBaudRate;
  end else begin
    result := ConstsBaud[FBaudRate];
  end;
end;

{ TComPortReadThread }

procedure TSdpofpSerialReadThread.CallEvent;
begin
  if Assigned(Owner.FOnRxData) then begin
    Owner.FOnRxData(Owner);
  end;
end;


procedure TSdpofpSerialReadThread.Execute;
begin
  try
    while not MustDie do begin
      Owner.count := SerReadTimeout(Owner.FSerialHandle, Owner.buffer, sizeof(Owner.buffer), 10);
      if MustDie then break;
      if Owner.count > 0 then begin
        Synchronize(@CallEvent);
      end;
    end;
  finally
    Terminate;
  end;

end;


procedure Register;
begin
  RegisterComponents('5dpo', [TSdpofpSerial]);
end;

initialization
{$i TSdpofpSerial.lrs}

end.
