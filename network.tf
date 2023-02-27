resource "aws_vpc" "demo-vpc-2" {
  cidr_block = "10.0.0.0/16"

  tags = {
    terraform = "true"
    Name      = "${var.name}-vpc-2"
  }
}



resource "aws_subnet" "subnetA_2" {
  vpc_id                  = aws_vpc.demo-vpc-2.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    terraform = "true"
    Name      = "${var.name}_subnetA_2"
  }
}


resource "aws_subnet" "subnetB_2" {
  vpc_id                  = aws_vpc.demo-vpc-2.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    terraform = "true"
    Name      = "${var.name}_subnetB_2"
  }
}

resource "aws_internet_gateway" "demo_igw_2" {
  vpc_id = aws_vpc.demo-vpc-2.id

  tags = {
    terraform = "true"
    Name      = "${var.name}_igw_2"
  }
}

resource "aws_route_table" "demo_rt_2" {
  vpc_id = aws_vpc.demo-vpc-2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw_2.id
  }

  tags = {
    terraform = "true"
    Name      = "${var.name}-rt"
  }
}

resource "aws_route_table_association" "demo_rta1_2" {
  subnet_id      = aws_subnet.subnetA_2.id
  route_table_id = aws_route_table.demo_rt_2.id

}

resource "aws_route_table_association" "demo_rta2_2" {
  subnet_id      = aws_subnet.subnetB_2.id
  route_table_id = aws_route_table.demo_rt_2.id

}

resource "aws_security_group" "demo_sg_1_2" {
  name        = "${var.name}_sg_1_2"
  description = "Allow HTTP traffic"
  vpc_id      = aws_vpc.demo-vpc-2.id

  tags = {
    terraform = "true"
    Name      = "${var.name}_sg_1_2"
  }

  ingress {
    description = "HTTPS traffic"
    from_port   = 0
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP traffic"
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH traffic"
    from_port   = 0
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
}

