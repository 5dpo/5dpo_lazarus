#!/bin/bash 

SOFT_REPOS_PATH=~/soft-repos


echo "------------------------------"
echo "----- 5DPO MSL CONFIGURE -----"
echo "------------------------------"


# clone sdpo repositories
if ! [-d "$SOFT_REPOS_PATH"]; then
	mkdir -p "$SOFT_REPOS_PATH"
fi
cd "$SOFT_REPOS_PATH"
git clone https://git.fe.up.pt/5DPO/5dpo_msl_firmware.git
git clone https://git.fe.up.pt/5DPO/5dpo_msl_hwcontrol.git
git clone https://git.fe.up.pt/5DPO/5dpo_msl_coach2017.git
git clone https://git.fe.up.pt/5DPO/5dpo_msl_simtwo.git
git clone https://git.fe.up.pt/5DPO/5dpo_msl_decision.git
git clone https://git.fe.up.pt/5DPO/5dpo_msl_ovis.git

# Alias
echo "alias cd_dec='cd $SOFT_REPOS_PATH/5dpo_msl_decision'" >> ~/.bashrc
echo "alias cd_coach='cd $SOFT_REPOS_PATH/5dpo_msl_coach2017'" >> ~/.bashrc
echo "alias cd_firmware='cd $SOFT_REPOS_PATH/5dpo_msl_firmware'" >> ~/.bashrc
echo "alias cd_hwcontrol='cd $SOFT_REPOS_PATH/5dpo_msl_hwcontrol'" >> ~/.bashrc
echo "alias cd_ovis='cd $SOFT_REPOS_PATH/5dpo_msl_ovis'" >> ~/.bashrc
echo "alias cd_simtwo='cd $SOFT_REPOS_PATH/5dpo_msl_simtwo'" >> ~/.bashrc
echo "alias cd_scripts='cd $SOFT_REPOS_PATH/5dpo_msl_scripts'" >> ~/.bashrc
echo "alias dec='$SOFT_REPOS_PATH/5dpo_msl_decision/decision data1'" >> ~/.bashrc
echo "alias coach='$SOFT_REPOS_PATH/5dpo_msl_coach2017/coach'" >> ~/.bashrc
echo "alias hwcontrol='$SOFT_REPOS_PATH/5dpo_msl_hwcontrol/hwcontrol'" >> ~/.bashrc
echo "alias ovis='$SOFT_REPOS_PATH/5dpo_msl_ovis/ovis data1'" >> ~/.bashrc
source ~/.bashrc
