output "instance_arn" {
  description = "name of the instance"
  value = aws_instance.my_first_resource.arn
}

output "ami_id" {
  description = "AMI of instance"
  value = aws_instance.my_first_resource.ami
}
output "public_ip_of_instance" {
  value = aws_instance.my_first_resource.public_ip
}

output "security_group_id" {
  value = aws_security_group.my_first_sg.id
}
output "availability_zone" {
  value = aws_instance.my_first_resource.availability_zone
}
output "key_used" {
  value = aws_instance.my_first_resource.key_name
}
output "instance_id" {
  value = aws_instance.my_first_resource.id
}
output "host_id_for_instance" {
  value = aws_instance.my_first_resource.host_id
}