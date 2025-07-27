### scripts/05_devstack-install.sh
#!/bin/bash
set -e

# 設定
DEVSTACK_USER=stack
DEVSTACK_DIR=/opt/devstack
LOCAL_CONF_PATH=$DEVSTACK_DIR/local.conf
LOG_PATH=/var/log/stack-install.log

# stackユーザー作成（存在しない場合）
if ! id "$DEVSTACK_USER" &>/dev/null; then
  useradd -m "$DEVSTACK_USER"
  echo "$DEVSTACK_USER ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$DEVSTACK_USER"
fi

# /opt/devstack を stack に所有させる
mkdir -p "$DEVSTACK_DIR"
chown -R $DEVSTACK_USER:$DEVSTACK_USER "$DEVSTACK_DIR"

# DevStackをクローン（stackユーザーの権限で）
su - "$DEVSTACK_USER" -c "git clone https://opendev.org/openstack/devstack.git $DEVSTACK_DIR"

# local.conf 作成（stackユーザーで）
su - "$DEVSTACK_USER" -c "cat <<EOF > $LOCAL_CONF_PATH
[[local|localrc]]
ADMIN_PASSWORD=secret
DATABASE_PASSWORD=secret
RABBIT_PASSWORD=secret
SERVICE_PASSWORD=secret
ENABLE_VOLUME=True
VOLUME_BACKING_FILE_SIZE=100G
EOF"

# stack.sh 実行（ログも出力）
su - "$DEVSTACK_USER" -c "cd $DEVSTACK_DIR && ./stack.sh | tee $LOG_PATH"

echo "DevStack のインストールが完了しました（ログ: $LOG_PATH）"