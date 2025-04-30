
output "instance_id" {
  value = aws_instance.jumpbox.id
}

output "public_ip" {
  value = aws_instance.jumpbox.public_ip
}