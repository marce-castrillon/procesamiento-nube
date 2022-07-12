resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main_vpc"
    Environment = "test"
  }
}

resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "main_subnet"
    Environment = "test"
  }
}

resource "aws_network_interface" "main_ni" {
  subnet_id   = aws_subnet.main_subnet.id
  private_ips = ["10.0.10.100"]

  tags = {
    Name = "main_network_interface"
    Environment = "test"
  }
}

resource "aws_instance" "main_instance" {
  ami           = "ami-0cff7528ff583bf9a" # us-east-1
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.main_ni.id
    device_index         = 0
  }

  tags = {
    Name = "main_instance"
    Environment = "test"
  }
}
