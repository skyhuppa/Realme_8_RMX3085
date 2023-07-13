#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2021 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="RMX3085"
#set -o xtrace

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
   	export TW_DEFAULT_LANGUAGE="en"
	export LC_ALL="C"
 	export ALLOW_MISSING_DEPENDENCIES=true
  	export TARGET_DEVICE_ALT="RMX3085"
	export FOX_TARGET_DEVICES="RMX3085"
#	export FOX_VIRTUAL_AB_DEVICE=1
#	export FOX_AB_DEVICE=1
  
	# export OF_KEEP_FORCED_ENCRYPTION=1
        export OF_DONT_PATCH_ON_FRESH_INSTALLATION=1
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export OF_KEEP_DM_VERITY_FORCED_ENCRYPTION=1
	export OF_SKIP_FBE_DECRYPTION_SDKVERSION=34 # Don't try to decrypt A14(?)
	export OF_SKIP_DECRYPTED_ADOPTED_STORAGE=1
	export OF_PATCH_AVB20=1
	export OF_SCREEN_H=2400
	export OF_STATUS_H=100
	export OF_STATUS_INDENT_LEFT=48
	export OF_STATUS_INDENT_RIGHT=48
  	export OF_HIDE_NOTCH=1
	export OF_CLOCK_POS=1
        export OF_ENABLE_LPTOOLS=1
	export OF_ALLOW_DISABLE_NAVBAR=0
        export OF_USE_MAGISKBOOT=1
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
        export FOX_BUGGED_AOSP_ARB_WORKAROUND="1546300800" # Tue Jan 1 2019 00:00:00 GMT
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	#export OF_FORCE_MAGISKBOOT_BOOT_PATCH_MIUI=1; # if you disable this, then enable the next line
	export OF_NO_MIUI_PATCH_WARNING=1
	export OF_USE_GREEN_LED=
        export OF_FL_PATH1="/tmp/flashlight" # See /init.recovery.mt6785.rc for more information

        # Device-specific flags
        export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/by-name/recovery"
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export FOX_RECOVERY_BOOT_PARTITION="/dev/block/by-name/boot"

	# use magisk 21.4 for the magisk addon
	#export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk-21.4.zip

	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_NANO_EDITOR=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_ZIP_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_REPLACE_BUSYBOX_PS=1
	export OF_USE_NEW_MAGISKBOOT=1
	#export FOX_BUGGED_AOSP_ARB_WORKAROUND="1510672800"; # Tue Nov 14 15:20:00 GMT 2017

	# OTA for custom ROMs
	export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
	export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1

	# -- add settings for R11 --
        export OF_MAINTAINER=Skyhuppa
        export FOX_BUILD_TYPE="Alpha"
        export FOX_VARIANT=A12.1
	export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
	export OF_QUICK_BACKUP_LIST="/boot;/data;"
	# -- end R11 settings --

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
	fi
fi
#
