output "asiwko-vm-publicIP" {
  value = aws_instance.test.*.public_ip
}

output "asiwko-vm-id" {
  value = aws_instance.test.*.id 
}
