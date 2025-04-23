resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "atlantis" {
  key_name = var.key_name
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "local_file" "ssh_private_key" {
  content  = tls_private_key.ec2_key.private_key_pem
  filename = "${path.module}/atlantis.pem"
  file_permission = "0600"
}