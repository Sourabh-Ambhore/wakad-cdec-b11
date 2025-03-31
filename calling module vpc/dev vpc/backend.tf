terraform {
  backend "s3" {
    bucket = "wakad-b11-tf-code-27-03"
   
    key    = "tf-state/terraform.tfstate"
    region = "us-east-1"
  }
}
