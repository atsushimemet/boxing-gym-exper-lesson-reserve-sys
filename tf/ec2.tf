# EC2 Key pair
variable "key_name" {
  default = "terraform-boxing-keypair"
}

resource "tls_private_key" "boxing_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# ClientにKey pairを作成
locals {
  public_key_file  = "id_rsa_tf.pub"
  private_key_file = "id_rsa_tf"
}

resource "local_file" "boxing_private_key_pem" {
  filename = local.private_key_file
  content  = tls_private_key.boxing_private_key.private_key_pem
}

# 上記で作成した公開鍵をAWSのKey pairにインポート
resource "aws_key_pair" "boxing_keypair" {
  key_name   = var.key_name
  public_key = tls_private_key.boxing_private_key.public_key_openssh
}

# AMZN Linux2 の最新版amiを取得
data "aws_ssm_parameter" "amzn2_latest_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# EC2
resource "aws_instance" "boxing_ec2" {
  ami                         = data.aws_ssm_parameter.amzn2_latest_ami.value
  instance_type               = "t2.micro"
  availability_zone           = var.az_a
  vpc_security_group_ids      = [aws_security_group.boxing_ec2_sg.id]
  subnet_id                   = aws_subnet.boxing_public_1a_sn.id
  associate_public_ip_address = "true"
  key_name                    = var.key_name
  tags                        = { Name = "upd-terraform-boxing-ec2" }
  user_data                   = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y git
  EOF
}
