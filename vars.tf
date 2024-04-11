
variable "vpc_cidr" {
  description = "VPC CIDR range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = "CIDR range for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "allowed_cidr" {
  description = "CIDR range for ssh"
  type        = string
  default     = "0.0.0.0/0"
}
/*variable "ingress_rules" {
  description = "A map of ingress rules for the security group"
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    http_from_internet = {
      description = "Allow ssh port accesible from anywhere"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
    http_from_internet = {
      description = "Allow HTTP port accessible from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    https_from_internet = {
      description = "Allow HTTPS port accessible from anywhere"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    
  }
}*/


variable "ami" {
  type        = string
  description = "The AMI ID for instances in ASG"
  default     = "ami-049924d678af7a43b"
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

variable "launch_template_name" {
  type    = string
  default = "awseks-launch-template"
}

variable "instance_type" {
  description = "The type of EC2 Instances to run"
  type        = string
  default     = "t2.medium"
}

/*variable "eks_cluster_name" {
     description = "Name for the eks cluster"
     default     = "awseks"
   }*/

variable "key_name" {
  type= string
  default="awsekskey"
}
