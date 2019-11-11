resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "web" {
  cidr_block        = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, 4)
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.availability_zone
}

resource "aws_eip" "prom_eip" {
  vpc      = true
  instance = aws_instance.prom.id
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }
  tags = {
    Name = "main_route_table"
  }
}

resource "aws_route_table_association" "main_rt_assoc" {
  route_table_id = aws_route_table.main_route_table.id
  subnet_id      = aws_subnet.web.id
}

resource "aws_security_group" "ssh_http_https" {
  name        = "ssh_http_https"
  description = "Allow http,https,ssh inbound. Allow all outbound"
  vpc_id      = aws_vpc.main_vpc.id
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}