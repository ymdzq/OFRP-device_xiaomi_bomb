#!/system/bin/sh
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2022 The OrangeFox Recovery Project
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

# clear the first 32 bytes of the misc partition to prevent unnecessary bootloops to recovery
# this is only required when building with 10.0+ manifests
clear_init_fatal_reboot_target() {
   local bytes=512;
   usleep 4096;
   echo "Executing $0" >> /tmp/recovery.log
   dd if=/dev/zero of=/dev/block/by-name/misc bs=$bytes count=1;
   usleep 4096;
}

clear_init_fatal_reboot_target;
exit 0;
