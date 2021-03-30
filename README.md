# 橙 狐 (OFRP) for Redmi 10X Pro (bomb)
使用红米 10X Pro，MIUI 12.5（安卓11）制作，提取官方安卓11内核，适用于橙狐安卓10分支

![OFRP](https://image.ibb.co/cTMWux/logo.jpg "OFRP")

====================================================

# 目前进度
能开机了

能显示中文

没有明显的显示错误

Data未解密

# 如何构建
下载OFRP源代码，克隆这个仓库放到相应的位置

例如OFRP源代码根目录为~/OrangeFox_10/fox_10.0，则保存为~/OrangeFox_10/fox_10.0/device/xiaomi/bomb/:

```bash
cd ~/OrangeFox_10/fox_10.0
mkdir -p device/xiaomi
cd device/xiaomi
git clone https://github.com/ymdzq/OFRP-device_xiaomi_bomb.git bomb
```

打开源代码根目录运行:

```bash
. build/envsetup.sh && lunch omni_bomb-eng && mka recoveryimage
```
