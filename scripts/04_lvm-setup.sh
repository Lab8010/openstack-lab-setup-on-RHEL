#!/bin/bash
set -e

# LVMの初期化とcinder-volumes VG作成
# ここを環境に合わせて変更(/dev/sdbや/dev/vdbなど、必要に応じてlsblkで確認ください)
DISK_DEVICE="/dev/nvme0n2"  

# 既存署名があるとエラーになることがあるので wipefs
wipefs -a "$DISK_DEVICE"

# LVMとして初期化
pvcreate "$DISK_DEVICE"
vgcreate cinder-volumes "$DISK_DEVICE"

echo "LVMバックエンド (cinder-volumes) を $DISK_DEVICE に作成しました"
