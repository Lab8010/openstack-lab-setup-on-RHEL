#!/bin/bash
set -e

# ネットワーク設定ファイル読み込み
CONFIG_FILE="$(dirname $0)/../config/network-config.env"
if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
else
  echo "設定ファイル $CONFIG_FILE が見つかりません"
  exit 1
fi

# ホスト名設定
hostnamectl set-hostname $HOSTNAME

echo "$IPADDR $HOSTNAME ${HOSTNAME%%.*}" >> /etc/hosts

# IP固定化
nmcli con mod "System eth0" ipv4.addresses $IPADDR/24
nmcli con mod "System eth0" ipv4.gateway $GATEWAY
nmcli con mod "System eth0" ipv4.dns $DNS
nmcli con mod "System eth0" ipv4.method manual
nmcli con up "System eth0"

echo "ネットワーク設定を適用しました"