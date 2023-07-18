{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit sdpofpseriallaz;

interface

uses
  sdpofpserial, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('sdpofpserial', @sdpofpserial.Register);
end;

initialization
  RegisterPackage('sdpofpseriallaz', @Register);
end.
