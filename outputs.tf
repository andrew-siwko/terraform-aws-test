output "asiwko-vm-publicIP" {
  value = aws_instance.test.*.public_ip
}

output "asiwko-vm-id" {
  value = [ for i in aws_instance.test: i.id ]
}
