#!/bin/bash

# .envファイルのパスを指定
ENV_FILE=".env"

# .envファイルを読み込む
if [[ -f "$ENV_FILE" ]]; then
  export $(cat "$ENV_FILE" | grep -v '#' | xargs)
else
  echo "$ENV_FILE ファイルが存在しません。"
  exit 1
fi

# Terraformのコマンドを実行する（例: terraform plan）
terraform init
terraform validate
terraform plan

# 第一引数が true の場合は terraform apply を実行する
if [[ $1 == "true" ]]; then
  # Terraformのコマンドを実行する（例: terraform apply）
  terraform apply
fi
