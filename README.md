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
