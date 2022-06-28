provider "aws" {
  region     = "ap-southeast-1"
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "vpc" {
  cidr_block = var.dev_vpc_cidr.cidr_block
  tags = {
    Name = var.dev_vpc_cidr.name
  }
}

resource "aws_subnet" "subnet-pub-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.dev_public_subnet[0].cidr_block
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = var.dev_public_subnet[0].name
  }
}

resource "aws_subnet" "subnet-pub-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.dev_public_subnet[1].cidr_block
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = var.dev_public_subnet[1].name
  }
}

resource "aws_subnet" "subnet-pub-3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.dev_public_subnet[2].cidr_block
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = var.dev_public_subnet[2].name
  }
}

resource "aws_subnet" "subnet-app-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.dev_app_subnet[0].cidr_block
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = var.dev_app_subnet[0].name
  }
}

resource "aws_subnet" "subnet-app-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.dev_app_subnet[1].cidr_block
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = var.dev_app_subnet[1].name
  }
}

resource "aws_subnet" "subnet-app-3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.dev_app_subnet[2].cidr_block
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = var.dev_app_subnet[2].name
  }
}

resource "aws_subnet" "subnet-db-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.dev_app_subnet[0].cidr_block
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = var.dev_app_subnet[0].name
  }
}

resource "aws_subnet" "subnet-db-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.dev_app_subnet[1].cidr_block
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = var.dev_app_subnet[1].name
  }
}

resource "aws_subnet" "subnet-db-3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.dev_app_subnet[2].cidr_block
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = var.dev_app_subnet[2].name
  }
}

resource "aws_internet_gateway" "igw-dev" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_eip" "eip-dev-nat" {}

resource "aws_nat_gateway" "nat-dev" {
  allocation_id = aws_eip.eip-dev-nat.id
  subnet_id     = aws_subnet.subnet-pub-1.id

  tags = {
    Name = "Dev NAT"
  }

  depends_on = [aws_internet_gateway.dev-igw]
}

resource "aws_route_table" "rt-dev-pub" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-dev.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw-dev.id
  }

  tags = {
    Name = "IGW Dev"
  }
}

resource "aws_route_table" "rt-dev-priv" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-dev.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_nat_gateway.nat-dev.id
  }

  tags = {
    Name = "NAT Dev"
  }
}

resource "aws_route_table_association" "rt-dev-pub-assoc-1" {
  subnet_id      = aws_subnet.subnet-pub-1.id
  route_table_id = aws_route_table.rt-dev-pub.id
}

resource "aws_route_table_association" "rt-dev-pub-assoc-2" {
  subnet_id      = aws_subnet.subnet-pub-2.id
  route_table_id = aws_route_table.rt-dev-pub.id
}

resource "aws_route_table_association" "rt-dev-pub-assoc-3" {
  subnet_id      = aws_subnet.subnet-pub-3.id
  route_table_id = aws_route_table.rt-dev-pub.id
}


resource "aws_route_table_association" "rt-dev-app-assoc-1" {
  subnet_id      = aws_subnet.subnet-app-1.id
  route_table_id = aws_route_table.rt-dev-priv.id
}

resource "aws_route_table_association" "rt-dev-app-assoc-2" {
  subnet_id      = aws_subnet.subnet-app-2.id
  route_table_id = aws_route_table.rt-dev-priv.id
}

resource "aws_route_table_association" "rt-dev-app-assoc-3" {
  subnet_id      = aws_subnet.subnet-app-3.id
  route_table_id = aws_route_table.rt-dev-priv.id
}


resource "aws_route_table_association" "rt-dev-db-assoc-1" {
  subnet_id      = aws_subnet.subnet-db-1.id
  route_table_id = aws_route_table.rt-dev-priv.id
}

resource "aws_route_table_association" "rt-dev-db-assoc-2" {
  subnet_id      = aws_subnet.subnet-db-2.id
  route_table_id = aws_route_table.rt-dev-priv.id
}

resource "aws_route_table_association" "rt-dev-db-assoc-3" {
  subnet_id      = aws_subnet.subnet-db-3.id
  route_table_id = aws_route_table.rt-dev-priv.id
}

resource "aws_security_group" "sg-dev-lambda" {
  name        = "Dev Lambda SG"
  description = "Dev Lambda SG"
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
    Name = "Dev Lambda SG"
  }
}
