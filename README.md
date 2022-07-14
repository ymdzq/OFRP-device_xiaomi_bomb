# 橙 狐 (OFRP) for Redmi 10X Pro (bomb)
使用红米 10X Pro，MIUI 13（安卓12）制作，提取官方安卓12内核，适用于橙狐安卓12分支

![OFRP](https://image.ibb.co/cTMWux/logo.jpg "OFRP")

====================================================

# 目前进度
recovery基本功能都可以正常使用

不支持Data解密，需要格式化Data分区后才能正常读写（由于官方miui有强制加密，建议使用官改）

暂未上传安卓12解密相关blob，因为还是无法完成解密，解密程序运行时beanpodkeymaster输出大意是获取的key版本号v3不等于v1，不符合预期而失败

使用红米10X Pro制作，理论上支持红米10X 5G，等一个勇士来测试

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
