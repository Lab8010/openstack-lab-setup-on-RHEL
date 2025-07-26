# OpenStack Lab Setup on RHEL

このリポジトリは、Red Hat Enterprise Linux 上で OpenStack（dev-install）を構築するための再現性あるセットアップ手順とスクリプトを提供します。

## 免責事項
本リポジトリで提供されるあらゆる情報は、あくまでもRHELをベースとした環境においてOpenStack環境構築を、学習目的で行うためのものです。
そのため、商用環境でそのままご利用を頂いたとしても、動作の保証はできません。

## 対象環境

- RHEL 8.x / 9.x（Subscription 必要）
- ベアメタルまたは仮想マシン
- eth0 が主ネットワークインタフェース

## 構成

- `scripts/`: ステップごとのセットアップスクリプト
- `config/`: ホスト名/IPなどの変数を定義
- `docs/`: 詳細な手順書
- `dev-install/`: OpenStack用設定ファイルテンプレート

## 使用手順

```bash
git clone https://github.com/Lab8010/openstack-lab-setup.git
cd openstack-lab-setup

# 変数を編集
vi config/network-config.env

# セットアップの実行
sudo bash scripts/99_all-in-one.sh
