# 5DPO MSL Scripts

This repository contains some scripts to install and setup the 5DPO deployment and development environments (for (x)ubuntu 18.04), as well as the scripts to launch the applications.

## Installation  instructions

### System setup

1. Create soft-repos directory:
```
mkdir ~/soft-repos && cd soft-repos
```

2. Download (on a web browser) or clone the this repository into soft-repos folder:
```
git clone https://gitlab.inesctec.pt/5DPO/5dpo_msl_scripts.git
```

3. Navigate into the installation directory
```
cd 5dpo_msl_scripts/install
```

4. Execute the installation and configuration scripts in the following order:
```
./5dpo_install_ubuntu_1804.sh
./5dpo_configure.sh
```

5. Execute lazarus to setup the configuration folder and, after that, execute the folloing command
```
./5dpo_install_lazarus_packages.sh
```

**Note:** If the a script don't have executable permissions, give it by executing the following command:
```
chmod +x <script_name>
```

### Launching scripts

1. Naviate into the scripts launcher folder
```
cd ~/soft-repos/5dpo_msl_scripts/launch
```

2. Execute the script launcher generator:
```
./5dpo_generate_scripts <robot_number> <hardware_version>
```

The arguments have the following meaning. If no arguments are passed, data folder is *data* and hardware_version is *hwcontrol* (newer version)
	* *<robot_number>:* {1..6}
	* *<hardware_version>:* {new, old}

Example:
```
cd ~/soft-repos/5dpo_msl_scripts/launch 1 old
```


## Installed software

* Lazarus
* Vimba and PvAPI
* Arduino IDE
* Visual Studio Code
* Sublime Text
* ZeroMQ
* ROS Melodic \*
* Remote Acess Utilities \*
	* openssh-sftp-server
	* openssh-server
	* tightvncserver
	* nfs-kernel-server
* terminator
* gedit
* tortoisehg
* synaptic
* htop
* vim
* flameshot
* git
* unzip
* gitkraken

\* optional

## Alias

The following alias are created after running the *configure* script.
* cd_dec
* cd_coach
* cd_firmware
* cd_hwcontrol
* cd_ovis
* cd_simtwo
* cd_flashbus
* cd_scripts
* dec
* coach
* hwcontrol
* ovis
* flashbus

## Notes

* The user in *$USER* is added to the group of dialout.

