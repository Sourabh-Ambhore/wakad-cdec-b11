variable "ami_id" {
  type = string
  default = "ami-0f9de6e2d2f067fca"
  description = "id of the AMI"
}

variable "machine_type" {
  type = string
  default = "t2.micro"
}

variable "key" {
  type = string
  default = "terraform"
}

variable "subnet_id_for_me" {
  type    = list(string)
  default = ["us-east-1a","us-east-1b","us-east-1c"]
}

variable "subnet" {
  type = string
  default = "subnet-0d4e74d8a7fae6fd4"
}

variable "public_ip" {
  type = bool
  default = true
}

variable "root_vol_size" {
  type = number
  default = 10
}

variable "instance_name" {
  type = string
  default = "tf-instance"
}