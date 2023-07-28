# 橙 狐 (OFRP) for Redmi 10X Pro (bomb)
使用红米 10X Pro，MIUI 13（安卓12）制作，提取官方安卓12内核，适用于橙狐安卓12分支

![OFRP](https://image.ibb.co/cTMWux/logo.jpg "OFRP")

====================================================

# 目前进度
recovery基本功能都可以正常使用

使用红米10X Pro制作，理论上支持红米10X 5G

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
