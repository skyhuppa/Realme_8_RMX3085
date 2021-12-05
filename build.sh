#!/bin/bash
# Just a basic script U can improvise lateron asper ur need xD 

abort() { echo "$1"; exit 1; }

MANIFEST="https://gitlab.com/OrangeFox/Manifest.git -b fox_11.0"
DEVICE=Infinix_X573
DT_LINK="https://github.com/skyhuppa/Realme_8_RMX3085 -b fox-11.0"
DT_PATH=device/realme/$DEVICE

echo " ===+++ Setting up Build Environment +++==="
apt install openssh-server openjdk-8-jdk -y
apt update --fix-missing
apt install openssh-server openjdk-8-jdk -y
git clone https://gitlab.com/OrangeFox/misc/scripts
cd scripts
sudo bash setup/android_build_env.sh
sudo bash setup/install_android_sdk.sh

echo " ===+++ Syncing Recovery Sources +++==="
mkdir ~/OrangeFox_sync
cd ~/OrangeFox_sync
repo init --depth=1 -u $MANIFEST
repo sync -j8 --force-sync
git clone --depth=1 $DT_LINK $DT_PATH

echo " ===+++ Building Recovery +++==="
source build/envsetup.sh
echo " source build/envsetup.sh done"

export ALLOW_MISSING_DEPENDENCIES=true
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export LC_ALL="C"
lunch twrp_${DEVICE}-eng || abort " lunch failed with exit status $?"
echo " lunch twrp_${DEVICE}-eng done"
mka recoveryimage || abort " mka failed with exit status $?"
echo " mka recoveryimage done"

# Upload zips & recovery.img (U can improvise lateron adding telegram support etc etc)
echo " ===+++ Uploading Recovery +++==="
cd out/target/product/$DEVICE
ofoxzip="$(ls OrangeFox-*.zip)"
curl -T $ofoxzip https://oshi.at
#curl -F "file=@${ofoxzip}" https://file.io
#curl --upload-file $ofoxzip http://transfer.sh/
