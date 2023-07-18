unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  SdpoVideo4L2, SdpoFastForm, LCLIntf, ComCtrls;

type
  PRGB24Pixel = ^TRGB24Pixel;
  TRGB24Pixel = packed record
    Red:   Byte;
    Green: Byte;
    Blue:  Byte;
  end;

  { TFMain }

  TFMain = class(TForm)
    CBVideoActive: TCheckBox;
    EditDevice: TEdit;
    Image: TSdpoFastForm;
    Memo: TMemo;
    StatusBar: TStatusBar;
    Video: TSdpoVideo4L2;
    procedure CBVideoActiveChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure MemoChange(Sender: TObject);
    procedure VideoFrame(Sender: TObject; FramePtr: PByte);
  private
    { private declarations }
  public
    { public declarations }
    FrameRate: integer;
    FrameTime : DWord;
  end;

var
  FMain: TFMain;

implementation

{ TFMain }

procedure TFMain.CBVideoActiveChange(Sender: TObject);
begin
  if CBVideoActive.Checked then begin
    Video.Device:=EditDevice.Text;
    if not (Video.PixelFormat in [uvcpf_YUYV, uvcpf_YUV420, uvcpf_RGB24, uvcpf_BGR24]) then
    begin
      ShowMessage('This little demo program can only display YUYV, '
                + 'YUV420, RGB24 or BGR24. If you are using libv4l '
                + 'then it should be possible to request at least '
                + 'RGB24, BGR24 or YUV420 from all supported v4l2 '
                + 'devices.');
    end;
    Image.Width := Video.Width;
    Image.Height := Video.Height;
    Image.Show;

    Video.SetDebugList(Memo.Lines);
    Video.Open;

    Video.GetUserControls;
  end else begin
    Video.Close;
    Image.Close;
  end;
end;

procedure TFMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Video.Close;
  Image.Close;
end;

procedure TFMain.MemoChange(Sender: TObject);
begin

end;

// this format (like many others) is not guaranteed
// to be supported by all devices.
procedure YUYV_to_Gray(src: PLongWord; dest: PLongWord; size: integer);
var i, r,g,b: integer;
begin
  for i := 0 to (size div 2) - 1 do begin
    g := src^ and $FF;
    r := g;
    b := g;
    dest^ := (r shl 16) or (g shl 8) or (b);
    Inc(dest);
    g := (src^ shr 16) and $FF;
    r := g;
    b := g;
    dest^ := (r shl 16) or (g shl 8) or (b);
    Inc(src);
    Inc(dest);
  end;
end;

// when using the libv4l wrapper then YUV420 is always
// amongst the supported formats, even if the camera
// would not support it natively.
procedure YUV420_to_Gray(src: PByte; dest: PLongWord; size: integer);
var i, r,g,b: integer;
begin
  // Y, U and V are not interleaved, they are in continuous
  // blocks. We read the first block containing Y (8 bit per pixel)
  // and simply ignore the rest.
  for i := 0 to size -1 do begin
    g := src[i];
    r := g;
    b := g;
    dest[i] := (r shl 16) or (g shl 8) or (b);
  end;
end;

// when using the libv4l wrapper then RGB24 is always
// amongst the supported formats, even if the camera
// would not support it natively.
procedure RGB24_to_TrueColor(src: PRGB24Pixel; dest: PLongWord; size: Integer);
var i: integer;
begin
  for i := 0 to size -1 do begin
    dest[i] :=  (src[i].Red shl 16) or (src[i].Green shl 8) or src[i].Blue;
  end;
end;

// when using the libv4l wrapper then BGR24 is always
// amongst the supported formats, even if the camera
// would not support it natively.
procedure BGR24_to_TrueColor(src: PRGB24Pixel; dest: PLongWord; size: Integer);
var i: integer;
begin
 // move(src^, dest^, size*4);
  for i := 0 to size -1 do begin
    // this is the reason why often BGR instead of RGB
    // is used, we don't need shifting like above, we can
    // simply dump entire longwords into their new locations.
    dest[i] := PLongWord(@src[i])^;
  end;
end;

procedure TFMain.VideoFrame(Sender: TObject; FramePtr: PByte);
begin
  //FrameRate:=round(1/((GetTickCount-FrameTime)/1000)*0.5 + FrameRate*0.5);
  FrameRate:=round(1/((GetTickCount-FrameTime)/1000));
  FrameTime:=GetTickCount;
  StatusBar.SimpleText := format('(%d, %d) %d fps', [video.Width, Video.Height, FrameRate]);

  if Video.Width * Video.Height <> Image.Width * Image.Height then
  begin
    // I have seen this happening when the driver accepted
    // the video dimensions without complaining but then
    // silently set them to its own liking. For the sake of
    // simplicity we simply raise an exception here and don't
    // attempt to fix it.
    raise Exception.Create('Video picture size is different from what we had requested');
  end;

  case Video.PixelFormat of
    uvcpf_YUYV:
      YUYV_to_Gray(PLongWord(FramePtr), PLongWord(Image.Data), Video.Width * Video.Height);
    uvcpf_YUV420:
      YUV420_to_Gray(FramePtr, Image.Data, Video.Width * Video.Height);
    uvcpf_RGB24:
      RGB24_to_TrueColor(PRGB24Pixel(FramePtr), Image.Data, Video.Width * Video.Height);
    uvcpf_BGR24:
      BGR24_to_TrueColor(PRGB24Pixel(FramePtr), Image.Data, Video.Width * Video.Height);
  end;
  Image.Paint;
end;

initialization
  {$I main.lrs}

end.

