#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
# ACRH17 KERNEL 5.4
#============================================================

sed -i 's/KERNEL_PATCHVER:=4.19/KERNEL_PATCHVER:=5.4/g' target/linux/ipq40xx/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate

# Modify hostname
sed -i 's/OpenWrt/Newifi2_D1/g' package/base-files/files/bin/config_generate

# Modify the version number
sed -i 's/OpenWrt/Leopard build $(date "+%Y.%m.%d") @ OpenWrt/g' package/lean/default-settings/files/zzz-default-settings

# 删除、修改旧主题，增加新主题Modify default theme
# rm -rf package/lean/luci-theme-argon
# rm -rf openwrt/package/lean/luci-theme-netgear
# 清除旧版argon主题并拉取最新版
#pushd package/lean
# rm -rf luci-theme-argon
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 清除默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/lean/luci-theme-opentomcat

# Add kernel build user
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_USER="Leopard"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_USER=\).*@\1$"LEOPARD"@' .config

# Add kernel build domain
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_DOMAIN=\).*@\1$"GitHub Actions"@' .config

# 添加新的主题包
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
# git clone https://github.com/sypopo/luci-theme-atmaterial.git package/lean/luci-theme-atmaterial
git clone https://github.com/sypopo/luci-theme-argon-mc.git package/lean/luci-theme-argon-mc

# 取消bootstrap为默认主题
# sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# Modify default theme
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 增加ssr
# git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
git clone https://github.com/fw876/helloworld.git package/openwrt-packages/luci-app-ssr-plus