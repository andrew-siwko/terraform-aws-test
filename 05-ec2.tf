# This key will be added to the authorized keys for the ec2-user account
# which will allow ssh key login to the instance
# note that changing this key after creating the instance
# has no effect despite terraform suggestion that it does.
# the key pair may be replaced but aws doe snot update the instance.
resource "aws_key_pair" "ssh_authorized_key" {
  key_name   = "authorized-key"
  public_key = file("/container_shared/ansible/ansible_rsa.pub")
}

# This block defines the EC2 instance.  The AMI refers to the image to use as selected above.
# This was tested on a free account.  Only certain insnances are permitted on a free account.
# I searched for these with the AWS cli and found t3.micro is allowed.
# RHEL ran out of memory runnung ansible on this so I updated to m7i-flex.large
# The key pulls in the key_pair above for ssh login.
# The subnet connects the instance to the network we defined.  If we allow the default vpc
# there is a danger that Terraform will try to delete the default VPC and fail after timing out.
resource "aws_instance" "virtual_machine_01" {
  ami           = "ami-0d40a6bf9d3bfc868"
  instance_type = var.instance_type

  key_name = aws_key_pair.ssh_authorized_key.key_name

  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "asiwko-vm-01"
  }
  
  vpc_security_group_ids = [aws_security_group.public_access.id]
  associate_public_ip_address = true
}

