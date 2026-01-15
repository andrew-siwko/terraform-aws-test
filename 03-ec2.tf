data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name="name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
  }

resource "aws_key_pair" "andrew_key" {
  key_name   = "user-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4TVQryVnLaUPDIcaV7iGRgQM0ImcmqWZmDs+oVRHS2+1kfz4ZSRlEOFa70ywhTyvTv+3Vxl8NhdsQHB8a6YEYMEChX0CtzRMRCn35qBMsEZd1BJQE8AdOniLr1z+g4KoAA0zS5g8e+PMK/MSA0Hj8xRRQB4zmhzrj22xsmVJAkznktbSIdM+Mdf+ATbFEIf+a5BAwuBuXXdn1IcpFqG5uH9nQUQ4+AuDxURLeIy+qfz6BhpqyxLThYJxRI5FtwAAaRQecKB8JEb+HRhGYtK58YoYFup0PSlFcyg+ppUPJWCSxIveK4nttLwDS74LPHH9CWJY+hxFEqHfY9+kxRY4knNJH9vGFWUVKqwg5qKz8WB8OgGj9b9O82NooEdLUVRWVr0IWDTrDMDbiEUtsufsY7X6xmh81hYzet4j3Ep2BvgnQXJ1/xV2C/zZ5LeL/OhtfS5eE2JhoG/CgHr4S3G4+jsegmjTLDCEwVybf5eFEsv9Qdj1uLgdotIp10yFvhn0= asiwk@DESKTOP-DADDY"
}

# resource "aws_default_vpc" "default" {}

resource "aws_security_group" "public_access" {
  name        = "allow_ssh_http_ping"
  description = "Allow Ping, SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.custom_vpc.id
  # vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP Ping"
    from_port   = 8        # ICMP Type
    to_port     = 0        # ICMP Code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "test_virtual_machine" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  key_name = aws_key_pair.andrew_key.key_name

  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "asiwko-vm-01"
  }
  
  vpc_security_group_ids = [aws_security_group.public_access.id]
  associate_public_ip_address = true
}

