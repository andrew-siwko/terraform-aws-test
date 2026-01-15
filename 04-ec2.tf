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
resource "aws_key_pair" "ssh_user_key" {
  key_name   = "user-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4TVQryVnLaUPDIcaV7iGRgQM0ImcmqWZmDs+oVRHS2+1kfz4ZSRlEOFa70ywhTyvTv+3Vxl8NhdsQHB8a6YEYMEChX0CtzRMRCn35qBMsEZd1BJQE8AdOniLr1z+g4KoAA0zS5g8e+PMK/MSA0Hj8xRRQB4zmhzrj22xsmVJAkznktbSIdM+Mdf+ATbFEIf+a5BAwuBuXXdn1IcpFqG5uH9nQUQ4+AuDxURLeIy+qfz6BhpqyxLThYJxRI5FtwAAaRQecKB8JEb+HRhGYtK58YoYFup0PSlFcyg+ppUPJWCSxIveK4nttLwDS74LPHH9CWJY+hxFEqHfY9+kxRY4knNJH9vGFWUVKqwg5qKz8WB8OgGj9b9O82NooEdLUVRWVr0IWDTrDMDbiEUtsufsY7X6xmh81hYzet4j3Ep2BvgnQXJ1/xV2C/zZ5LeL/OhtfS5eE2JhoG/CgHr4S3G4+jsegmjTLDCEwVybf5eFEsv9Qdj1uLgdotIp10yFvhn0= asiwk@DESKTOP-DADDY"
}

# This block defines the EC2 instance.  The AMI refers to the image to use as selected above.
# This was tested on a free account.  Only certain insnances are permitted on a free account.
# I searched for these with the aws cli anf found t3.micro is allowed.
# The key pulls in the key_pair above for ssh login.
# The subnet connects the instance to the network we defined.  If we allow the default vpc
# there is a danger that Terraform will try to delete the default VPC and fail after timing out.
resource "aws_instance" "test_virtual_machine" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  key_name = aws_key_pair.ssh_user_key.key_name

  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "asiwko-vm-01"
  }
  
  vpc_security_group_ids = [aws_security_group.public_access.id]
  associate_public_ip_address = true
}
