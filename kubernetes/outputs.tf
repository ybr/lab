output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.kubernetes.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.kubernetes.public_dns
}