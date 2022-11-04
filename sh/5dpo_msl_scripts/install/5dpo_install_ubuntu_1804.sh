#!/bin/bash

INSTALL_ROS=false
INSTALL_REMOTE_ACCESS_UTILITIES=false
SCRIPTS_PATH=$PWD

echo "-----------------------------------------------------"
echo "----- 5DPO MSL INSTALLATION SCRIPT (march 2019) -----"
echo "-----------------------------------------------------"

cd software

# basic utilities
echo -e "\n----- Installing Utilities -----"
sudo apt install terminator -y
sudo apt install htop -y
sudo apt install git -y
sudo apt install unzip -y
sudo dpkg -i gitkraken-amd64.deb
sudo apt install -f
sudo dpkg -i gitkraken-amd64.deb

# Camera stuff
echo -e "\n----- Camera Modules -----"
echo "----- PvAPI -----"
sudo tar -xzf ./PvAPI_1.28_Linux.tgz -C /opt/
cd /opt/AVT\ GigE\ SDK/inc-pc
sudo cp * /usr/local/include/
cd ../lib-pc/x64/4.4
sudo cp * /usr/local/lib/
cd ../../../bin-pc/x64
sudo cp *.so /usr/local/lib/
sudo cp SampleViewer CLIpConfig /usr/bin
sudo bash -c 'echo "/usr/local/lib" >> /etc/ld.so.conf'
sudo ldconfig
sudo apt install libjpeg62 -y
cd $SCRIPTS_PATH/software

echo "----- Vimba Viewer -----"
sudo tar -xzf ./Vimba_v2.1.3_Linux.tgz -C /opt/
cd /opt/Vimba_2_1/VimbaGigETL
sudo ./Install.sh
cd $SCRIPTS_PATH/software


# IDEs
echo -e "\n----- Installing IDEs -----"
echo "----- Arduino -----"
sudo tar xf arduino-1.8.8-linux64.tar.xz -C /opt/
cd /opt/arduino-1.8.8
sudo ./install.sh
./arduino-linux-setup.sh $USER
cd $SCRIPTS_PATH/software/lazarus
echo "----- Lazarus -----"
sudo apt install libgtk2.0-dev -y
sudo dpkg -i fpc-src_3.0.4-2_amd64.deb
sudo dpkg -i fpc-laz_3.0.4-1_amd64.deb
sudo dpkg -i lazarus-project_2.0.0-0_amd64.deb
sudo chmod -R 777 /usr/share/lazarus
sudo chmod -R 777 /usr/bin/lazarus-ide
sudo chmod -R 777 /usr/bin/lazbuild
sudo chmod -R 777 /usr/bin/startlazarus
sudo chmod -R 777 /usr/bin/gdb
echo "lazarus-project hold" | sudo dpkg --set-selections
echo "fpc hold" | sudo dpkg --set-selections
echo "fpc-src hold" | sudo dpkg --set-selections

# ZMQ
sudo sh 5dpo_install_zmq.sh
cd $SCRIPTS_PATH/software

# ROS
if "$INSTALL_ROS" = true ; then
	echo -e "\n----- Installing ROS -----"
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
	sudo apt update
	sudo apt install ros-melodic-desktop-full -y
	apt search ros-melodic
	sudo rosdep init
	rosdep update
	echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
	source ~/.bashrc
	sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential -y
	mkdir -p ~/catkin_ws/src && cd ~/catkin_ws
	catkin_make
else
  echo -e "\n--- Skipping ROS Installation ---"
fi

# remote access utilities
if "$INSTALL_REMOTE_ACCESS_UTILITIES" = true ; then
	echo -e "\n----- Installing Remote Access Utilities -----"
	sudo apt install openssh-sftp-server -y
	sudo apt install nfs-kernel-server -y
	sudo apt install tightvncserver -y
	sudo apt install openssh-server -y
else
	echo -e "\n--- Skipping Remote Access Utilities Installation---"
fi

sudo adduser $USER dialout

read -p "Press any key to continue... "
echo "installation finished"
