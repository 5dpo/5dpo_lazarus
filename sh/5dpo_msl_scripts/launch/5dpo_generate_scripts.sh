#!/bin/bash

ROBOT_NUMBER=${1:-''}
ROBOT_GENERATION=${2:-"new"}

# decision
echo "#!/bin/bash
cd ~/soft-repos/5dpo_msl_decision
./decision data$ROBOT_NUMBER" >> decision.sh
chmod +x decision.sh

echo "#!/bin/bash
cd ~/soft-repos/5dpo_msl_decision
lazbuild decision.lpi -B
./decision data$ROBOT_NUMBER" >>decision_build.sh
chmod +x decision_build.sh


# ovis
echo "#!/bin/bash
cd ~/soft-repos/5dpo_msl_ovis
./ovis data$ROBOT_NUMBER" >> ovis.sh
chmod +x ovis.sh

echo "#!/bin/bash
cd ~/soft-repos/5dpo_msl_ovis
lazbuild decision.lpi -B
./ovis data$ROBOT_NUMBER" >> ovis_build.sh
chmod +x ovis_build.sh


# hwcontrol
echo "#!/bin/bash
cd ~/soft-repos/5dpo_msl_hwcontrol
./hwcontrol data$ROBOT_NUMBER" >> hwcontrol.sh
chmod +x hwcontrol.sh

echo "#!/bin/bash
cd ~/soft-repos/5dpo_msl_hwcontrol
lazbuild decision.lpi -B
./hwcontrol data$ROBOT_NUMBER" >> hwcontrol_build.sh
chmod +x hwcontrol_build.sh


# flashbus
echo "#!/bin/bash
cd ~/soft-repos/flashbus/master/
./flashbus" >> flashbus.sh
chmod +x flashbus.sh

echo "#!/bin/bash
cd ~/soft-repos/flashbus/master/
lazbuild decision.lpi -B
./flashbus" >> flashbus_build.sh
chmod +x flashbus_build.sh


if [ $ROBOT_GENERATION == "new" ]; then
	hardware_software='hwcontrol'
elif [ $ROBOT_GENERATION == "old" ]; then
	hardware_software='flashbus'
else
  hardware_software='hwcontrol' #default
fi

# game
echo "#!/bin/bash
./$hardware_software.sh &
./decision.sh &
./ovis.sh" >> game.sh
chmod +x game.sh


# kill all
echo "#!/bin/bash
killall $hardware_software &
killall decision &
killall ovis exit" >> killall.sh
chmod +x killall.sh
