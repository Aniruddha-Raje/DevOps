variable "aws_region" {
}

variable "vpc_cidr" {
}

variable "pub_subnet" {
}

variable "app_subnet" {
}

variable "db_subnet" {
}

provider "aws" {
  region     = var.aws_region
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr.cidr_block
  tags = {
    Name = var.vpc_cidr.name
  }
}

resource "aws_subnet" "subnet-pub-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pub_subnet[0].cidr_block
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = var.pub_subnet[0].name
  }
}

resource "aws_subnet" "subnet-pub-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pub_subnet[1].cidr_block
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = var.pub_subnet[1].name
  }
}

resource "aws_subnet" "subnet-pub-3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pub_subnet[2].cidr_block
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = var.pub_subnet[2].name
  }
}

resource "aws_subnet" "subnet-app-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.app_subnet[0].cidr_block
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = var.app_subnet[0].name
  }
}

resource "aws_subnet" "subnet-app-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.app_subnet[1].cidr_block
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = var.app_subnet[1].name
  }
}

resource "aws_subnet" "subnet-app-3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.app_subnet[2].cidr_block
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = var.app_subnet[2].name
  }
}

resource "aws_subnet" "subnet-db-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.db_subnet[0].cidr_block
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = var.db_subnet[0].name
  }
}

resource "aws_subnet" "subnet-db-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.db_subnet[1].cidr_block
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = var.db_subnet[1].name
  }
}

resource "aws_subnet" "subnet-db-3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.db_subnet[2].cidr_block
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = var.db_subnet[2].name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_eip" "eip-nat" {}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip-nat.id
  subnet_id     = aws_subnet.subnet-pub-1.id

  tags = {
    Name = "NAT"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "rt-pub" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "RT Pub"
  }
}

resource "aws_route_table" "rt-priv" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  # route {
  #   ipv6_cidr_block = "::/0"
  #   gateway_id      = aws_nat_gateway.nat.id
  # }

  tags = {
    Name = "RT Priv"
  }
}

resource "aws_route_table_association" "rt-pub-assoc-1" {
  subnet_id      = aws_subnet.subnet-pub-1.id
  route_table_id = aws_route_table.rt-pub.id
}

resource "aws_route_table_association" "rt-pub-assoc-2" {
  subnet_id      = aws_subnet.subnet-pub-2.id
  route_table_id = aws_route_table.rt-pub.id
}

resource "aws_route_table_association" "rt-pub-assoc-3" {
  subnet_id      = aws_subnet.subnet-pub-3.id
  route_table_id = aws_route_table.rt-pub.id
}

resource "aws_route_table_association" "rt-app-assoc-1" {
  subnet_id      = aws_subnet.subnet-app-1.id
  route_table_id = aws_route_table.rt-priv.id
}

resource "aws_route_table_association" "rt-app-assoc-2" {
  subnet_id      = aws_subnet.subnet-app-2.id
  route_table_id = aws_route_table.rt-priv.id
}

resource "aws_route_table_association" "rt-app-assoc-3" {
  subnet_id      = aws_subnet.subnet-app-3.id
  route_table_id = aws_route_table.rt-priv.id
}

resource "aws_route_table_association" "rt-db-assoc-1" {
  subnet_id      = aws_subnet.subnet-db-1.id
  route_table_id = aws_route_table.rt-priv.id
}

resource "aws_route_table_association" "rt-db-assoc-2" {
  subnet_id      = aws_subnet.subnet-db-2.id
  route_table_id = aws_route_table.rt-priv.id
}

resource "aws_route_table_association" "rt-db-assoc-3" {
  subnet_id      = aws_subnet.subnet-db-3.id
  route_table_id = aws_route_table.rt-priv.id
}

resource "aws_security_group" "sg-lambda" {
  name        = "Lambda SG"
  description = "Lambda SG"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Lambda SG"
  }
}

output "aws_vpc_id" {
  value = aws_vpc.vpc.id
}

output "aws_subnet_pub_1_id" {
  value = aws_subnet.subnet-pub-1.id
}

output "aws_subnet_pub_2_id" {
  value = aws_subnet.subnet-pub-2.id
}

output "aws_subnet_pub_3_id" {
  value = aws_subnet.subnet-pub-3.id
}

output "aws_subnet_app_1_id" {
  value = aws_subnet.subnet-app-1.id
}

output "aws_subnet_app_2_id" {
  value = aws_subnet.subnet-app-2.id
}

output "aws_subnet_app_3_id" {
  value = aws_subnet.subnet-app-3.id
}

output "aws_subnet_db_1_id" {
  value = aws_subnet.subnet-db-1.id
}

output "aws_subnet_db_2_id" {
  value = aws_subnet.subnet-db-2.id
}

output "aws_subnet_db_3_id" {
  value = aws_subnet.subnet-db-3.id
}

output "aws_internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "aws_nat_eip_id" {
  value = aws_eip.eip-nat.id
}

output "aws_nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}

output "aws_route_table_pub_id" {
  value = aws_route_table.rt-pub.id
}

output "aws_route_table_priv_id" {
  value = aws_route_table.rt-priv.id
}

output "aws_route_table_association_pub_1_id" {
  value = aws_route_table_association.rt-pub-assoc-1.id
}

output "aws_route_table_association_pub_2_id" {
  value = aws_route_table_association.rt-pub-assoc-2.id
}

output "aws_route_table_association_pub_3_id" {
  value = aws_route_table_association.rt-pub-assoc-3.id
}

output "aws_route_table_association_app_1_id" {
  value = aws_route_table_association.rt-app-assoc-1.id
}

output "aws_route_table_association_app_2_id" {
  value = aws_route_table_association.rt-app-assoc-2.id
}

output "aws_route_table_association_app_3_id" {
  value = aws_route_table_association.rt-app-assoc-3.id
}

output "aws_route_table_association_db_1_id" {
  value = aws_route_table_association.rt-db-assoc-1.id
}

output "aws_route_table_association_db_2_id" {
  value = aws_route_table_association.rt-db-assoc-2.id
}

output "aws_route_table_association_db_3_id" {
  value = aws_route_table_association.rt-db-assoc-3.id
}

output "aws_security_group_lambda" {
  value = aws_security_group.sg-lambda.id
}
