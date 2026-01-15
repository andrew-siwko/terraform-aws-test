# This allows us to pull information out of the Terraform state.
# It is printed at the end of plan or apply but can be extracted with terraform output.
output "asiwko-vm-id" {
  value = aws_instance.test_virtual_machine.*
}

output "asiwko-vm-public-ip" {
  value = aws_instance.test_virtual_machine.*.public_ip
}

