# This allows us to pull information out of the Terraform state.
# It is printed at the end of plan or apply but can be extracted with terraform output.
output "asiwko-vm-public-ip_01" {
  value = aws_instance.test_virtual_machine_01.public_ip
}
