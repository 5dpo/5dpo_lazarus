{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit SdpoFreenectLaz; 

interface

uses
  freenect, sdpofreenect, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('sdpofreenect', @sdpofreenect.Register); 
end; 

initialization
  RegisterPackage('SdpoFreenectLaz', @Register); 
end.
