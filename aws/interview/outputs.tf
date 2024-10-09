output "ip" {
  description = "The AWS EC2 instance's public IP address"
  value       = aws_instance.interview.public_ip
}
