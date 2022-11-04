#!/bin/bash

SCRIPTS_PATH=$PWD
cd $SCRIPTS_PATH/software

echo -e "\n----- Camera Modules -----"
echo "----- PvAPI -----"
tar -xzf ./PvAPI_1.28_Linux.tgz -C /opt/
cd /opt/AVT\ GigE\ SDK/inc-pc
cp * /usr/local/include/
cd ../lib-pc/x64/4.4
cp * /usr/local/lib/
cd ../../../bin-pc/x64
cp *.so /usr/local/lib/
cp SampleViewer CLIpConfig /usr/bin
bash -c 'echo "/usr/local/lib" >> /etc/ld.so.conf'
ldconfig
apt install libjpeg62 -y