module "vpc" {
  source               = "../../modules/network/vpc"
  vpc_name             = local.vpc_name
  environment          = local.environment
  vpc_cidr             = "10.0.0.0/16"
  private_subnet_count = 0
  public_subnet_count  = 1
  aws_region           = local.region
}

module "sg" {
  source   = "../../modules/network/sg-atlantis"
  vpc_id   = module.vpc.vpc_id
  vpc_name = module.vpc.vpc_name
  ingress_with_cidr_blocks = [
    {
      from_port   = 4141
      to_port     = 4141
      protocol    = "tcp"
      description = "Atlantis Port"
      cidr_blocks = "10.10.0.0/16"
    }
  ]
}


resource "aws_instance" "atlantis" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.small"
  subnet_id                   = module.vpc.public_subnet_ids[0]
  vpc_security_group_ids      = [module.sg.security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.atlantis_profile.name
  associate_public_ip_address = true
  key_name                    = aws_key_pair.atlantis.key_name

  user_data = <<-EOF
              #!/bin/bash
              # Install Docker
              amazon-linux-extras install docker -y
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ec2-user

              # Install Atlantis
              yum install -y wget unzip
              wget https://github.com/runatlantis/atlantis/releases/latest/download/atlantis_linux_amd64.zip
              unzip atlantis_linux_amd64.zip
              mv atlantis /usr/local/bin/
              useradd --system --home /etc/atlantis --shell /sbin/nologin atlantis
              mkdir /etc/atlantis
              chown atlantis:atlantis /etc/atlantis
              cat <<EOT >> /etc/systemd/system/atlantis.service
              [Unit]
              Description=Atlantis GitOps Tool
              After=network.target

              [Service]
              ExecStart=/usr/local/bin/atlantis server --port=4141
              User=atlantis
              Group=atlantis
              Restart=always

              [Install]
              WantedBy=multi-user.target
              EOT
              systemctl daemon-reexec
              systemctl enable atlantis
              systemctl start atlantis
              EOF

  tags = {
    Name = "Atlantis-Server"
  }
}