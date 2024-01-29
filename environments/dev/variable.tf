variable "region" {
  default = "us-east-1"
}

variable "environment_types" {
  type    = list(string)
  default = ["dev", "qa", "prod"]
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0c7217cdde317cfec" # Replace with your desired AMI
}

variable "key_name" {
  default = "ap-south-key" # Replace with your key pair name
}

variable "environment_name" {
}

# ... Add other variables as needed, such as RDS engine, storage size, etc.
