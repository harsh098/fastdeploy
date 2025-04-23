output "atlantis_ip" {
  value = aws_instance.atlantis.public_ip
}

output "atlantis_url" {
  value = "http://${aws_instance.atlantis.public_ip}:4141"
}