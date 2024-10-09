resource "aws_vpc" "interview" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "interview"
  }
}

resource "aws_subnet" "interview" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.interview.id
  cidr_block        = var.vpc_cidr

  tags = {
    Name = "interview"
  }
}

resource "aws_security_group" "interview" {
  name        = "interview"
  description = "Allow interview traffic"
  vpc_id      = aws_vpc.interview.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
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
    Name = "interview"
  }
}

resource "aws_internet_gateway" "interview" {
  vpc_id = aws_vpc.interview.id

  tags = {
    Name = "interview"
  }
}

resource "aws_route_table_association" "interview" {
  subnet_id      = aws_subnet.interview.id
  route_table_id = aws_route_table.interview.id
}

resource "aws_route_table" "interview" {
  vpc_id = aws_vpc.interview.id

  tags = {
    Name = "interview"
  }
}

resource "aws_route" "interview" {
  route_table_id         = aws_route_table.interview.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_route_table.interview]
  gateway_id             = aws_internet_gateway.interview.id
}
