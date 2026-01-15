output "asiwko-vm-public-ip" {
  value = aws_instance.test_virtual_machine.*.public_ip
}

output "asiwko-vm-id" {
  value = aws_instance.test_virtual_machine.*.id 
}
