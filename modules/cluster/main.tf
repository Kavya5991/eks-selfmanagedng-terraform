# Create EKS Cluster
resource "aws_eks_cluster" "awseks" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  vpc_config {
    subnet_ids = var.public_subnet_ids
  }
  enabled_cluster_log_types = var.enable_cluster_logs ? ["api", "audit","controllerManager","scheduler"] : []
}





