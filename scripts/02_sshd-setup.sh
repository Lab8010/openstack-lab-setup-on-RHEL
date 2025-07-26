#!/bin/bash
set -e

# sshdの有効化
systemctl enable --now sshd

echo "sshd を有効化しました"