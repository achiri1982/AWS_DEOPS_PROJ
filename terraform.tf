provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region                  = "us-east-1"
}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "demomy-s3-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dynamo-tf-state-lock"
  }
}