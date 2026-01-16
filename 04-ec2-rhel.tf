# In this second file, we're going to  use a hard coded RHEL 9.7 image
resource "aws_instance" "test_virtual_machine_03" {
  ami           = "ami-0d40a6bf9d3bfc868"
  instance_type = "m7i-flex-large"
  key_name = aws_key_pair.ssh_user_key.key_name

  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "asiwko-vm-03"
  }
  
  vpc_security_group_ids = [aws_security_group.public_access.id]
  associate_public_ip_address = true
}

resource "aws_instance" "test_virtual_machine_04" {
  ami           = "ami-0d40a6bf9d3bfc868"
  instance_type = "t3.micro"
  key_name = aws_key_pair.ssh_user_key.key_name

  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "asiwko-vm-03"
  }
  
  vpc_security_group_ids = [aws_security_group.public_access.id]
  associate_public_ip_address = true
}
