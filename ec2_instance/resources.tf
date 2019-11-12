provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "prom" {
  ami                         = var.ami_id
  availability_zone           = "eu-central-1a"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = var.ssh_key_pair_name
  subnet_id                   = aws_subnet.web.id
  vpc_security_group_ids      = [aws_security_group.ssh_http_https.id]
  root_block_device {
    delete_on_termination = true
    volume_size           = 8
  }
  tags = {
    Name = "prom-01"
  }
}

output "ec2_global_ips" {
  value = [aws_instance.prom.*.public_ip]
}

output "eip_ip" {
  value = aws_eip.prom_eip.public_ip
}
