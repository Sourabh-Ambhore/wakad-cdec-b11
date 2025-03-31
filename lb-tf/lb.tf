resource "aws_security_group" "sg_for_elb" {
  name   = "sg_for_elb"
  vpc_id = "vpc-0687d8c9438c85e62"

  ingress {
    description      = "Allow http request from anywhere"
    protocol         = "tcp"
    from_port        = 80
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow https request from anywhere"
    protocol         = "tcp"
    from_port        = 443
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_security_group" "sg_for_ec2" {
  name   = "sg_for_ec2"
  vpc_id = "vpc-0687d8c9438c85e62"

  ingress {
    description     = "Allow http request from Load Balancer"
    protocol        = "tcp"
    from_port       = 80 # range of
    to_port         = 80 # port numbers
    security_groups = [aws_security_group.sg_for_elb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "alb_lb" {
  name               = "my-first-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_for_elb.id]
  subnets            = ["subnet-0d4e74d8a7fae6fd4", "subnet-02a654e48684edec8"]
  # depends_on         = [aws_internet_gateway.sh_gw]
}
resource "aws_lb_target_group" "alb_tg" {
  name     = "tf-lb-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0687d8c9438c85e62" #aws_vpc.sh_main.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

# ASG with Launch template
resource "aws_launch_template" "asg_ec2_launch_templ" {
  name_prefix   = "asg_ec2_launch_templ"
  image_id      = "ami-00c39f71452c08778" # To note: AMI is specific for each region
  instance_type = "t2.micro"
  user_data     = filebase64("user_data.sh")

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = "subnet-0d4e74d8a7fae6fd4" #, "subnet-02a654e48684edec8"
    security_groups             = [aws_security_group.sg_for_ec2.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "asg-instance" # Name for the EC2 instances
    }
  }
}

resource "aws_autoscaling_group" "tf_asg" {
  name = "asg-tf"
  # no of instances
  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  # Connect to the target group
  target_group_arns = [aws_lb_target_group.alb_tg.arn]

  # vpc_zone_identifier = "subnet-0d4e74d8a7fae6fd4" #[ # Creating EC2 instances in private subnet
  #   aws_subnet.sh_subnet_2.id
  # ]

  launch_template {
    id      = aws_launch_template.asg_ec2_launch_templ.id
    version = "$Latest"
  }
}





terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  
}