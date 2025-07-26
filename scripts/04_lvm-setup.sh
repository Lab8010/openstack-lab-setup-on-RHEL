#!/bin/bash
set -e

# ディスクが /dev/sdb の前提（適宜変更）
DISK=/dev/sdb
VG=cinder-volumes

# LVM設定
pvcreate $DISK
vgcreate $VG $DISK

echo "LVM（$VG） を作成しました"