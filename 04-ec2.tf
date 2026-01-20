# This selects the image to use to build the instance.
# Here we filter for the most recent amazon linux 2 image.
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name="name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
  }

# This key will be added to the authorized keys for the ec2-user account
# which will allow ssh key login to the instance
resource "aws_key_pair" "ssh_authorized_key" {
  key_name   = "user-key"
  public_key = file("/container_shared/ansible/id_rsa.desktop.pub")
}

# This block defines the EC2 instance.  The AMI refers to the image to use as selected above.
# This was tested on a free account.  Only certain insnances are permitted on a free account.
# I searched for these with the aws cli anf found t3.micro is allowed.
# The key pulls in the key_pair above for ssh login.
# The subnet connects the instance to the network we defined.  If we allow the default vpc
# there is a danger that Terraform will try to delete the default VPC and fail after timing out.
resource "aws_instance" "test_virtual_machine_01" {
  ami           = "ami-0d40a6bf9d3bfc868"
  # ami           = data.aws_ami.amazon_linux.id
  # instance_type = "t3.micro"
  instance_type = "m7i-flex.large"

  key_name = aws_key_pair.ssh_authorized_key.key_name

  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "asiwko-vm-01"
  }
  
  vpc_security_group_ids = [aws_security_group.public_access.id]
  associate_public_ip_address = true
}

# The second one is always easier!
resource "aws_instance" "test_virtual_machine_02" {
  ami           = "ami-0d40a6bf9d3bfc868"
  # ami           = data.aws_ami.amazon_linux.id
  # instance_type = "t3.micro"
    instance_type = "m7i-flex.large"
  key_name = aws_key_pair.ssh_authorized_key.key_name

  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "asiwko-vm-02"
  }
  
  vpc_security_group_ids = [aws_security_group.public_access.id]
  associate_public_ip_address = true
}

# Lets build two hard coded RHEL 9.7 images
resource "aws_instance" "test_virtual_machine_03" {
  ami           = "ami-0d40a6bf9d3bfc868"
  instance_type = "m7i-flex.large"
  key_name = aws_key_pair.ssh_authorized_key.key_name

  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "asiwko-vm-03"
  }
  
  vpc_security_group_ids = [aws_security_group.public_access.id]
  associate_public_ip_address = true
}

resource "aws_instance" "test_virtual_machine_04" {
  ami           = "ami-0d40a6bf9d3bfc868"
  instance_type = "m7i-flex.large"
  key_name = aws_key_pair.ssh_authorized_key.key_name

  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "asiwko-vm-04"
  }
  
  vpc_security_group_ids = [aws_security_group.public_access.id]
  associate_public_ip_address = true
}