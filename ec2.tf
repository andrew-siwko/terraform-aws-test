data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name="name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
  }

resource "aws_network_interface" "test_network_interface" {
  subnet_id   = aws_subnet.public_subnet.id
  private_ips = ["192.168.52.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "test_virtual_machine" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags = {
    Name = "asiwko-vm-01"
  }
  primary_network_interface {
    network_interface_id = aws_network_interface.test_network_interface.id
  }
  depends_on = [aws_internet_gateway.gw]
}

