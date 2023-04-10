# Create a VPC
resource "aws_vpc" "alt_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "Alt VPC"
  }                 
}

# Create a Subnet for AZ1
resource "aws_subnet" "web1" {
  vpc_id = aws_vpc.alt_vpc.id
  cidr_block = var.web1_cidr_block
  availability_zone = var.azs[0]
  tags = {
    "Name" = "web1-subnet"
  }
}

# Create a Subnet for AZ2
resource "aws_subnet" "web2" {
  vpc_id = aws_vpc.alt_vpc.id
  cidr_block = var.web2_cidr_block
  availability_zone = var.azs[1]
  tags = {
    "Name" = "web2-subnet"
  }
}

# Create a Subnet for AZ3
resource "aws_subnet" "web3" {
  vpc_id = aws_vpc.alt_vpc.id
  cidr_block = var.web3_cidr_block
  availability_zone = var.azs[2]
  tags = {
    "Name" = "web3-subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "alt_igw" {
  vpc_id = aws_vpc.alt_vpc.id
  tags = {
    "Name" = "Alt IGW"
  }
}

# Create a Default Route Table
resource "aws_default_route_table" "alt_vpc_default_rt" {
  default_route_table_id = aws_vpc.alt_vpc.default_route_table_id
  
  route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.alt_igw.id
  }
  tags = {
    "Name" = "Alt VPC default RT"
  }
}

# Configure the default Security Group
resource "aws_default_security_group" "alt_vpc_default_sg" {
  vpc_id = aws_vpc.alt_vpc.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = iport
    content {
      from_port = iport.value
      to_port = iport.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "Alt VPC Default Security Group"
  }
}

# Create a new Security Group
resource "aws_security_group" "allow_http" {
  name        = "allow_http_access"
  description = "Allow inbound http traffic"
  vpc_id      = aws_vpc.alt_vpc.id

  ingress {
    description      = "traffic from web"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Alt sg"
  }
}
