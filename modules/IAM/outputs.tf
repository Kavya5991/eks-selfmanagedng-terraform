output "instance_profile_arn" {
  value = aws_iam_instance_profile.eks_self_managed_node_group.arn
}

output "managed_node_role_arn" {
  value = aws_iam_role.eks_self_managed_node_group.arn
}

output "managed_node_instance_profile"{
    value = aws_iam_instance_profile.eks_self_managed_node_group.arn
}

output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}