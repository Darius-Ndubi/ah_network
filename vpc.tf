# VPC
resource "aws_vpc" "ahvpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "ah-vpc"
  }
}

# The internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.ahvpc.id}"

  tags {
    Name = "ah-igw"
  }
}

# The public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.ahvpc.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "us-east-1a"

  tags {
    Name = "Frontend Public Subnet"
  }
}

# The private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = "${aws_vpc.ahvpc.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "us-east-1b"

  tags {
    Name = "Backend Private Subnet"
  }
}


# The route table
resource "aws_route_table" "ahf-public-rt" {
  vpc_id = "${aws_vpc.ahvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Ah Subnet RT"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "ahf-public-rt" {
  subnet_id = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.ahf-public-rt.id}"
}

# The security group for public subnet
resource "aws_security_group" "sgahf" {
  name = "sg_ahf"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id="${aws_vpc.ahvpc.id}"

  tags {
    Name = "ahf SG"
  }
}


# The security group for private subnet  [Backend]
resource "aws_security_group" "sgahb"{
  name = "sg_ahb"
  description = "Allow traffic from public subnet"

  ingress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = ["${var.public_subnet_cidr}"]
  }

  ingress {
        from_port = 5432
        to_port = 5432
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.ahvpc.id}"

  tags {
    Name = "ahb server SG"
  }
}
