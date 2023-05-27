# boxing-gym-exper-lesson-reserve-sys
ボクシングジム体験レッスン予約システムレポジトリ

# Dockerメモ
- イメージの作成
  - `docker build -t django .`
- コンテナの作成
  - `docker run -itd  -p 8000:8000 --name container django`
- コンテナの終了
  - `docker stop container`
- 起動中のコンテナの削除
  - `docker container rm -f container`
- 起動中のコンテナを確認
  - `docker ps`
- 起動中・停止中のコンテナを確認
  - `docker ps`
- コンテナに入る
  - `docker exec -it container bash`
- Dockerで実行中または停止中のすべてのコンテナを一括で削除
  - `docker rm $(docker ps -aq)`
- Dockerイメージを一括で削除
  - `docker image prune -a`

# ALLOWED_HOSTに0.0.0.0が記載されているにもかかわらず、HTTPリクエストを実行して、Disallowedhostエラーが出る。
djangoイメージ作成時点では、ALLOWED_HOSTに0.0.0.0が含まれていなかった

# 本番環境構築メモ
- ローカル開発環境からawsリソースを作成する。
  - `cd ~/Repository/boxing-gym-exper-lesson-reserve-sys/tf && ./terraform_deploy.sh true`
- ipアドレスを下記に書き込む
  - ローカル開発環境の.ssh/configのHostnameに書き込む
  - ローカル開発環境のdjangoのALLOWED_HOSTに書き込む
- リモートレポジトリを最新の状態にする
- 秘密鍵の権限変更
  - `chmod 400 id_rsa_tf`
- Dockerfileをローカル開発環境から本番環境にコピーする
  - `scp ~/Repository/boxing-gym-exper-lesson-reserve-sys/Dockerfile tf-boxing-ssh:/home/ec2-user/`
- local_settings.pyをローカル開発環境から本番環境にコピーする
  - `scp ~/Repository/boxing-gym-exper-lesson-reserve-sys/config/local_settings.py tf-boxing-ssh:/home/ec2-user/`
- 本番環境にconfigディレクトリの作成&local_settings.pyの移動
  - `mkdir config && mv local_settings.py config/`
- 本番環境でgithub疎通用のsshキーの作成
  - `ssh-keygen -t rsa`
- 本番環境で公開鍵・秘密鍵を所定の位置に配置
  - `mv ~/.ssh/id_rsa* .`
- 公開鍵の登録
- イメージの作成
- コンテナの作成
