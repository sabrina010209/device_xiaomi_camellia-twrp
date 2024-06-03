#!/usr/bin/env bash
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2020-2021 The OrangeFox Recovery Project
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

FDEVICE="camellia"
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

if [ -z "$1" ] && [ -z "$FOX_BUILD_DEVICE" ]; then
	fox_get_target_device
fi

if [ "$1" = "$FDEVICE" ] || [  "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
		# Version / Maintainer infos
		export OF_MAINTAINER="AskneZZZ"
		export FOX_VERSION=R12.1
		export FOX_BUILD_TYPE="Stable"

		# Device info
		export FOX_AB_DEVICE=1
		export FOX_VIRTUAL_AB_DEVICE=1
		export TARGET_DEVICE_ALT="camellia,camellian,camellian_p,camellia_p"

		# Display / Leds
		export OF_SCREEN_H="2400"
		export OF_STATUS_H="100"
		export OF_STATUS_INDENT_LEFT=48
		export OF_STATUS_INDENT_RIGHT=48
		export OF_HIDE_NOTCH=1
		export OF_CLOCK_POS=1 # left and right clock positions available
		export OF_USE_GREEN_LED=0

                # Removes the loop block errors after flashing ZIPs (Workaround)
                export OF_LOOP_DEVICE_ERRORS_TO_LOG=1

		# Other OrangeFox configs
		export OF_ENABLE_LPTOOLS=1
		export OF_ALLOW_DISABLE_NAVBAR=0
                export OF_QUICK_BACKUP_LIST="/boot;/data;"
                export FOX_ENABLE_APP_MANAGER=1
		export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
                export OF_FLASHLIGHT_ENABLE=0
		export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
                export TW_DEFAULT_LANGUAGE="en"
		export OF_USE_SYSTEM_FINGERPRINT=1
                export FOX_REPLACE_BUSYBOX_PS=1
	        export OF_FORCE_MAGISKBOOT_BOOT_PATCH_MIUI=1
	        export OF_USE_NEW_MAGISKBOOT=1
	        export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1

		# Run a process after formatting data to work-around MTP issues
		export OF_RUN_POST_FORMAT_PROCESS=1

	        # let's see what are our build VARs
                if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	        export | grep "FOX" >> $FOX_BUILD_LOG_FILE
                export | grep "OF_" >> $FOX_BUILD_LOG_FILE
       	        export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	        export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi

fi
#
