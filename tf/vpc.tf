# VPC
resource "aws_vpc" "boxing_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags                 = { Name = "terraform-boxing-vpc" }
}

# Subnet
resource "aws_subnet" "boxing_public_1a_sn" {
  vpc_id            = aws_vpc.boxing_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.az_a

  tags = { Name = "terraform-boxing-public-1a-sn" }
}

# Internet Gateway
resource "aws_internet_gateway" "boxing_igw" {
  vpc_id = aws_vpc.boxing_vpc.id
  tags   = { Name = "terraform-boxing-igw" }
}

# Route table
resource "aws_route_table" "boxing_public_rt" {
  vpc_id = aws_vpc.boxing_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.boxing_igw.id
  }
  tags = { Name = "terraform-boxing-public-rt" }
}

# SubnetとRoute tableの関連付け
resource "aws_route_table_association" "boxing_public_rt_associate" {
  subnet_id      = aws_subnet.boxing_public_1a_sn.id
  route_table_id = aws_route_table.boxing_public_rt.id
}

# Security Group
## 準備
data "http" "ifconfig" {
  url = "http://ipv4.icanhazip.com/"
}

variable "allowed_cidr" {
  default = null
}

locals {
  myip         = chomp(data.http.ifconfig.body)
  allowed_cidr = (var.allowed_cidr == null) ? "${local.myip}/32" : var.allowed_cidr
}

## 作成
### Security Group
resource "aws_security_group" "boxing_ec2_sg" {
  name        = "terraform-boxing-ec2-sg"
  description = "For EC2 Linux"
  vpc_id      = aws_vpc.boxing_vpc.id
  tags        = { Name = "terraform-boxing-ec2-sg" }



  ### インバウンドルール
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.allowed_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ### アウトバウンドルール
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
