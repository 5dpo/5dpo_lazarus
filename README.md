5DPO Component Library.

This library includes a serial communication component (TSdpoSerial), a Kinect component (TSdpoFreenect), an UVC video driver component (TSdpoVideo4L2) and a Gtk form component (TSdpoFastForm).
The TSdpoPvAPI component allows access to some industrial cameras. It was tested only in Linux.
TSdpoSerial allows asynchronous communication using a serial port based on Synaser. Works in Linux and Windows.
TSdpoVideo4L2 allows the control of UVC compliant USB cameras, tested with Logitech Quickcam Orbit/Sphere AF, Logitech Quickcam Pro 9000, Logitech Quickcam Ultra Vision and Acer CrystalEye webcam (Acer Aspire One). For more information go to http://linux-uvc.berlios.de/. Works only in Linux.
TSdpoFastForm creates a Gtk window that is useful for fast painting of images (like the ones from the camera) and allows full control of the paint action, useful for real-time image processing. Works only in Linux.
TSdpoJoystick enables the access to a joystick's axis and buttons. Works in Windows and Linux.
There is also a Matrix library the uses extended records and operator overloading to make the TDMatrix type behave almost like a native one.

All programs are compiled with Free Pascal 2.6.4+ (http://www.freepascal.org)

Copyright (c) 2006-2015 by Paulo Costa, Paulo Malheiros, Paulo Marques and Joao Paulo Silva.
All rights reserved.

LICENSING:

Sdpo units are licensed under a modified LGPL license. See file LICENSE and LICENSE.ADDON.

The modification allows to static/smart - link Sdpo libraries into binary applications without providing sources.

Example programs are provided under unmodified gnu GPLv2.

See file INSTALL for more information.
