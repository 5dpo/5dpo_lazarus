{ This file was automatically created by Lazarus. do not edit!
  This source is only used to compile and install the package.
 }

unit SdpoVideo4L2Laz; 

interface

uses
  SdpoVideo4L2, videodev2, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('SdpoVideo4L2', @SdpoVideo4L2.Register); 
end; 

initialization
  RegisterPackage('SdpoVideo4L2Laz', @Register); 
end.
