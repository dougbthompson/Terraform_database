# new vpc/subnet configuration

resource "aws_vpc" "t2" {
  cidr_block           = "172.32.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "T2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.t2.id}"

  tags {
    Name = "T2 GW"
  }
}

resource "aws_route_table" "t2_rt" {
  vpc_id = "${aws_vpc.t2.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "T2 GW"
  }
}

resource "aws_main_route_table_association" "mrt" {
  vpc_id         = "${aws_vpc.t2.id}"
  route_table_id = "${aws_route_table.t2_rt.id}"
}

resource "aws_subnet" "subnet1" {
  cidr_block              = "${cidrsubnet(aws_vpc.t2.cidr_block, 4, 1)}"
  vpc_id                  = "${aws_vpc.t2.id}"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
}
resource "aws_route_table_association" "s1rt" {
  subnet_id      = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.t2_rt.id}"
}

resource "aws_subnet" "subnet2" {
  cidr_block              = "${cidrsubnet(aws_vpc.t2.cidr_block, 4, 2)}"
  vpc_id                  = "${aws_vpc.t2.id}"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true
}
resource "aws_route_table_association" "s2rt" {
  subnet_id      = "${aws_subnet.subnet2.id}"
  route_table_id = "${aws_route_table.t2_rt.id}"
}

resource "aws_subnet" "subnet3" {
  cidr_block              = "${cidrsubnet(aws_vpc.t2.cidr_block, 4, 3)}"
  vpc_id                  = "${aws_vpc.t2.id}"
  availability_zone       = "us-east-2c"
  map_public_ip_on_launch = true
}
resource "aws_route_table_association" "s3rt" {
  subnet_id      = "${aws_subnet.subnet3.id}"
  route_table_id = "${aws_route_table.t2_rt.id}"
}

resource "aws_security_group" "t2_security" {
  vpc_id      = "${aws_vpc.t2.id}"
  name        = "DB_EC2_T2"
  description = "Allow (T2) database traffic"

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["209.232.226.99/32"]
  }

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["73.189.152.222/32"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["209.232.226.99/32"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["73.189.152.222/32"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["209.232.226.99/32"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["73.189.152.222/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["209.232.226.99/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["73.189.152.222/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["73.189.152.222/32"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
