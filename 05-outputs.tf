# This allows us to pull information out of the Terraform state.
# It is printed at the end of plan or apply but can be extracted with terraform output.
output "asiwko-vm-id-01" {
  value = aws_instance.test_virtual_machine-01.*
}
output "asiwko-vm-id-02" {
  value = aws_instance.test_virtual_machine-02.*
}

output "asiwko-vm-public-ip-01" {
  value = aws_instance.test_virtual_machine-01.*.public_ip
}
output "asiwko-vm-public-ip-02" {
  value = aws_instance.test_virtual_machine-02.*.public_ip
}

