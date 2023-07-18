{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit SdpoPvAPILaz; 

interface

uses
  PvApi, SdpoPvAPI, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('SdpoPvAPI', @SdpoPvAPI.Register); 
end; 

initialization
  RegisterPackage('SdpoPvAPILaz', @Register); 
end.
