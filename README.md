# 橙 狐 (OFRP) for Redmi 10X Pro (bomb)
使用红米 10X Pro，MIUI 13（安卓12）制作，提取官方安卓12内核，适用于橙狐安卓12分支  

![OFRP](https://image.ibb.co/cTMWux/logo.jpg "OFRP")  
====================================================
# 目前进度
recovery基本功能都可以正常使用  
使用红米10X Pro制作，同时支持红米10X 5G  
为了兼容，同一个recovery支持刷入上述两个型号手机的rom，刷rom前请确认机器实际型号，如果刷错另一个机器的rom包可能会出现无法使用相机的问题以及其他bug  
# 如何使用
进入[Release](https://github.com/ymdzq/OFRP-device_xiaomi_bomb/releases)中，点开Assets选项，点击zip压缩包文件名下载  
zip卡刷包可以使用其他第三方rec刷入（例如wzsx150的twrp或者残芯的pbrp或者旧版本橙狐升级），不支持miui官方rec刷入  
或者解压后得到recovery.img文件，已root手机可以通过爱玩机工具箱、搞机助手等app直接写入recovery分区  
也可以手机连接电脑线刷，请自备[fastboot工具](https://developer.android.google.cn/studio/releases/platform-tools?hl=zh-cn)，手动重启手机至bootloader模式（橙色fastboot字样）  
使用fastboot工具先刷入[vbmeta](https://github.com/ymdzq/OFRP-device_xiaomi_bomb/releases/download/21.04.11/vbmeta.img)禁用avb验证，然后再把rec镜像刷入rec分区，重启进入rec，命令：  
```bash
fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
fastboot flash recovery OrangeFox-21.04.11-Unofficial-bomb.img
fastboot reboot recovery
```
温馨提示：mtk机型刷recovery有风险，如果错误的刷入未经验证的recovery可能会导致设备无法开机，无限重启，且无法进入recovery和fastboot，请先确保你有救回的办法再尝试  
请根据你手机当前运行rom的安卓版本选择recovery，使用安卓12版本rom的手机，请刷入近期的橙狐；早期版本和文件名有写a11的版本，只能在运行安卓11版本rom的手机上刷；wzsx150 twrp只支持安卓10。  
# 如何构建
下载OFRP源代码，克隆这个仓库放到相应的位置  
例如OFRP源代码根目录为~/fox_12.1，则保存为~/fox_12.1/device/xiaomi/bomb/:  
```bash
cd ~/fox_12.1
mkdir -p device/xiaomi
cd device/xiaomi
git clone https://github.com/ymdzq/OFRP-device_xiaomi_bomb.git bomb
```
打开源代码根目录运行:  
```bash
. build/envsetup.sh && lunch twrp_bomb-eng && mka recoveryimage
```
