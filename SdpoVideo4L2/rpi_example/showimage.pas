unit showimage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  IniPropStorage, BGRABitmap, BGRABitmapTypes;

type

  { TFShowImage }

  TFShowImage = class(TForm)
    IniPropStorage: TIniPropStorage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
  private
    { private declarations }
  public
    image: TBGRABitmap;
    ZoomX, ZoomY: integer;
  end;

var
  FShowImage: TFShowImage;

implementation

uses main;

{$R *.lfm}

{ TFShowImage }

procedure TFShowImage.FormCreate(Sender: TObject);
begin
  image := TBGRABitmap.Create();
end;

procedure TFShowImage.FormDestroy(Sender: TObject);
begin
  image.Free;
end;

procedure TFShowImage.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if not (ssCtrl in Shift) then begin
    ZoomX := X;
    ZoomY := Y;
  end;
end;

procedure TFShowImage.FormPaint(Sender: TObject);
begin
  image.Draw(Canvas, 0, 0, True);
end;

end.
