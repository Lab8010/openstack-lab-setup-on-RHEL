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

# 接続名（connection name）をインターフェース名から自動取得
CON_NAME=$(nmcli -g NAME,DEVICE con show | grep ":$INTERFACE_NAME" | cut -d: -f1)

if [ -z "$CON_NAME" ]; then
  echo "Error: '$INTERFACE_NAME' に対応する NetworkManager の接続名が見つかりません"
  nmcli con show
  exit 1
fi

# ホスト名設定
hostnamectl set-hostname "$HOSTNAME"
echo "$IPADDR $HOSTNAME ${HOSTNAME%%.*}" >> /etc/hosts

# IP固定化
nmcli con mod "$CON_NAME" ipv4.addresses "$IPADDR/24"
nmcli con mod "$CON_NAME" ipv4.gateway "$GATEWAY"
nmcli con mod "$CON_NAME" ipv4.dns "$DNS"
nmcli con mod "$CON_NAME" ipv4.method manual
nmcli con mod "$CON_NAME" connection.autoconnect yes

# ネットワーク再起動
nmcli con down "$CON_NAME" || true
nmcli con up "$CON_NAME"

echo "ネットワーク設定を適用しました"
