variable "region" {
  description = "Please enter AWS Region to deploy Server"
  type = string
  default = "eu-central-1"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
  type        = string
}

variable "common_tags"{
  description = "Common Tags to apply to all resources"
  type = map
  default = {
    Owner = "Sergey Brekunov"
    label = "BH"
  }
}
