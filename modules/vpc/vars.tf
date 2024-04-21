
variable "vpc_cidr" {
  description = "VPC cidr block"
  type        = string
  default     = "172.16.0.0/16"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_support" {
   description = " A boolean flag to enable/disable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
   description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}
variable "az_names" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets_cidr" {
  description = "Public Subnet cidr block"
  type        = list(string)
  default     = ["172.16.0.0/24", "172.16.1.0/24"]
}


variable "vpc_name" {
  type    = string
  default = "awseks-vpc"
}

variable "internet_gateway_name" {
  type    = string
  default = "awseks-internet-gateway"
}

variable "public_subnet_name" {
  type    = string
  default = "awseks-public-subnet"
}



variable "public_route_table_name" {
  type    = string
  default = "awseks-public-route-table"
}
variable "counts" {
  description = "Number of subnets to be created"
  type        = number
  default     = 2
}



