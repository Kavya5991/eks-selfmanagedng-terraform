variable "asg_security_group_id" {
  type    = list(string)
}
variable "launch_template_name" {
  type    = string
  default = "awseks-launch-template"
}

variable "key_name" {
  description = "Name for the AWS key pair"
}

variable "rsa_key_algorithm" {
  description = "Algorithm to use for RSA key generation"
  default     = "RSA"
}

variable "rsa_key_bits" {
  description = "Number of bits for RSA key generation"
  default     = 4096
}
variable "launch_template_ec2_name" {
  type    = string
  default = "awseks-asg-ec2"
}
variable "resource_type" {
  type    = string
  default = "instance"
}



variable "associate_public_ip_address"{
 description = "Set to true to enable public ip address"
  default     = true
}
variable "instance_type" {
  description = "The type of EC2 Instances to run"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  type        = string
  description = "The AMI ID for instances in ASG"
  default     = "ami-0d7a109bf30624c99"
}
variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "The desired number of EC2 Instances in the ASG"
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "The ID of the VPC to associate with sg "
  type        = string
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "The list of public subnet IDs to launch the EC2 instances in ASG"
}

variable "eks_self_managed_node_group_instance_profile_arn" {
  description = "ARN of the IAM role for the self-managed node group in Amazon EKS"
}
