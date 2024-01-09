resource "aws_instance" "krishna" {
  ami                         = "ami-0c7217cdde317cfec"
  instance_type               = var.size
  subnet_id                   = var.subnet1
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group]
  key_name                    = "krishna"
  volume_tags                 = local.tags
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF
}

resource "aws_instance" "krishna2" {
  ami                         = "ami-0c7217cdde317cfec"
  instance_type               = var.size
  subnet_id                   = var.subnet2
  associate_public_ip_address = true
  key_name                    = "krishna"
  vpc_security_group_ids      = [var.security_group]
  volume_tags                 = local.tags
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              EOF
}