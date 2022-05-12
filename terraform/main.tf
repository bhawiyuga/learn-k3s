# Definisikan provider aws
provider "aws"{
   region = "ap-southeast-1"
   shared_credentials_files = ["~/.aws/credentials"]
}

# Konfigurasi vpc
resource "aws_vpc" "main" {
  cidr_block = "192.168.56.0/24"
}

# Konfigurasi security group
resource "aws_security_group" "sg_webserver" {
  name        = "sg_webserver"
  description = "Security group untuk webserver"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "http traffic allowed"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http traffic allowed"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "k3s traffic allowed"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "k3s traffic allowed"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh traffic allowed"
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
    Name = "webserver"
  }
}

# Konfigurasi subnet
resource "aws_subnet" "public_sub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "192.168.56.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "My IGW"
  }
}

# Route table public
resource "aws_route_table" "pub_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "Route table untuk public"
  }
}

# Asosiasikan route table ke subnet
resource "aws_route_table_association" "assoc_pub" {
  subnet_id      = aws_subnet.public_sub.id
  route_table_id = aws_route_table.pub_route_table.id
}

resource "aws_instance" "master" { 
    ami = "ami-0750a20e9959e44ff" 
    instance_type = "t2.small"
    subnet_id = aws_subnet.public_sub.id
    private_ip = "192.168.56.10"
    key_name = "bhawiyuga-m1-mac"
    vpc_security_group_ids = [ 
        aws_security_group.sg_webserver.id 
    ]

    tags = {
        Name = "Master node"
    }
}

resource "aws_instance" "worker" { 
    count = 1
    ami = "ami-0750a20e9959e44ff" 
    instance_type = "t2.small"
    subnet_id = aws_subnet.public_sub.id
    key_name = "bhawiyuga-m1-mac"
    private_ip = "192.168.56.11"
    vpc_security_group_ids = [ 
        aws_security_group.sg_webserver.id 
    ]

    tags = {
        Name = "Worker node"
    }
}