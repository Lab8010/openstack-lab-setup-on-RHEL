#!/bin/bash
set -e

# 基本パッケージのインストール
PACKAGES=(
  git
  vim-enhanced
  wget
  net-tools
  bash-completion
  lvm2
  chrony
  python3.11
  python3.11-devel
)
dnf install -y "${PACKAGES[@]}"

# Python3.11 をデフォルトに設定
alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2
alternatives --set python3 /usr/bin/python3.11

# pip 再インストール（安全のため）
curl -sS https://bootstrap.pypa.io/get-pip.py | python3

# SELinux を無効化
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
setenforce 0

echo "パッケージとSELinux設定を完了しました"
