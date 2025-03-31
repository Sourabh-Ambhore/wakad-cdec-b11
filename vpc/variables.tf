variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "vpc_name" {
  type    = string
  default = "tf-vpc"
}
variable "sub_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
variable "subnet_name" {
  type    = list(string)
  default = ["public_subnet", "private_subnet"]
}
variable "igw_name" {
  type    = string
  default = "tf-igw"
}