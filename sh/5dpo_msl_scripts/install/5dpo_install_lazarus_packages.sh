#!/bin/bash 

LAZARUS_PACKAGES_PATH=~/Documents/lazarus_packages
SCRIPTS_PATH=$PWD

cd $SCRIPTS_PATH/software

#lazbuild /usr/share/lazarus/1.8.4/components/anchordocking/anchordocking.lpk --build-ide= --add-package ## not working! only for runtime
lazbuild /usr/share/lazarus/2.0.0/components/onlinepackagemanager/onlinepackagemanager.lpk --build-ide= --add-package 

mkdir -p "$LAZARUS_PACKAGES_PATH"
unzip ./lazarus_packages/lnet.zip -d $LAZARUS_PACKAGES_PATH/
unzip ./lazarus_packages/BGRABitmap.zip -d $LAZARUS_PACKAGES_PATH/
lazbuild $LAZARUS_PACKAGES_PATH/lnet/lazaruspackage/lnetvisual.lpk --build-ide= --add-package
#lazbuild $LAZARUS_PACKAGES_PATH/bgrabitmap-master/bgrabitmap/bgrabitmappack.lpk --build-ide= --add-package ## not working! only for runtime
cd "$LAZARUS_PACKAGES_PATH"
hg clone http://hg.code.sf.net/p/sdpo-cl/mercurial sdpo
lazbuild $LAZARUS_PACKAGES_PATH/sdpo/SdpoDebayer/sdpodebayer.lpk --build-ide= --add-package
lazbuild $LAZARUS_PACKAGES_PATH/sdpo/SdpoDynmatrix/sdpodynmatrix.lpk --build-ide= --add-package
lazbuild $LAZARUS_PACKAGES_PATH/sdpo/SdpoFastForm/sdpofastformlaz.lpk --build-ide= --add-package
lazbuild $LAZARUS_PACKAGES_PATH/sdpo/SdpoJoystick/sdpojoysticklaz.lpk --build-ide= --add-package
lazbuild $LAZARUS_PACKAGES_PATH/sdpo/SdpoPvAPI/sdpopvapilaz.lpk --build-ide= --add-package
lazbuild $LAZARUS_PACKAGES_PATH/sdpo/SdpoSerial/sdposeriallaz.lpk --build-ide= --add-package 
