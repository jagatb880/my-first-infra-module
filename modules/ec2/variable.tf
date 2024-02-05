variable "ami" {
  default = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "ubuntu-key"
}

variable "environment_name" {
  type    = string
  default = "default"
}

variable "availability_zone" {
  default = "us-east-1a"
}

