variable "name" {
  type    = string
  default = "demo"
}

variable "map_public_ip_on_launch" {
  default = "true"
}

variable "regions" {
  type = map(string)
  default = {
    use1 = "us-east-1"
  }
}


variable "availability_zones" {
  type = map(string)
  default = {
    usw1a = "us-west-1a"
    usw1b = "us-west-1b"
  }
}

variable "subnets" {
  type = map(string)
  default = {
    subnetA = "10.0.1.0/24"
    subnetB = "10.0.2.0/24"
  }
}

variable "environment" {
  type = map(string)
  default = {
    prod = "production"
    dev  = "development"
    uat  = "User Accetance Testing"
  }
}

variable "tags" {
  type = map(string)
  default = {
    terraform = "true"
    Name      = "Leslievpc"
  }
}

variable "instance_type" {
  type        = map(string)
  description = "Type of EC2 instance"
  default = {
    development = "t2.micro"
    production  = "t2.small"
  }
}

variable "capacity" {
  type = map(string)
  default = {
    desired = 2
    min     = 2
    max     = 4
  }
}
