unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  SdpoFastForm, freenect, sdpofreenect, LCLIntf, IniPropStorage, ExtCtrls, math,
  mmxdebayer, microtimer;

type
  PRGB24Pixel = ^TRGB24Pixel;
  TRGB24Pixel = packed record
    Red:   Byte;
    Green: Byte;
    Blue:  Byte;
  end;


  { TFMain }

  TFMain = class(TForm)
    ApplicationProperties: TApplicationProperties;
    BOpen: TButton;
    BClose: TButton;
    BSetUpdatePeriod: TButton;
    CBShowZoomView: TCheckBox;
    CBVideo: TCheckBox;
    CBDepth: TCheckBox;
    ComboVideoMode: TComboBox;
    EditUpdatePeriod: TEdit;
    EditTiltStatus: TEdit;
    EditTilt: TEdit;
    EditDebug: TEdit;
    EditDelay: TEdit;
    IniPropStorage: TIniPropStorage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo: TMemo;
    Image: TSdpoFastForm;
    ImageDepth: TSdpoFastForm;
    SBzoomlevel: TScrollBar;
    SBLevel: TScrollBar;
    ShapeLed: TShape;
    Timer: TTimer;
    ZoomView: TSdpoFastForm;
    procedure ApplicationPropertiesIdle(Sender: TObject; var Done: Boolean);
    procedure BCloseClick(Sender: TObject);
    procedure BOpenClick(Sender: TObject);
    procedure BSetUpdatePeriodClick(Sender: TObject);
    procedure CBDepthChange(Sender: TObject);
    procedure CBVideoChange(Sender: TObject);
    procedure ComboVideoModeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImageDepthMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure SBLevelChange(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    procedure initDepthTable;
    { private declarations }
  public
    SdpoFreenect: TSdpoFreenect;
    VideoFrameRate, DepthFrameRate: integer;
    VideoFrameTime, DepthFrameTime : DWord;
    VideoLastTimeStamp, DepthLastTimeStamp : uint32_t;
    MagX,Magy: integer;
    zoomSource: Pointer;

    procedure VideoEvent(Sender: TObject; FramePtr: PByte);
    procedure DepthEvent(Sender: TObject; FramePtr: PByte);
  end;

var
  FMain: TFMain;
  t_gamma: array[0..2047] of word;

implementation

{$R *.lfm}

{ TFMain }

procedure TFMain.BOpenClick(Sender: TObject);
begin
  SdpoFreenect.Open;
  if SdpoFreenect.Active then ShapeLed.Brush.Color := clGreen;
end;

procedure TFMain.BSetUpdatePeriodClick(Sender: TObject);
begin
  SdpoFreenect.UpdateTiltPeriod := strtoint(EditUpdatePeriod.Text);
end;

procedure TFMain.CBDepthChange(Sender: TObject);
begin
  SdpoFreenect.Depth := CBDepth.Checked;
end;

procedure TFMain.CBVideoChange(Sender: TObject);
begin
  SdpoFreenect.Video := CBVideo.Checked;
end;

procedure TFMain.ComboVideoModeChange(Sender: TObject);
begin
  SdpoFreenect.VideoFormat := FreenectVideoFormat(ComboVideoMode.ItemIndex);
end;

procedure TFMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  IniPropStorage.WriteInteger('ZoomView_TopPos', ZoomView.TopPos);
  IniPropStorage.WriteInteger('ZoomView_LeftPos', ZoomView.LeftPos);

  IniPropStorage.WriteInteger('ImageDepth_TopPos', ImageDepth.TopPos);
  IniPropStorage.WriteInteger('ImageDepth_LeftPos', ImageDepth.LeftPos);

  IniPropStorage.WriteInteger('Image_TopPos', Image.TopPos);
  IniPropStorage.WriteInteger('Image_LeftPos', Image.LeftPos);

  SdpoFreenect.Close;
end;

procedure TFMain.initDepthTable;
var i: integer;
    k1, k2, k3: double;
begin
  // Stephane Magnenat version
  k1 := 1.1863;
  k2 := 2842.5;
  k3 :=  0.1236;
  for i := 0 to 2047 do begin
    t_gamma[i] := round(256 * k3 * tan(i/k2 + k1));
  end;

  // Glview version
  //for i := 0 to 2047 do begin
  //  v := i / 2048.0;
  //  v := power(v, 3)* 6;
  //  t_gamma[i] := round(v * 6 * 256);
  //end;
end;


procedure TFMain.FormCreate(Sender: TObject);
begin
  MagX := 100;
  Magy := 100;
  zoomSource := Image.data;


 SdpoFreenect := TSdpoFreenect.Create(self);
  SdpoFreenect.OnDepthFrame := @DepthEvent;
  SdpoFreenect.OnVideoFrame := @VideoEvent;
  SdpoFreenect.VideoFormat := FREENECT_VIDEO_BAYER;
  SdpoFreenect.OrientationSystem := true;
  SdpoFreenect.Video := true;

  initDepthTable();
end;


procedure TFMain.FormDestroy(Sender: TObject);
begin
  SdpoFreenect.Free;
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  SdpoFreenect.SetDebugList(Memo.lines);
  Image.TopPos:=IniPropStorage.ReadInteger('Image_TopPos', 100);
  Image.LeftPos:=IniPropStorage.ReadInteger('Image_LeftPos', 100);
  Image.Show;
  ImageDepth.TopPos:=IniPropStorage.ReadInteger('ImageDepth_TopPos', 100);
  ImageDepth.LeftPos:=IniPropStorage.ReadInteger('ImageDepth_LeftPos', 100);
  ImageDepth.Show;
  ZoomView.TopPos:=IniPropStorage.ReadInteger('ZoomView_TopPos', 100);
  ZoomView.LeftPos:=IniPropStorage.ReadInteger('ZoomView_LeftPos', 100);
  ZoomView.Show;
  BSetUpdatePeriod.Click;
  CBDepthChange(Sender);
  CBVideoChange(Sender);
end;

procedure TFMain.ImageDepthMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssCtrl in Shift then exit;
  zoomSource := ImageDepth.data;
  Magx := x;
  Magy := y;
end;

procedure TFMain.ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssCtrl in Shift then exit;
  zoomSource := Image.data;
  Magx := x;
  Magy := y;

end;

procedure TFMain.SBLevelChange(Sender: TObject);
begin
  SdpoFreenect.TiltReference := SBLevel.Position;
end;

procedure TFMain.TimerTimer(Sender: TObject);
begin
  if (not SdpoFreenect.Video) and (not SdpoFreenect.Depth) then begin
    EditDelay.Text:= format('%d',[SdpoFreenect.ProcessEventsCount * 30]);
    SdpoFreenect.ProcessEventsCount := 0;
  end;

  if SdpoFreenect.OrientationSystem then begin
    EditTilt.Text := format('%5.1f',[SdpoFreenect.Tilt]);

    if SdpoFreenect.TiltStatus = TILT_STATUS_STOPPED then begin
      EditTiltStatus.Text := 'Stopped';
      EditTiltStatus.Color:= clDefault;
    end else if SdpoFreenect.TiltStatus = TILT_STATUS_LIMIT then begin
      EditTiltStatus.Text := 'Limit';
      EditTiltStatus.Color:= clred;
    end else if SdpoFreenect.TiltStatus = TILT_STATUS_MOVING then begin
      EditTiltStatus.Text := 'Moving';
      EditTiltStatus.Color:= clDefault;
    end;
  end;

end;



procedure RGB24_to_TrueColor(src: PRGB24Pixel; dest: PLongWord; size: Integer);
var i: integer;
begin
  for i := 0 to size -1 do begin
    dest[i] :=  (src[i].Red shl 16) or (src[i].Green shl 8) or src[i].Blue;
  end;
end;

procedure IR_to_TrueColor(src: Pbyte; dest: PLongWord; size: Integer);
var i: integer;
begin
  for i := 0 to size -1 do begin
    dest[i] :=  (src[i] shl 16) or (src[i] shl 8) or src[i];
  end;
end;


procedure Depth_to_TrueColor(src: PWord; dest: PByte; size: Integer);
var i: integer;
    pval, lb: integer;
begin
  for i := 0 to size -1 do begin
    pval := t_gamma[src[i]];
    lb := pval and $ff;
    case pval shr 8 of
        0: begin
            dest[4*i+0] := 255-lb;
            dest[4*i+1] := 255-lb;
            dest[4*i+2] := 255;
          end;
        1: begin
            dest[4*i+0] := 0;
            dest[4*i+1] := lb;
            dest[4*i+2] := 255;
           end;
       2: begin
            dest[4*i+0] := 0;
            dest[4*i+1] := 255;
            dest[4*i+2] := 255-lb;
          end;
       3: begin
            dest[4*i+0] := lb;
            dest[4*i+1] := 255;
            dest[4*i+2] := 0;
          end;
       4: begin
            dest[4*i+0] := 255;
            dest[4*i+1] := 255-lb;
            dest[4*i+2] := 0;
           end;
       5: begin
            dest[4*i+0] := 255-lb;
            dest[4*i+1] := 0;
            dest[4*i+2] := 0;
          end;
       else begin
              dest[4*i+0] := 0;
              dest[4*i+1] := 0;
              dest[4*i+2] := 0;
       end;
    end;
  end;
end;



procedure TFMain.VideoEvent(Sender: TObject; FramePtr: PByte);
var pdest, psource: pLongWord;
    zoomlevel: integer;
    x, y, z, w, disp: integer;
    start, stop: int64;
    tick: DWord;
begin
  tick := GetTickCount();
  //VideoFrameRate := round(1/((tick - VideoFrameTime)/1000)*0.5 + VideoFrameRate*0.5);
  VideoFrameRate := round(1/((tick - VideoFrameTime)/1000));
  VideoFrameTime := tick;

  EditDebug.Text :=  IntToStr(VideoFrameRate) + 'fps ' + IntToStr(DepthFrameRate) + 'fps ' + IntToStr(SdpoFreenect.VideoTimeStamp - VideoLastTimeStamp);
  VideoLastTimeStamp := SdpoFreenect.VideoTimeStamp;

  start := getMicroTime();
  case SdpoFreenect.VideoFormat of

    FREENECT_VIDEO_RGB: begin
      RGB24_to_TrueColor(PRGB24Pixel(FramePtr), Image.Data, SdpoFreenect.VideoWidth * SdpoFreenect.VideoHeight);
    end;

    FREENECT_VIDEO_BAYER: begin
      debayer32_gbrg(FramePtr, Image.data, SdpoFreenect.VideoWidth, SdpoFreenect.VideoHeight, SdpoFreenect.VideoWidth);
    end;

    FREENECT_VIDEO_IR_8BIT: begin
      IR_to_TrueColor(FramePtr, Image.Data, SdpoFreenect.VideoWidth * SdpoFreenect.VideoHeight)
    end;
  end;
  stop := getMicroTime();
  EditDelay.Text:= format('%dus %d',[stop - start, SdpoFreenect.ProcessEventsCount * VideoFrameRate]);
  SdpoFreenect.ProcessEventsCount := 0;

  Image.Paint;

  if CBShowZoomView.Checked then begin
    zoomlevel := SBzoomlevel.Position;
    pdest := ZoomView.data;
    FillByte(pdest^, ZoomView.Height * ZoomView.Width * sizeof(integer), 0);
    for y := 0 to ZoomView.Height - 1 do begin
      z := max(0, y div zoomlevel + Magy - ZoomView.Width div (2 * zoomlevel));
      w := max(0, MagX - ZoomView.Height div (2 * zoomlevel));
      disp := (z * Image.Width + w);
      if disp > Image.Width * (Image.Height - 2) then break;
      psource :=  zoomSource + disp * sizeof(integer);
      disp := 0;
      for x := 0 to ZoomView.Width - 1 do begin
        pdest^ := psource^;
        inc(disp);
        if disp >= zoomlevel then begin
          inc(psource);
          dec(disp, zoomlevel);
        end;
        inc(pdest);
      end;
    end;
    ZoomView.Paint;
  end;
end;

procedure TFMain.DepthEvent(Sender: TObject; FramePtr: PByte);
var tick: DWord;
begin
  tick := GetTickCount();
  DepthFrameRate := round(1/((tick - DepthFrameTime)/1000)*0.5 + DepthFrameRate*0.5);
  DepthFrameTime := tick;
  //EditDebug.Text := IntToStr(VideoFrameRate) + 'fps ' + IntToStr(DepthFrameRate) + 'fps';

  Depth_to_TrueColor(Pword(FramePtr), ImageDepth.Data, SdpoFreenect.DepthWidth * SdpoFreenect.DEpthHeight);
  ImageDepth.Paint;
end;

procedure TFMain.BCloseClick(Sender: TObject);
begin
  SdpoFreenect.Close;
  if not SdpoFreenect.Active then ShapeLed.Brush.Color := clDefault;
end;

procedure TFMain.ApplicationPropertiesIdle(Sender: TObject; var Done: Boolean);
begin
end;


end.

