#!/bin/bash
set -e

# SELinuxをpermissiveに変更
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config

# Firewalldの停止（学習用）
systemctl disable --now firewalld

# 必要パッケージの導入
dnf install -y git vim wget net-tools bash-completion lvm2 chrony

# chrony起動と設定
systemctl enable --now chronyd
sed -i '/^server /d' /etc/chrony.conf
echo 'server ntp.nict.jp iburst' >> /etc/chrony.conf
systemctl restart chronyd

echo "パッケージとSELinux設定を完了しました"