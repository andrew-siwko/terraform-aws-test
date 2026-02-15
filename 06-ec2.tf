# This key will be added to the authorized keys for the ec2-user account
# which will allow ssh key login to the instance
# note that changing this key after creating the instance
# has no effect despite terraform suggestion that it does.
# the key pair may be replaced but aws doe snot update the instance.
resource "aws_key_pair" "ssh_authorized_key" {
  key_name   = "authorized-key"
  public_key = file("/container_shared/ansible/ansible_rsa.pub")
}


resource "aws_instance" "virtual_machine_01" {
  ami           = local.target_ami_id
  instance_type = var.instance_type

  key_name = aws_key_pair.ssh_authorized_key.key_name

  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "asiwko-vm-01"
  }
  
  vpc_security_group_ids = [aws_security_group.public_access.id]
  associate_public_ip_address = true
}

