#
# Copyright (C) 2020 The Android Open Source Project
# Copyright (C) 2020 The TWRP Open Source Project
# Copyright (C) 2020 SebaUbuntu's TWRP device tree generator
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# 关于橙狐变量详见 OrangeFox_10/fox_10.0/vendor/recovery/orangefox_build_vars.txt

    ## 构建信息
    # 设置显示在关于页面里的维护人员名称
    export OF_MAINTAINER=ymdzq
    # 设置版本号为日期
    export FOX_VERSION=$(date +%y.%m.%d)

    ## 添加功能
    # 使用完整版ps命令
    export FOX_REPLACE_BUSYBOX_PS=1
    # 使用完整版getprop命令
    export FOX_REPLACE_TOOLBOX_GETPROP=1
    # 支持tar命令
    export FOX_USE_TAR_BINARY=1
    # 支持sed命令
    export FOX_USE_SED_BINARY=1
    # 使用bash代替sh和ash
    export FOX_USE_BASH_SHELL=1
    export FOX_ASH_IS_BASH=1
    # 使用完整版grep命令
    export FOX_USE_GREP_BINARY=1
    # 支持lzma, xz命令
    export FOX_USE_XZ_UTILS=1
    # 使用橙狐编译的NANO编辑器
    export FOX_USE_NANO_EDITOR=1

    ## 添加橙狐特殊处理
    # 使用magisk处理boot镜像
    export OF_USE_MAGISKBOOT=1
    # 使用magisk处理所有boot和recovery镜像
    export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
    # 尝试处理AVB2.0，防止橙狐被官方recovery替换
    export OF_PATCH_AVB20=1

    ## 硬件功能设定
    # 没有绿色led
    export OF_USE_GREEN_LED=0
    # 关闭闪光灯功能
    # export OF_FLASHLIGHT_ENABLE=0
    # 自定义闪光灯路径，修复闪光灯
    export OF_FL_PATH1=/sys/class/leds/torch-light0
    export OF_FL_PATH2=/sys/class/leds/torch-light1
    export OF_FL_PATH3=/sys/class/leds/torch-light2

    ## 界面显示设定
    # 设置屏幕高度，状态栏高度，状态栏左右边距
    export OF_SCREEN_H=2400
    export OF_STATUS_H=59
    export OF_STATUS_INDENT_LEFT=90
    export OF_STATUS_INDENT_RIGHT=90
    # 添加黑色状态栏（隐藏刘海）选项
    export OF_HIDE_NOTCH=1
    # 由于有刘海遮挡，设置时钟位置为只能显示在左侧或右侧
    export OF_CLOCK_POS=1
    # 禁止禁用导航栏
    export OF_ALLOW_DISABLE_NAVBAR=0

    ## 使刷机包兼容红米10X 5G和红米10X Pro
    # 使红米10X 5G和红米10X Pro都能刷入橙狐zip卡刷包
    export TARGET_DEVICE_ALT="atom, bomb"
    # 使橙狐可以刷入具有机型检测限制为红米10X 5G或者红米10X Pro的zip卡刷包
    export OF_TARGET_DEVICES="atom,bomb"

    ## 技术性调整
    # 设定recovery、system、vendor、boot分区路径
	export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/platform/bootdevice/by-name/recovery"
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
    export FOX_RECOVERY_BOOT_PARTITION="/dev/block/platform/bootdevice/by-name/boot"
	# 避免在已加密设备上应用强制加密补丁
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	# 跳过FBE解密流程（防止卡在橙狐LOGO或Redmi/Mi LOGO界面）
	export OF_SKIP_FBE_DECRYPTION=1
	# 防止橙狐在解密后重新运行自启动进程
    export OF_NO_RELOAD_AFTER_DECRYPTION=1
    # 使用指定的magisk
    # export FOX_USE_SPECIFIC_MAGISK_ZIP="~/magisk/Magisk22.0.zip"

