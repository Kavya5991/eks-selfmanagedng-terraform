module "cluster" {
  source            = "./modules/cluster"
  public_subnet_ids = module.vpc.public_subnet_ids
  cluster_role_arn  = module.IAM.cluster_role_arn
}
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnets_cidr = var.public_subnets_cidr
  #availability_zones   = var.availability_zones
}
module "sg" {
  source                     = "./modules/sg"
  security_group_name        = "asg-security-group" // Replace with your desired name
  security_group_description = "ASG Security Group"
  vpc_id                     = module.vpc.vpc_id

  ingress_rules = {
    eks = {
      description = "Allow SSH traffic from anywhere"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.allowed_cidr]
    }
    http_from_internet = {
      description = "Allow HTTP port accessible from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [var.allowed_cidr]
    }
    https_from_internet = {
      description = "Allow HTTPS port accessible from anywhere"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [var.allowed_cidr]
    }
    eks_to_worker_node = {
    description = "Allow traffic from the EKS cluster to the worker node group"
    from_port   = 0              # Allow all ports
    to_port     = 65535          # Allow all ports
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  allow_all_ingress = {
      description = "Allow all ingress traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    
  }

  egress_rules = {
    allow_all_egress = {
      description = "Allow all egress traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}
module "IAM" {
  source = "./modules/IAM"

}
module "nodegroup" {
  source                = "./modules/nodegroup"
  vpc_id                = module.vpc.vpc_id
  key_name              = var.key_name
  launch_template_name  = var.launch_template_name
  ami                   = var.ami
  instance_type         = var.instance_type
  desired_capacity      = var.desired_capacity
  max_size              = var.max_size
  min_size              = var.min_size
  public_subnet_ids     = module.vpc.public_subnet_ids
  asg_security_group_id = [module.sg.sg_id]
  eks_self_managed_node_group_instance_profile_arn = module.IAM.managed_node_instance_profile

}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  
  data = {
    mapRoles = <<-EOT
      - rolearn: ${module.IAM.managed_node_role_arn}
        username: system:node:{{EC2PrivateDNSName}}
        groups:
          - system:bootstrappers
          - system:nodes
    EOT
  }
}

data "aws_eks_cluster" "example" {
  name       = module.cluster.eks_cluster_name
  depends_on = [module.cluster]
}

data "aws_eks_cluster_auth" "example" {
  name       = module.cluster.eks_cluster_name
  depends_on = [module.cluster]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.example.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.example.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.example.token
}
