# プロバイダ設定
provider "aws" {
  region = "ap-northeast-1"
}

# 自分のパブリックIP取得用
# この記述によって、myPCからのSSHアクセスが可能になる。
# ここに記載されているmyPCのIPのみインバウンドを許可する。
provider "http" {

}
