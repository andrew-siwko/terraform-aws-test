# This allows us to pull information out of the Terraform state.
# It is printed at the end of plan or apply but can be extracted with terraform output.
output "asiwko-vm-id-01" {
  value = aws_instance.test_virtual_machine_01.*
}
output "asiwko-vm-id-02" {
  value = aws_instance.test_virtual_machine_02.*
}

output "asiwko-vm-id-03" {
  value = aws_instance.test_virtual_machine_02.*
}

output "asiwko-vm-id-04" {
  value = aws_instance.test_virtual_machine_02.*
}

output "asiwko-vm-public-ip_01" {
  value = aws_instance.test_virtual_machine_01.public_ip
}
output "asiwko-vm-public-ip_02" {
  value = aws_instance.test_virtual_machine_02.public_ip
}

output "asiwko-vm-public-ip_03" {
  value = aws_instance.test_virtual_machine_03.public_ip
}
output "asiwko-vm-public-ip_04" {
  value = aws_instance.test_virtual_machine_04.public_ip
}

