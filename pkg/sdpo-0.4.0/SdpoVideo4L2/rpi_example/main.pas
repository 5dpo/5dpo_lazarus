unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  SdpoVideo4L2, LCLIntf, ComCtrls, BGRABitmap, BGRABitmapTypes;

type

  { TFMain }

  TFMain = class(TForm)
    CBVideoActive: TCheckBox;
    EditDevice: TEdit;
    EditPixelFormat: TEdit;
    Memo: TMemo;
    StatusBar: TStatusBar;
    Video: TSdpoVideo4L2;
    procedure CBVideoActiveChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
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

uses showimage;

{ TFMain }

procedure TFMain.CBVideoActiveChange(Sender: TObject);
begin
  if CBVideoActive.Checked then begin
    //Video.PixelFormat := TUVCPixelFormat(StrToInt(EditPixelFormat.Text));
    Video.Device := EditDevice.Text;

    FShowImage.Width := Video.Width;
    FShowImage.Height := Video.Height;

    FShowImage.Image.SetSize(Video.Width, Video.Height);
    FShowImage.Show;

    Video.SetDebugList(Memo.Lines);
    Video.Open;

    Video.GetUserControls;
  end else begin
    Video.Close;
    FShowImage.Close;
  end;
end;

procedure TFMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Video.Close;
  FShowImage.Close;
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  //FShowImage.Show;
end;

procedure TFMain.VideoFrame(Sender: TObject; FramePtr: PByte);
begin
  //FrameRate := round(1 / ((GetTickCount() - FrameTime) / 1000) * 0.5 + FrameRate * 0.5);
  FrameRate := round(1e3 / (GetTickCount() - FrameTime));
  FrameTime := GetTickCount();
  StatusBar.SimpleText := format('[%d](%d, %d) %d fps', [Video.PixelFormat, video.Width, Video.Height, FrameRate]);

  move(PByte(FramePtr)^, PByte(FShowImage.image.Data)^, Video.Width * Video.Height * 4);
  FShowImage.Refresh;
end;

initialization
  {$I main.lrs}

// sudo modprobe bcm2835-v4l2

end.

