output "public_ip" {
  value       = try(aws_eip.main[0].public_ip,aws_instance.main.public_ip)
  description = "Instance EIP"
}

output "private_ip" {
  value       = aws_instance.main.private_ip
  description = "Instance private IP"
}

output "instance_id" {
  value       = aws_instance.main.id
  description = "Instance Id"
}