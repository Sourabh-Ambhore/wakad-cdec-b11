resource "aws_instance" "my_first_resource" {
  ami                         = var.ami_id
  instance_type               = var.machine_type
  key_name                    = var.key
  subnet_id                   = var.subnet
  associate_public_ip_address = var.public_ip
  security_groups             = [aws_security_group.my_first_sg.id]
  user_data = <<EOF
#!/bin/bash
echo "hello from userdata in ec2 by tf" > /home/ubuntu/userdata.sh
EOF
  root_block_device {
    volume_type = "standard"
    volume_size = var.root_vol_size
  }
  tags = {
    Name = var.instance_name
  }
}


