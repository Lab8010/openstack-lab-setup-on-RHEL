#!/bin/bash
set -e

# すべてのセットアップスクリプトを実行
SCRIPT_DIR=$(dirname $(realpath $0))

bash "$SCRIPT_DIR/01_network-setup.sh"
bash "$SCRIPT_DIR/02_sshd-setup.sh"
bash "$SCRIPT_DIR/03_packages-and-selinux.sh"
bash "$SCRIPT_DIR/04_lvm-setup.sh"
bash "$SCRIPT_DIR/05_devstack-install.sh"

echo "全セットアップが完了しました"