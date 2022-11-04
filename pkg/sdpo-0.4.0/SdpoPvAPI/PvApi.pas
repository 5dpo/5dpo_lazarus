unit PvApi;

{$LINKLIB libstdc++}

interface

uses ctypes;


  const
    External_library='libPvAPI.so'; {Setup as you need}


  type
    TArray0to7OfCulong = array[0..7] of culong;
  type
    TArray0to3OfPointer = array[0..3] of pointer;
  type
    TArray0to3OfCulong = array[0..3] of culong;
  type
    TArray0to31OfCulong = array[0..31] of culong;
  type
    TArray0to31OfCchar = array[0..31] of cchar;
  type
    TArray0to15OfCchar = array[0..15] of cchar;

  //Type
  //Pcchar  = ^cchar;
  //PtPvAccessFlags  = ^tPvAccessFlags;
  //PtPvAttributeFlags  = ^tPvAttributeFlags;
  //PtPvAttributeInfo  = ^tPvAttributeInfo;
  //PtPvAttrListPtr  = ^tPvAttrListPtr;
  //PtPvBayerPattern  = ^tPvBayerPattern;
  //PtPvBoolean  = ^tPvBoolean;
  //PtPvCameraEvent  = ^tPvCameraEvent;
  //PtPvCameraInfo  = ^tPvCameraInfo;
  //PtPvCameraInfoEx  = ^tPvCameraInfoEx;
  //PtPvDatatype  = ^tPvDatatype;
  //PtPvErr  = ^tPvErr;
  //PtPvFloat32  = ^tPvFloat32;
  //PtPvFrame  = ^tPvFrame;
  //PtPvHandle  = ^tPvHandle;
  //PtPvImageFormat  = ^tPvImageFormat;
  //PtPvInt32  = ^tPvInt32;
  //PtPvInt64  = ^tPvInt64;
  //PtPvInterface  = ^tPvInterface;
  //PtPvIpConfig  = ^tPvIpConfig;
  //PtPvIpSettings  = ^tPvIpSettings;
  //PtPvLinkEvent  = ^tPvLinkEvent;
  //PtPvUint32  = ^tPvUint32;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


  {
  |==============================================================================
  | Copyright (C) 2006-2011 Allied Vision Technologies.  All Rights Reserved.
  |
  | Redistribution of this header file, in original or modified form, without
  | prior written consent of Allied Vision Technologies is prohibited.
  |
  |=============================================================================
   }
{$ifndef PVAPI_H_INCLUDE}

  const
    PVINFINITE = $FFFFFFFF;    
  { Never timeout }
  {===== TYPE DEFINITIONS ====================================================== }

  type
    tPvHandle = pointer;
    PtPvHandle = ^tPvHandle;
  { Camera handle }
  { }
  { Error codes, returned by most functions: }
  { }
  { No error }
  { Unexpected camera fault }
  { Unexpected fault in PvApi or driver }
  { Camera handle is invalid }
  { Bad parameter to API call }
  { Sequence of API calls is incorrect }
  { Camera or attribute not found }
  { Camera cannot be opened in the specified mode }
  { Camera was unplugged }
  { Setup is invalid (an attribute is invalid) }
  { System/network resources or memory not available }
  { 1394 bandwidth not available }
  { Too many frames on queue }
  { Frame buffer is too small }
  { Frame cancelled by user }
  { The data for the frame was lost }
  { Some data in the frame is missing }
  { Timeout during wait }
  { Attribute value is out of the expected range }
  { Attribute is not this type (wrong access function)  }
  { Attribute write forbidden at this time }
  { Attribute is not available at this time }
  { A firewall is blocking the traffic (Windows only) }

    tPvErr =  clong;
    PtPvErr = ^tPvErr;
    Const
      ePvErrSuccess = 0;
      ePvErrCameraFault = 1;
      ePvErrInternalFault = 2;
      ePvErrBadHandle = 3;
      ePvErrBadParameter = 4;
      ePvErrBadSequence = 5;
      ePvErrNotFound = 6;
      ePvErrAccessDenied = 7;
      ePvErrUnplugged = 8;
      ePvErrInvalidSetup = 9;
      ePvErrResources = 10;
      ePvErrBandwidth = 11;
      ePvErrQueueFull = 12;
      ePvErrBufferTooSmall = 13;
      ePvErrCancelled = 14;
      ePvErrDataLost = 15;
      ePvErrDataMissing = 16;
      ePvErrTimeout = 17;
      ePvErrOutOfRange = 18;
      ePvErrWrongType = 19;
      ePvErrForbidden = 20;
      ePvErrUnavailable = 21;
      ePvErrFirewall = 22;
      __ePvErr_force_32 = $FFFFFFFF;

  {----- Camera Enumeration & Information -------------------------------------- }
  { }
  { Camera access mode.  Used as flags in tPvCameraInfo data, and as the access }
  { mode in PvOpenCamera(). }
  { }
  { Monitor access: no control, read & listen only }
  { Master access: full control }

  type
    tPvAccessFlags =  clong;
    PtPvAccessFlags = ^tPvAccessFlags;
    Const
      ePvAccessMonitor = 2;
      ePvAccessMaster = 4;
      __ePvAccess_force_32 = $FFFFFFFF;

  { }
  { Camera interface type (i.e. firewire, ethernet): }
  { }

  type
    tPvInterface =  clong;
    PtPvInterface = ^tPvInterface;
    Const
      ePvInterfaceFirewire = 1;
      ePvInterfaceEthernet = 2;
      __ePvInterface_force_32 = $FFFFFFFF;

  { }
  { Camera information type (extended) }
  { }
  { Version of this structure }
  {---- Version 1 ---- }
  { Unique value for each camera }
  { People-friendly camera name (usually part name) }
  { Name of camera part }
  { Manufacturer's part number }
  { Camera's serial number }
  { Camera's firmware version }
  { A combination of tPvAccessFlags }
  { Unique value for each interface or bus }
  { Interface type; see tPvInterface }

  type
    tPvCameraInfoEx = packed record
        StructVer : culong;
        UniqueId : culong;
        CameraName : TArray0to31OfCchar;
        ModelName : TArray0to31OfCchar;
        PartNumber : TArray0to31OfCchar;
        SerialNumber : TArray0to31OfCchar;
        FirmwareVersion : TArray0to31OfCchar;
        PermittedAccess : culong;
        InterfaceId : culong;
        InterfaceType : tPvInterface;
      end;
    PtPvCameraInfoEx = ^tPvCameraInfoEx;
  { }
  { Camera information type (deprecated) }
  { }
  { Unique value for each camera }
  { Camera's serial number }
  { Camera part number }
  { Camera part version }
  { A combination of tPvAccessFlags }
  { Unique value for each interface or bus }
  { Interface type; see tPvInterface }
  { People-friendly camera name }
  { Always zero }

    tPvCameraInfo = packed record
        UniqueId : culong;
        SerialString : TArray0to31OfCchar;
        PartNumber : culong;
        PartVersion : culong;
        PermittedAccess : culong;
        InterfaceId : culong;
        InterfaceType : tPvInterface;
        DisplayName : TArray0to15OfCchar;
        _reserved : TArray0to3OfCulong;
      end;
    PtPvCameraInfo = ^tPvCameraInfo;
  { }
  { IP configuration mode for ethernet cameras. }
  { }
  { Use persistent IP settings }
  { Use DHCP, fallback to AutoIP }
  { Use AutoIP only }

    tPvIpConfig =  clong;
    PtPvIpConfig = ^tPvIpConfig;
    Const
      ePvIpConfigPersistent = 1;
      ePvIpConfigDhcp = 2;
      ePvIpConfigAutoIp = 4;
      __ePvIpConfig_force_32 = $FFFFFFFF;

  { }
  { Structure used for PvCameraIpSettingsGet() and PvCameraIpSettingsChange(). }
  { }
  { IP configuration mode: persistent, DHCP & AutoIp, or AutoIp only. }
  { IP configuration mode supported by the camera }
  { Current IP configuration.  Ignored for PvCameraIpSettingsChange().  All }
  { values are in network byte order (i.e. big endian). }
  { Persistent IP configuration.  See "ConfigMode" to enable persistent IP }
  { settings.  All values are in network byte order. }

  type
    tPvIpSettings = packed record
        ConfigMode : tPvIpConfig;
        ConfigModeSupport : culong;
        CurrentIpAddress : culong;
        CurrentIpSubnet : culong;
        CurrentIpGateway : culong;
        PersistentIpAddr : culong;
        PersistentIpSubnet : culong;
        PersistentIpGateway : culong;
        _reserved1 : TArray0to7OfCulong;
      end;
    PtPvIpSettings = ^tPvIpSettings;
  {----- Interface-Link Callback ----------------------------------------------- }
  { }
  { Link (aka interface) event type }
  { }
  { camera first detected after PvInitialize  }
  { camera removed }

    tPvLinkEvent =  clong;
    PtPvLinkEvent = ^tPvLinkEvent;
    Const
      ePvLinkAdd = 1;
      ePvLinkRemove = 2;
      _ePvLink_reserved1 = 3;
      __ePvLink_force_32 = $FFFFFFFF;

  { }
  { Link (aka interface) event Callback type }
  { }
  { Arguments: }
  { }
  {  [i] void* Context,          Context, as provided to PvLinkCallbackRegister }
  {  [i] tPvInterface Interface, Interface on which the event occurred }
  {  [i] tPvLinkEvent Event,     Event which occurred }
  {  [i] culong UniqueId, Unique ID of the camera related to the event }
  { }
  { SDPO TO-DO }
  {typedef void (PVDECL *tPvLinkCallback)(void* Context, }
  {                                       tPvInterface Interface, }
  {                                       tPvLinkEvent Event, }
  {                                       culong UniqueId); }

  type

    tPvLinkCallback = procedure (Context:pointer; PvInterface:tPvInterface; Event:tPvLinkEvent; UniqueId:culong);cdecl;
  {----- Camera-Event Callback ----------------------------------------------- }
  { }
  { Camera event type }
  { }
  { Event ID }
  { Time stamp, lower 32-bits }
  { Time stamp, upper 32-bits }
  { Event data }
(* Const before type ignored *)
  { Event extra-data (nil if none) }

    tPvCameraEvent = packed record
        EventId : culong;
        TimestampLo : culong;
        TimestampHi : culong;
        Data : TArray0to3OfCulong;
        ExtraData : pointer;
      end;
    PtPvCameraEvent = ^tPvCameraEvent;
  { }
  { Camera-event Callback type }
  { }
  { Arguments: }
  { }
  {  [i] void* Context,                     Context, as provided to PvEventCallbackRegister }
  {  [i] tPvHandle Camera,                  Handle of camera which sent the event }
  {  [i] const tPvCameraEvent* EventList,   First event in list.  This list exists only for }
  {                                         the duration of the callback.  If you need it, copy it! }
  {  [i] culong EventListLength      Number of events in EventList }
  { }
  { SDPO TO-DO }
  {typedef void (PVDECL *tPvCameraEventCallback)(void* Context, }
  {                                              tPvHandle Camera, }
  {                                              const tPvCameraEvent* EventList, }
  {                                              culong EventListLength); }
(* Const before type ignored *)

    tPvCameraEventCallback = procedure (Context:pointer; Camera:tPvHandle; EventList:PtPvCameraEvent; EventListLength:culong);cdecl;
  {----- Image Capture --------------------------------------------------------- }
  { }
  { Frame image format type }
  { }
  { Monochrome, 8 bits }
  { Monochrome, 16 bits, data is LSB aligned }
  { Bayer-color, 8 bits }
  { Bayer-color, 16 bits, data is LSB aligned }
  { RGB, 8 bits x 3 }
  { RGB, 16 bits x 3, data is LSB aligned }
  { YUV 411 }
  { YUV 422 }
  { YUV 444 }
  { BGR, 8 bits x 3 }
  { RGBA, 8 bits x 4 }
  { BGRA, 8 bits x 4 }
  { Monochrome, 12 bits,  }
  { Bayer-color, 12 bits, packed }

    tPvImageFormat =  clong;
    PtPvImageFormat = ^tPvImageFormat;
    Const
      ePvFmtMono8 = 0;
      ePvFmtMono16 = 1;
      ePvFmtBayer8 = 2;
      ePvFmtBayer16 = 3;
      ePvFmtRgb24 = 4;
      ePvFmtRgb48 = 5;
      ePvFmtYuv411 = 6;
      ePvFmtYuv422 = 7;
      ePvFmtYuv444 = 8;
      ePvFmtBgr24 = 9;
      ePvFmtRgba32 = 10;
      ePvFmtBgra32 = 11;
      ePvFmtMono12Packed = 12;
      ePvFmtBayer12Packed = 13;
      __ePvFmt_force_32 = $FFFFFFFF;

  { }
  { Bayer pattern.  Applicable when a Bayer-color camera is sending raw bayer }
  { data. }
  { }
  { First line RGRG, second line GBGB... }
  { First line GBGB, second line RGRG... }
  { First line GRGR, second line BGBG... }
  { First line BGBG, second line GRGR... }

  type
    tPvBayerPattern =  clong;
    PtPvBayerPattern = ^tPvBayerPattern;
    Const
      ePvBayerRGGB = 0;
      ePvBayerGBRG = 1;
      ePvBayerGRBG = 2;
      ePvBayerBGGR = 3;
      __ePvBayer_force_32 = $FFFFFFFF;

  { }
  { The frame structure passed to PvQueueFrame(). }
  { NOTE: Memset structure to 0 when allocated.  }
  {       Prosilica filter driver reads AncillaryBuffer pointer.   }
  {       If pointer location random/invalid this will cause issues.  }
  { }
  {----- In ----- }
  { Buffer for image/pixel data. }
  { Size of ImageBuffer in bytes }
  { Camera Firmware >= 1.42 Only. }
  { Buffer to capture ancillary chunk mode data. See ChunkModeActive attr. }
  { This MUST be 0 if not in use. }
  { Chunk mode format: }
  {     [Bytes 1 - 4]   acquisition count. }
  {     [Bytes 5 - 8]   user value. Not currently implemented. 0. }
  {	   [Bytes 9 - 12]  exposure value. }
  {	   [Bytes 13 - 16] gain value. }
  {	   [Bytes 17 - 18] sync in levels. }
  {	   [Bytes 19 - 20] sync out levels. }
  {	   [Bytes 21 - 40] not implemented. 0. }
  {	   [Bytes 41 - 44] chunk ID. 1000. }
  {	   [Bytes 45 - 48] chunk length. }
  { Size of your ancillary buffer in bytes. See NonImagePayloadSize attr. }
  {   Set to 0 for no buffer. }
  { For your use. Possible application: unique ID }
  {   of tPvFrame for frame-done callback. }
  {----- Out ----- }
  { Status of this frame }
  { Image size, in bytes }
  { Ancillary data size, in bytes }
  { Image width }
  { Image height }
  { Start of readout region (left) }
  { Start of readout region (top) }
  { Image format }
  { Number of significant bits }
  { Bayer pattern, if bayer format }
  { Frame counter. Uses 16bit GigEVision BlockID. Rolls at 65535. }
  { Time stamp, lower 32-bits }
  { Time stamp, upper 32-bits }

  type
    tPvFrame = packed record
        ImageBuffer : pointer;
        ImageBufferSize : culong;
        AncillaryBuffer : pointer;
        AncillaryBufferSize : culong;
        Context : TArray0to3OfPointer;
        _reserved1 : TArray0to7OfCulong;
        Status : tPvErr;
        ImageSize : culong;
        AncillarySize : culong;
        Width : culong;
        Height : culong;
        RegionX : culong;
        RegionY : culong;
        Format : tPvImageFormat;
        BitDepth : culong;
        BayerPattern : tPvBayerPattern;
        FrameCount : culong;
        TimestampLo : culong;
        TimestampHi : culong;
        _reserved2 : TArray0to31OfCulong;
      end;
    PtPvFrame = ^tPvFrame;
  { }
  { Frame Callback type }
  { }
  { Arguments: }
  { }
  {  [i] tPvFrame* Frame, Frame completed }
  { }
  { SDPO TO-DO }
  {typedef void (PVDECL *tPvFrameCallback)(tPvFrame* Frame); }

    tPvFrameCallback = procedure (Frame:PtPvFrame);cdecl;
  {----- Attributes ------------------------------------------------------------ }

  type
    tPvInt32 = clong;
    PtPvInt32 = ^tPvInt32;
  { 32-bit signed integer }

    tPvUint32 = culong;
    PtPvUint32 = ^tPvUint32;
  { 32-bit unsigned integer }

    tPvFloat32 = cfloat;
    PtPvFloat32 = ^tPvFloat32;
  { IEEE 32-bit float }

    tPvInt64 = clonglong;
    PtPvInt64 = ^tPvInt64;
  { 64-bit signed integer }

    tPvBoolean = cuchar;
    PtPvBoolean = ^tPvBoolean;
  { boolean }

  { }
  { List of attributes, used by PvAttrList.  This is an array of string }
  { pointers.  The array, and all the string pointers, are const. }
  { }
(* Const before type ignored *)
(* Const before declarator ignored *)

  type
    tPvAttrListPtr = ^Pcchar;
    PtPvAttrListPtr = ^tPvAttrListPtr;
  { }
  { Attribute data type supported }
  { }

    tPvDatatype =  clong;
    PtPvDatatype = ^tPvDatatype;
    Const
      ePvDatatypeUnknown = 0;
      ePvDatatypeCommand = 1;
      ePvDatatypeRaw = 2;
      ePvDatatypeString = 3;
      ePvDatatypeEnum = 4;
      ePvDatatypeUint32 = 5;
      ePvDatatypeFloat32 = 6;
      ePvDatatypeInt64 = 7;
      ePvDatatypeBoolean = 8;
      __ePvDatatypeforce_32 = $FFFFFFFF;

  { }
  { Attribute flags type }
  { }
  { Read access is permitted }
  { Write access is permitted }
  { The camera may change the value any time }
  { Value is read only and never changes }

  type
    tPvAttributeFlags =  clong;
    PtPvAttributeFlags = ^tPvAttributeFlags;
    Const
      ePvFlagRead = $01;
      ePvFlagWrite = $02;
      ePvFlagVolatile = $04;
      ePvFlagConst = $08;
      __ePvFlag_force_32 = $FFFFFFFF;

  { }
  { Attribute information type }
  { }
  { Data type }
  { Combination of tPvAttribute flags }
(* Const before type ignored *)
  { Advanced: see documentation }
(* Const before type ignored *)
  { Advanced: see documentation }
  { Always zero }

  type
    tPvAttributeInfo = packed record
        Datatype : tPvDatatype;
        Flags : culong;
        Category : Pcchar;
        Impact : Pcchar;
        _reserved : TArray0to3OfCulong;
      end;
    PtPvAttributeInfo = ^tPvAttributeInfo;
  {===== FUNCTION PROTOTYPES =================================================== }
  {----- API Version ----------------------------------------------------------- }
  {
   * Function:  PvVersion()
   *
   * Purpose:   Retreive the version number of PvAPI
   *
   * Arguments: 
   *
   * [OUT] culong* pMajor, major version number
   * [OUT] culong* pMinor, minor version number
   *
   * Return:    none
   *
   * This function can be called at anytime, including before the API is
   * initialized.
    }
  { SDPO TO-DO }
  {void PVDECL PvVersion(culong* pMajor,culong* pMinor); }

  procedure PvVersion(pMajor:pculong; pMinor:pculong);cdecl;external External_library name 'PvVersion';

  {----- API Initialization ---------------------------------------------------- }
  {
   * Function:  PvInitialize()
   *
   * Purpose:   Initialize the PvApi module.  This must be called before any
   *            other PvApi function is run.
   *
   * Arguments: none
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available           
   *               ePvErrInternalFault,   an internal fault occurred
    }
  { SDPO TO-DO }
  {tPvErr PVDECL PvInitialize(void); }
  function PvInitialize:tPvErr;cdecl;external External_library name 'PvInitialize';

  {
   * Function:  PvInitializeNoDiscovery()
   *
   * Purpose:   Initialize the PvApi module.  This must be called before any
   *            other PvApi function is run. This version is intended to be used
   *            only when the camera discovery via broadcast is unwanted.
   *
   * Arguments: none
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available           
   *               ePvErrInternalFault,   an internal fault occurred
    }
  { SDPO TO-DO }
  {tPvErr PVDECL PvInitializeNoDiscovery(void); }
  function PvInitializeNoDiscovery:tPvErr;cdecl;external External_library name 'PvInitializeNoDiscovery';

  {
   * Function:  PvUnInitialize()
   *
   * Purpose:   Uninitialize the API module.  This will free some resources,
   *            and shut down network activity if applicable.
   *
   * Arguments: none
   *
   * Return:    none
    }
  { SDPO TO-DO }
  {void PVDECL PvUnInitialize(void); }
  procedure PvUnInitialize;cdecl;external External_library name 'PvUnInitialize';

  {----- Interface-Link Callback ----------------------------------------------- }
  {
   * Function:  PvLinkCallbackRegister()
   *
   * Purpose:   Register a callback for interface events.
   *
   * Arguments:
   *
   * [ IN] tPvLinkCallback Callback, Callback function to run when an event occurs
   * [ IN] tPvLinkEvent Event,       Event to trigger the callback
   * [ IN] void* Context,            For your use: Context is passed to your
   *                                   callback function
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrBadSequence,     API isn't initialized
   *
   * Here's the rules:
   *   - Multiple callback functions may be registered with the same event
   *   - The same callback function may be shared by different events
   *   - The same callback function with the same event may not be registered twice
   *
   * The callback functions are called from a thread within PvApi.  The callbacks
   * are sequenced; i.e. they will not be called simultaneously.
   *
   * Use PvLinkCallbackUnRegister() to stop receiving callbacks.
    }
  { SDPO TO-DO }
  {tPvErr PVDECL PvLinkCallbackRegister(tPvLinkCallback Callback, }
  {                                     tPvLinkEvent Event, }
  {                                     void* Context); }
  function PvLinkCallbackRegister(Callback:tPvLinkCallback; Event:tPvLinkEvent; Context:pointer):tPvErr;cdecl;external External_library name 'PvLinkCallbackRegister';

  {
   * Function:  PvLinkCallbackUnRegister()
   *
   * Purpose:   Unregister a callback for interface events.
   *
   * Arguments:
   *
   * [ IN] tPvLinkCallback Callback, Callback function previously registered
   * [ IN] tPvLinkEvent Event,       Event associated with the callback
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrNotFound,        registered callback was not found
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrBadSequence,     API isn't initialized
    }
  { SDPO TO-DO }
  {tPvErr PVDECL PvLinkCallbackUnRegister(tPvLinkCallback Callback, }
  {                                       tPvLinkEvent Event); }
  function PvLinkCallbackUnRegister(Callback:tPvLinkCallback; Event:tPvLinkEvent):tPvErr;cdecl;external External_library name 'PvLinkCallbackUnRegister';

  {----- Camera Enumeration & Information -------------------------------------- }
  {
   * Function:  PvCameraListEx()
   *
   * Purpose:   List all the cameras currently visible to PvApi (extended)
   *
   * Arguments:
   *
   * [OUT] tPvCameraInfoEx* pList,        Array of tPvCameraInfo, allocated by
   *                                      the caller.  The camera list is copied here.
   * [ IN] culong ListLength,      Length of the caller's pList array
   * [OUT] culong* pConnectedNum,  Number of cameras found (may be more
   *                                      than ListLength!) returned here.
   *                                      May be nil.
   * [ IN] culong StructSize,      Size of tPvCameraInfoEx (sizeof(tPvCameraInfoEx))
   *
   * Return:    Number of pList entries filled, up to ListLength.
    }
  { SDPO TO-DO }
  {culong PVDECL PvCameraListEx(tPvCameraInfoEx* pList, }
  {                                    culong ListLength, }
  {                                    culong* pConnectedNum, }
  {                                    culong StructSize); }
  function PvCameraListEx(pList:PtPvCameraInfoEx; ListLength:culong; pConnectedNum:pculong; StructSize:culong):culong;cdecl;external External_library name 'PvCameraListEx';

  {
   * Function:  PvCameraList()
   *
   * Purpose:   List all the cameras currently visible to PvApi (deprecated)
   *
   * Arguments:
   *
   * [OUT] tPvCameraInfo* pList,          Array of tPvCameraInfo, allocated by
   *                                        the caller.  The camera list is
   *	                                      copied here.
   * [ IN] culong ListLength,      Length of the caller's pList array
   * [OUT] culong* pConnectedNum,  Number of cameras found (may be more
   *                                        than ListLength!) returned here.
   *                                        May be nil.
   *
   * Return:    Number of pList entries filled, up to ListLength.
    }
  { SDPO TO-DO }
  {culong PVDECL PvCameraList(tPvCameraInfo* pList, }
  {                                  culong ListLength, }
  {                                  culong* pConnectedNum); }
  function PvCameraList(pList:PtPvCameraInfo; ListLength:culong; pConnectedNum:pculong):culong;cdecl;external External_library name 'PvCameraList';

  {
   * Function:  PvCameraCount()
   *
   * Purpose:   Number of cameras visible to PvApi (at the time of the call).
   *            Does not include unreachable cameras.
   *
   * Arguments: none
   *
   * Return:    The number of cameras found
   *
   * The number of cameras is dynamic, and may change at any time.
    }
  { SDPO TO-DO }
  {culong PVDECL PvCameraCount(void); }
  function PvCameraCount:culong;cdecl;external External_library name 'PvCameraCount';

  {
   * Function:  PvCameraInfoEx()
   *
   * Purpose:   Retreive information on a given camera (extended)
   *
   * Arguments:
   *
   * [ IN] culong UniqueId,    Unique ID of the camera
   * [OUT] tPvCameraInfExo* pInfo,    Structure where the information will be copied
   * [ IN] culong StructSize,  Size of tPvCameraInfoEx (sizeof(tPvCameraInfoEx))
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrNotFound,        the camera was not found (unplugged)
   *               ePvErrUnplugged,       the camera was found but unplugged during the
   *                                      function call
   *               ePvErrBadParameter,    a valid pointer for pInfo was not supplied
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
  { SDPO TO-DO }
  {tPvErr PVDECL PvCameraInfoEx(culong UniqueId,tPvCameraInfoEx* pInfo,culong StructSize); }
  function PvCameraInfoEx(UniqueId:culong; pInfo:PtPvCameraInfoEx; StructSize:culong):tPvErr;cdecl;external External_library name 'PvCameraInfoEx';

  {
   * Function:  PvCameraInfo()
   *
   * Purpose:   Retreive information on a given camera (deprecated)
   *
   * Arguments:
   *
   * [ IN] culong UniqueId,    Unique ID of the camera
   * [OUT] tPvCameraInfo* pInfo,      Structure where the information will be
   *                                    copied
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrNotFound,        the camera was not found (unplugged)
   *               ePvErrUnplugged,       the camera was found but unplugged during the
   *                                      function call
   *               ePvErrBadParameter,    a valid pointer for pInfo was not supplied
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
  { SDPO TO-DO }
  {tPvErr PVDECL PvCameraInfo(culong UniqueId, tPvCameraInfo* pInfo); }
  function PvCameraInfo(UniqueId:culong; pInfo:PtPvCameraInfo):tPvErr;cdecl;external External_library name 'PvCameraInfo';

  {
   * Function:  PvCameraInfoByAddrEx()
   *
   * Purpose:   Retreive information on a camera, by IP address.  This function
   *            is required if the ethernet camera is not on the local ethernet
   *            network. (extended)
   *
   * Arguments:
   *
   * [ IN] culong IpAddr,          IP address of camera, in network byte order.
   * [OUT] tPvCameraInfo* pInfo,          The camera information will be copied here.
   * [OUT] tPvIpSettings* pIpSettings,    The IP settings will be copied here; nil pointer OK.
   * [ IN] culong StructSize,      Size of tPvCameraInfoEx (sizeof(tPvCameraInfoEx))
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrNotFound,        the camera was not found
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
   *               ePvErrBadParameter,    pIpSettings->size is invalid
   *
   * The specified camera may not be visible to PvCameraList(); it might be on a
   * different ethernet network.  In this case, communication with the camera is
   * routed to the local gateway.
    }
  { SDPO TO-DO }
  {tPvErr PVDECL PvCameraInfoByAddrEx(culong IpAddr, }
  {                                   tPvCameraInfoEx* pInfo, }
  {                                   tPvIpSettings* pIpSettings, }
  {                                   culong StructSize); }
  function PvCameraInfoByAddrEx(IpAddr:culong; pInfo:PtPvCameraInfoEx; pIpSettings:PtPvIpSettings; StructSize:culong):tPvErr;cdecl;external External_library name 'PvCameraInfoByAddrEx';

  {
   * Function:  PvCameraInfoByAddr()
   *
   * Purpose:   Retreive information on a camera, by IP address.  This function
   *            is required if the ethernet camera is not on the local ethernet
   *            network. (deprecated)
   *
   * Arguments:
   *
   * [ IN] culong IpAddr,          IP address of camera, in network byte
   *                                        order.
   * [OUT] tPvCameraInfo* pInfo,          The camera information will be copied
   *                                        here.
   * [OUT] tPvIpSettings* pIpSettings,    The IP settings will be copied here;
   *                                        nil pointer OK.
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrNotFound,        the camera was not found
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
   *               ePvErrBadParameter,    pIpSettings->size is invalid
   *
   * The specified camera may not be visible to PvCameraList(); it might be on a
   * different ethernet network.  In this case, communication with the camera is
   * routed to the local gateway.
    }
  { SDPO TO-DO }
  {tPvErr PVDECL PvCameraInfoByAddr(culong IpAddr, }
  {                                 tPvCameraInfo* pInfo, }
  {                                 tPvIpSettings* pIpSettings); }
  function PvCameraInfoByAddr(IpAddr:culong; pInfo:PtPvCameraInfo; pIpSettings:PtPvIpSettings):tPvErr;cdecl;external External_library name 'PvCameraInfoByAddr';

  {
   * Function:  PvCameraListUnreachableEx()
   *
   * Purpose:   List all the cameras currently inaccessable by PvApi.  This lists
   *            the ethernet cameras which are connected to the local ethernet
   *            network, but are on a different subnet. (extended)
   *
   * Arguments:
   *
   * [OUT] tPvCameraInfo* pList,          Array of tPvCameraInfo, allocated by
   *                                      the caller.  The camera list is
   *	                                    copied here.
   * [ IN] culong ListLength,      Length of the caller's pList array
   * [OUT] culong* pConnectedNum,  Number of cameras found (may be more
   *                                      than ListLength!) returned here.
   *                                      May be nil.
   * [ IN] culong StructSize,      Size of tPvCameraInfoEx (sizeof(tPvCameraInfoEx))
   *
   * Return:    Number of pList entries filled, up to ListLength.
    }
  { SDPO TO-DO }
  {culong PVDECL PvCameraListUnreachableEx(tPvCameraInfoEx* pList, }
  {                                               culong ListLength, }
  {                                               culong* pConnectedNum, }
  {                                               culong StructSize); }
  function PvCameraListUnreachableEx(pList:PtPvCameraInfoEx; ListLength:culong; pConnectedNum:pculong; StructSize:culong):culong;cdecl;external External_library name 'PvCameraListUnreachableEx';

  {
   * Function:  PvCameraListUnreachable()
   *
   * Purpose:   List all the cameras currently inaccessable by PvApi.  This lists
   *            the ethernet cameras which are connected to the local ethernet
   *            network, but are on a different subnet. (deprecated)
   *
   * Arguments:
   *
   * [OUT] tPvCameraInfo* pList,          Array of tPvCameraInfo, allocated by
   *                                        the caller.  The camera list is
   *	                                      copied here.
   * [ IN] culong ListLength,      Length of the caller's pList array
   * [OUT] culong* pConnectedNum,  Number of cameras found (may be more
   *                                        than ListLength!) returned here.
   *                                        May be nil.
   *
   * Return:    Number of pList entries filled, up to ListLength.
    }
  function PvCameraListUnreachable(pList:PtPvCameraInfo; ListLength:culong; pConnectedNum:pculong):culong;cdecl;external External_library name 'PvCameraListUnreachable';

  {----- Opening & Closing ----------------------------------------------------- }
  {
   * Function:  PvCameraOpen()
   *
   * Purpose:   Open the specified camera.  This function must be called before
   *            you can control the camera.
   *
   * Arguments:
   *
   * [ IN] culong UniqueId,    UniqueId of the camera
   * [ IN] tPvAccessFlags AccessFlag, Access flag monitor, master
   * [OUT] tPvHandle* pCamera,        Handle to the opened camera returned here
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrAccessDenied,    the camera couldn't be open in the requested mode
   *               ePvErrNotFound,        the camera was not found (unplugged)
   *               ePvErrUnplugged,       the camera was found but unplugged during the
   *                                      function call
   *               ePvErrBadParameter,    a valid pointer for pCamera was not supplied
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized or camera is alreay open
   *
   * If ePvErrSuccess is returned, you must eventually call PvCameraClose().
   *
   * Alternatively, under special circumstances, you might open an ethernet
   * camera with PvCameraOpenByAddr().
    }
  function PvCameraOpen(UniqueId:culong; AccessFlag:tPvAccessFlags; pCamera:PtPvHandle):tPvErr;cdecl;external External_library name 'PvCameraOpen';

  {
   * Function:  PvCameraOpenByAddr()
   *
   * Purpose:   Open the specified camera, by IP address.  This function is
   *            required, in place of PvCameraOpen(), if the ethernet camera
   *            is not on the local ethernet network.
   *
   * Arguments:
   *
   * [ IN] culong IpAddr,          IP address of camera, in network byte
   *                                        order.
   * [ IN] tPvAccessFlags AccessFlag,     Access flag monitor, master
   * [OUT] tPvHandle* pCamera,            Handle to the opened camera returned here
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrAccessDenied,    the camera couldn't be open in the requested mode
   *               ePvErrNotFound,        the camera was not found (unplugged)
   *               ePvErrUnplugged,       the camera was found but unplugged during the
   *                                      function call
   *               ePvErrBadParameter,    a valid pointer for pCamera was not supplied
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized or camera is alreay open
   *
   * If ePvErrSuccess is returned, you must eventually call PvCameraClose().
   *
   * The specified camera may not be visible to PvCameraList(); it might be on a
   * different ethernet network.  In this case, communication with the camera is
   * routed to the local gateway.
    }
  function PvCameraOpenByAddr(IpAddr:culong; AccessFlag:tPvAccessFlags; pCamera:PtPvHandle):tPvErr;cdecl;external External_library name 'PvCameraOpenByAddr';

  {
   * Function:  PvCameraClose()
   *
   * Purpose:   Close the specified camera.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,      Handle of an opened camera
   *
   * Return:    ePvErrBadHandle if the handle is bad, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrBadHandle,    the handle of the camera is invalid
   *               ePvErrBadSequence,  API isn't initialized
   *
    }
  function PvCameraClose(Camera:tPvHandle):tPvErr;cdecl;external External_library name 'PvCameraClose';

  {
   * Function:  PvCameraIpSettingsGet()
   *
   * Purpose:   Get IP settings for an ethernet camera.  This command will work
   *            for all cameras on the local ethernet network, including
   *            "unreachable" cameras.
   *
   * Arguments:
   *
   * [ IN] culong UniqueId,    UniqueId of the camera
   * [OUT] tPvIpSettings* pSettings,  Camera settings are copied here
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrNotFound,        the camera was not found (or is not
   *                                      an ethernet camera)
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
   *               ePvBadParameter,       pSettings->size is incorrect
   *
   * The camera does not have to be opened to run this command.
    }
  function PvCameraIpSettingsGet(UniqueId:culong; pSettings:PtPvIpSettings):tPvErr;cdecl;external External_library name 'PvCameraIpSettingsGet';

  {
   * Function:  PvCameraIpSettingsChange()
   *
   * Purpose:   Change the IP settings for an ethernet camera.  This command
   *            will work for all cameras on the local ethernet network,
   *            including "unreachable" cameras.
   *
   * Arguments:
   *
   * [ IN] culong UniqueId,            UniqueId of the camera
   * [ IN] const tPvIpSettings* pSettings,    New camera settings
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrNotFound,        the camera was not found
   *               ePvErrAccessDenied,    the camera was already open
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
   *               ePvBadParameter,       pSettings->size is incorrect
   *
   * This command will fail if any application on any host has opened the camera.
    }
(* Const before type ignored *)
  function PvCameraIpSettingsChange(UniqueId:culong; pSettings:PtPvIpSettings):tPvErr;cdecl;external External_library name 'PvCameraIpSettingsChange';

  {----- Image Capture --------------------------------------------------------- }
  {
   * Function:  PvCaptureStart()
   *
   * Purpose:   Setup the camera interface for image transfer.  This does not
   *            necessarily start acquisition.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,      Handle to the camera 
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized or capture already started
   *
   * PvCaptureStart() must be run before PvCaptureQueueFrame() is allowed.  But
   * the camera will not acquire images before the AcquisitionMode attribute is
   * set to a non-idle mode.
    }
  function PvCaptureStart(Camera:tPvHandle):tPvErr;cdecl;external External_library name 'PvCaptureStart';

  {
   * Function:  PvCaptureEnd()
   *
   * Purpose:   Disable the image transfer mechanism.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,      Handle to the camera 
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized or capture already stopped
   *
   * This cannot be called until the frame queue is empty.
    }
  function PvCaptureEnd(Camera:tPvHandle):tPvErr;cdecl;external External_library name 'PvCaptureEnd';

  {
   * Function:  PvCaptureQuery()
   *
   * Purpose:   Check to see if a camera interface is ready to transfer images.
   *            I.e. has PvCaptureStart() been called?
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [OUT] culong* pIsStarted, Result returned here: 1=started, 0=disabled
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvBadParameter,       a valid pointer for pIsStarted was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
  function PvCaptureQuery(Camera:tPvHandle; pIsStarted:pculong):tPvErr;cdecl;external External_library name 'PvCaptureQuery';

  {
   * Function:  PvCaptureAdjustPacketSize()
   *
   * Purpose:   Determine the maximum packet size supported by the system.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,                   Handle to the camera 
   * [ IN] culong MaximumPacketSize     Upper limit: the packet size will
   *                                             not be set higher than this value.
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized or capture already started
   *
   * The maximum packet size can be limited by the camera, host adapter, and
   * ethernet switch.
   *
   * PvCaptureAdjustPacketSize() cannot be run when capture has started.
    }
  function PvCaptureAdjustPacketSize(Camera:tPvHandle; MaximumPacketSize:culong):tPvErr;cdecl;external External_library name 'PvCaptureAdjustPacketSize';

  {
   * Function:  PvCaptureQueueFrame()
   *
   * Purpose:   Queue a frame buffer for image capture.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] tPvFrame* pFrame,          Frame to queue
   * [ IN] tPvFrameCallback Callback, Callback to run when the frame is done;
   *                                    may be nil for no callback
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrQueueFull,       the frame queue is full
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized or capture not started
   *
   * This function returns immediately.  If ePvErrSuccess is returned, the frame
   * will remain in the queue until it is complete, or aborted due to an error or
   * a call to PvCaptureQueueClear().
   *
   * Frames are completed (or aborted) in the order they are queued.
   *
   * You can specify a callback function (the "frame-done callback") to occur
   * when the frame is complete, or you can use PvCaptureWaitForFrameDone() to
   * block until the frame is complete.
   *
   * When the frame callback starts, the tPvFrame data structure is no longer in
   * use and you are free to do with it as you please (for example, reuse or
   * deallocation.)
   *
   * Each frame on the queue must have a unique tPvFrame data structure.
    }
  function PvCaptureQueueFrame(Camera:tPvHandle; pFrame:PtPvFrame; Callback:tPvFrameCallback):tPvErr;cdecl;external External_library name 'PvCaptureQueueFrame';

  {
   * Function:  PvCaptureQueueClear()
   *
   * Purpose:   Empty the frame queue.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
   *
   * Queued frames are returned with status ePvErrCancelled.
   *
   * PvCaptureQueueClear() cannot be called from the frame-done callback.
   *
   * When this function returns, no more frames are left on the queue and you
   * will not receive another frame callback.
    }
  function PvCaptureQueueClear(Camera:tPvHandle):tPvErr;cdecl;external External_library name 'PvCaptureQueueClear';

  {
   * Function:  PvCaptureWaitForFrameDone()
   *
   * Purpose:   Wait for a frame capture to complete.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] tPvFrame* pFrame,          Frame to wait upon
   * [ IN] culong Timeout,     Wait timeout (in milliseconds); use
   *                                    PVINFINITE for no timeout
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrTimeout,         timeout while waiting for the frame
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
   *
   * This function cannot be called from the frame-done callback.
   * 
   * When this function returns, the frame structure is no longer in use and you
   * are free to do with it as you please (for example, reuse or deallocation).
   *
   * If you are using the frame-done callback: this function might return first,
   * or the frame callback might be called first.
   *
   * If the specified frame is not on the queue, this function returns
   * ePvErrSuccess, since we do not know if the frame just left the queue.
    }
(* Const before type ignored *)
  function PvCaptureWaitForFrameDone(Camera:tPvHandle; pFrame:PtPvFrame; Timeout:culong):tPvErr;cdecl;external External_library name 'PvCaptureWaitForFrameDone';

  {----- Attributes ------------------------------------------------------------ }
  {
   * Function:  PvAttrList()
   *
   * Purpose:   List all the attributes for a given camera.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera
   * [OUT] tPvAttrListPtr* pListPtr   Pointer to the attribute list is returned
   *                                    here.  The attribute list is valid until
   *                                    the camera is closed.
   * [OUT] culong* pLength     Length of the list is returned here.  The
   *                                    length never changes while the camera
   *                                    remains opened.
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvBadParameter,       a valid pointer for pListPtr was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
   *
   * The attribute list is contained in memory allocated by the PvApi module.
   * This memory remains static until the camera is closed.
    }
  function PvAttrList(Camera:tPvHandle; pListPtr:PtPvAttrListPtr; pLength:Pculong):tPvErr;cdecl;external External_library name 'PvAttrList';

  {
   * Function:  PvAttrInfo()
   *
   * Purpose:   Retrieve information on an attribute.  This information is
   *            static for each camera.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [OUT] tPvAttributeInfo* pInfo,   The information is copied here
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvBadParameter,       a valid pointer for pInfo was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrInfo(Camera:tPvHandle; Name:Pcchar; pInfo:PtPvAttributeInfo):tPvErr;cdecl;external External_library name 'PvAttrInfo';

  {
   * Function:  PvAttrExists()
   *
   * Purpose:   Check if an attribute exists for the camera.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   *
   * Return:       ePvErrSuccess,         the attribute exists
   *               ePvErrNotFound,        the attribute does not exist
   *
   *            The following error codes may also occur:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrExists(Camera:tPvHandle; Name:Pcchar):tPvErr;cdecl;external External_library name 'PvAttrExists';

  {
   * Function:  PvAttrIsAvailable()
   *
   * Purpose:   Check if an attribute is available.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,              Handle to the camera 
   * [ IN] const cchar* Name,              Attribute name
   *
   * Return:       ePvErrSuccess,         the attribute is available
   *               ePvErrUnavailable,     the attribute is not available
   *
   *            The following error codes may also occur:
   *
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrIsAvailable(Camera:tPvHandle; Name:Pcchar):tPvErr;cdecl;external External_library name 'PvAttrIsAvailable';

  {
   * Function:  PvAttrIsValid()
   *
   * Purpose:   Check if an attribute's value is valid.
   *
   * Arguments: 
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   *
   * Return:       ePvErrSuccess,         the attribute is valid
   *               ePvErrOutOfRange,      the attribute is not valid
   *
   *            The following error codes may also occur:
   *
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrOutOfRange,      the requested attribute is not valid
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrIsValid(Camera:tPvHandle; Name:Pcchar):tPvErr;cdecl;external External_library name 'PvAttrIsValid';

  {
   * Function:  PvAttrRangeEnum()
   *
   * Purpose:   Get the enumeration set for an enumerated attribute.  The set is
   *            returned as a comma separated string containing all allowed
   *            values.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [OUT] cchar* pBuffer,             Caller-allocated buffer; the string is
   *                                    copied here
   * [ IN] culong BufferSize,  Size of buffer, in bytes
   * [OUT] culong* pSize,      Size of the enumeration set string is
   *                                      returned here.  This may be bigger
   *                                      than BufferSize!  (pSize may be nil.)
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvBadParameter,       a valid pointer for pBuffer was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
   *
   * Enumeration sets must be considered dynamic.  For some attributes, the set
   * may change at any time.
    }
(* Const before type ignored *)
  function PvAttrRangeEnum(Camera:tPvHandle; Name:Pcchar; pBuffer:Pcchar; BufferSize:culong; pSize:pculong):tPvErr;cdecl;external External_library name 'PvAttrRangeEnum';

  {
   * Function:  PvAttrRangeUint32()
   *
   * Purpose:   Get the value range for a uint32 attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [OUT] tPvUint32* pMin,           Minimum value returned here
   * [OUT] tPvUint32* pMax,           Maximum value returned here
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvBadParameter,       a valid pointer for pMin or pMax was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrRangeUint32(Camera:tPvHandle; Name:Pcchar; pMin:PtPvUint32; pMax:PtPvUint32):tPvErr;cdecl;external External_library name 'PvAttrRangeUint32';

  {
   * Function:  PvAttrRangeFloat32()
   *
   * Purpose:   Get the value range for a float32 attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [OUT] tPvFloat32* pMin,          Minimum value returned here           
   * [OUT] tPvFloat32* pMax,          Maximum value returned here
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvBadParameter,       a valid pointer for pMin or pMax was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrRangeFloat32(Camera:tPvHandle; Name:Pcchar; pMin:PtPvFloat32; pMax:PtPvFloat32):tPvErr;cdecl;external External_library name 'PvAttrRangeFloat32';

  {
   * Function:  PvAttrRangeInt64()
   *
   * Purpose:   Get the value range for a int64 attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [OUT] tPvInt64* pMin,            Minimum value returned here
   * [OUT] tPvInt64* pMax,            Maximum value returned here
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvBadParameter,       a valid pointer for pMin or pMax was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrRangeInt64(Camera:tPvHandle; Name:Pcchar; pMin:PtPvInt64; pMax:PtPvInt64):tPvErr;cdecl;external External_library name 'PvAttrRangeInt64';

  {
   * Function:  PvCommandRun()
   *
   * Purpose:   Run a specific command on the camera
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvCommandRun(Camera:tPvHandle; Name:Pcchar):tPvErr;cdecl;external External_library name 'PvCommandRun';

  {
   * Function:  PvAttrStringGet()
   *
   * Purpose:   Get the value of a string attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [OUT] cchar* pBuffer,             Caller-allocated buffer; the string is
   *                                    copied here
   * [ IN] culong BufferSize,  Size of buffer, in bytes
   * [OUT] culong* pSize,      Size of the string is returned here.  This
   *                                    may be bigger than BufferSize!  (pSize
   *                                    may be nil.)
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvBadParameter,       a valid pointer for pBuffer was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrStringGet(Camera:tPvHandle; Name:Pcchar; pBuffer:Pcchar; BufferSize:culong; pSize:pculong):tPvErr;cdecl;external External_library name 'PvAttrStringGet';

  {
   * Function:  PvAttrStringSet()
   *
   * Purpose:   Set the value of a string attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [ IN] const cchar* Value,  Value to set
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvErrForbidden,       the requested attribute forbid this operation
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
(* Const before type ignored *)
  function PvAttrStringSet(Camera:tPvHandle; Name:Pcchar; Value:Pcchar):tPvErr;cdecl;external External_library name 'PvAttrStringSet';

  {
   * Function:  PvAttrEnumGet()
   *
   * Purpose:   Get the value of an enumerated attribute.  The enumeration value
   *            is a string.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [OUT] cchar* pBuffer,             Caller-allocated buffer; the string is
   *                                    copied here
   * [ IN] culong BufferSize,  Size of buffer, in bytes
   * [OUT] culong* pSize,      Size of the string is returned here.  This
   *                                    may be bigger than BufferSize!  (pSize
   *                                    may be nil.)
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvBadParameter,       a valid pointer for pBuffer was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrEnumGet(Camera:tPvHandle; Name:Pcchar; pBuffer:Pcchar; BufferSize:culong; pSize:pculong):tPvErr;cdecl;external External_library name 'PvAttrEnumGet';

  {
   * Function:  PvAttrEnumSet()
   *
   * Purpose:   Set the value of an enumerated attribute.  The enumeration value
   *            is a string.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [ IN] const cchar* Value,         Value to set
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvErrForbidden,       the requested attribute forbid this operation
   *               ePvErrOutOfRange,      the supplied value is out of range
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
(* Const before type ignored *)
  function PvAttrEnumSet(Camera:tPvHandle; Name:Pcchar; Value:Pcchar):tPvErr;cdecl;external External_library name 'PvAttrEnumSet';

  {
   * Function:  PvAttrUint32Get()
   *
   * Purpose:   Get the value of a uint32 attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [OUT] tPvUint32* pValue,         Value is returned here
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvBadParameter,       a valid pointer for pValue was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrUint32Get(Camera:tPvHandle; Name:Pcchar; pValue:PtPvUint32):tPvErr;cdecl;external External_library name 'PvAttrUint32Get';

  {
   * Function:  PvAttrUint32Set()
   *
   * Purpose:   Set the value of a uint32 attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [ IN] tPvUint32 Value,           Value to set
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvErrForbidden,       the requested attribute forbid this operation
   *               ePvErrOutOfRange,      the supplied value is out of range
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrUint32Set(Camera:tPvHandle; Name:Pcchar; Value:tPvUint32):tPvErr;cdecl;external External_library name 'PvAttrUint32Set';

  {
   * Function:  PvAttrFloat32Get()
   *
   * Purpose:   Get the value of a float32 attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [OUT] tPvFloat32* pValue,        Value is returned here
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvBadParameter,       a valid pointer for pValue was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrFloat32Get(Camera:tPvHandle; Name:Pcchar; pValue:PtPvFloat32):tPvErr;cdecl;external External_library name 'PvAttrFloat32Get';

  {
   * Function:  PvAttrFloat32Set()
   *
   * Purpose:   Set the value of a float32 attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [ IN] tPvFloat32 Value,          Value to set
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvErrForbidden,       the requested attribute forbid this operation
   *               ePvErrOutOfRange,      the supplied value is out of range
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrFloat32Set(Camera:tPvHandle; Name:Pcchar; Value:tPvFloat32):tPvErr;cdecl;external External_library name 'PvAttrFloat32Set';

  {
   * Function:  PvAttrInt64Get()
   *
   * Purpose:   Get the value of a int64 attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [OUT] tPvInt64* pValue,          Value is returned here
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvBadParameter,       a valid pointer for pValue was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrInt64Get(Camera:tPvHandle; Name:Pcchar; pValue:PtPvInt64):tPvErr;cdecl;external External_library name 'PvAttrInt64Get';

  {
   * Function:  PvAttrInt64Set()
   *
   * Purpose:   Set the value of a int64 attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [ IN] tPvInt64 Value,            Value to set
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvErrForbidden,       the requested attribute forbid this operation
   *               ePvErrOutOfRange,      the supplied value is out of range
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrInt64Set(Camera:tPvHandle; Name:Pcchar; Value:tPvInt64):tPvErr;cdecl;external External_library name 'PvAttrInt64Set';

  {
   * Function:  PvAttrBooleanGet()
   *
   * Purpose:   Get the value of a boolean attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [OUT] tPvBoolean* pValue,        Value is returned here
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvBadParameter,       a valid pointer for pValue was not supplied
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrBooleanGet(Camera:tPvHandle; Name:Pcchar; pValue:PtPvBoolean):tPvErr;cdecl;external External_library name 'PvAttrBooleanGet';

  {
   * Function:  PvAttrBooleanSet()
   *
   * Purpose:   Set the value of a boolean attribute.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera,          Handle to the camera 
   * [ IN] const cchar* Name,          Attribute name
   * [ IN] tPvBoolean Value,          Value to set
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *              
   *               ePvErrBadHandle,       the handle of the camera is invalid
   *               ePvErrUnplugged,       the camera has been unplugged 
   *               ePvErrNotFound,        the requested attribute doesn't exist
   *               ePvErrWrongType,       the requested attribute is not of the correct type
   *               ePvErrForbidden,       the requested attribute forbid this operation
   *               ePvErrOutOfRange,      the supplied value is out of range
   *               ePvErrInternalFault,   an internal fault occurred
   *               ePvErrBadSequence,     API isn't initialized
    }
(* Const before type ignored *)
  function PvAttrBooleanSet(Camera:tPvHandle; Name:Pcchar; Value:tPvBoolean):tPvErr;cdecl;external External_library name 'PvAttrBooleanSet';

  {----- Camera event callback ------------------------------------------------- }
  {
   * Function:  PvCameraEventCallbackRegister()
   *
   * Purpose:   Register a callback for camera events.  The callback will receive
   *            all events for the camera.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera			        Handle to the camera
   * [ IN] tPvCameraEventCallback Callback,   Callback function to run when an event occurs
   * [ IN] void* Context                      For your use: Context is passed to your
   *                                          callback function
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrBadSequence,     API isn't initialized
   *
   * The events generated by a camera are controlled by the attribute system.
   *
   * Here's the rules:
   *   - Multiple callback functions may be registered for the same camera
   *   - The same callback function may be shared by different cameras
   *
   * The callback functions are called from a thread within PvApi.  The callbacks
   * are sequenced; i.e. they will not be called simultaneously.
   *
   * Use PvCameraEventCallbackUnRegister() to stop receiving callbacks.
    }
  function PvCameraEventCallbackRegister(Camera:tPvHandle; Callback:tPvCameraEventCallback; Context:pointer):tPvErr;cdecl;external External_library name 'PvCameraEventCallbackRegister';

  {
   * Function:  PvCameraEventCallbackUnRegister()
   *
   * Purpose:   Unregister a callback for camera events.
   *
   * Arguments:
   *
   * [ IN] tPvHandle Camera		          Handle to the camera
   * [ IN] tPvCameraEventCallback Callback, Callback function previously registered
   *
   * Return:    ePvErrSuccess if no error, otherwise likely to be any of the
   *            following error codes:
   *
   *               ePvErrNotFound,        registered callback was not found
   *               ePvErrResources,       resources requested from the OS were not
   *                                      available
   *               ePvErrBadSequence,     API isn't initialized
    }
  function PvCameraEventCallbackUnRegister(Camera:tPvHandle; Callback:tPvCameraEventCallback):tPvErr;cdecl;external External_library name 'PvCameraEventCallbackUnRegister';

  {----- Utility --------------------------------------------------------------- }
  {
   * Function:  PvUtilityColorInterpolate()
   *
   * Purpose:   Perform color interpolation.  Input format is bayer8 or bayer16
   *            (raw bayer image).  Output format is RGB or separate color
   *            planes.
   *
   * Arguments:
   *
   * [ IN] const tPvFrame* pFrame,        Raw bayer image
   * [OUT] void* BufferRed,               Red plane for output image
   * [OUT] void* BufferGreen,             Green plane for output image
   * [OUT] void* BufferBlue,              Blue plane for output image
   * [ IN] culong PixelPadding,    Padding after each pixel in raw-pixel units
   * [ IN] culong LinePadding,     Padding after each line in raw-pixel units
   *
   * Return:    none
   *
   * Caller must allocate the output buffers:
   *
   *      num_pixels = (((1 + pixel_padding) * width) + line_padding) * height
   *
   *      buffer_size = raw_pixel_size * num_pixels
   *
   * Perhaps the most common way to use this function will be to generate a
   * Win32::StretchDiBits compatible BGR buffer:
   *
   *      #define ULONG_PADDING(x)                        (((x+3) & ~3) - x)
   *
   *      culong line_padding = ULONG_PADDING(width*3);
   *      culong buffer_size = ((width*3) + line_padding) * height;
   *
   *      unsigned char* buffer = new unsigned char[buffer_size];
   *
   *      PvUtilityColorInterpolate(&frame, &buffer[2], &buffer[1],
   *                                &buffer[0], 2, line_padding);
   *
    }
(* Const before type ignored *)
  procedure PvUtilityColorInterpolate(pFrame:PtPvFrame; BufferRed:pointer; BufferGreen:pointer; BufferBlue:pointer; PixelPadding:culong;
              LinePadding:culong);cdecl;external External_library name 'PvUtilityColorInterpolate';

{$endif}
  { PVAPI_H_INCLUDE }

implementation


end.
