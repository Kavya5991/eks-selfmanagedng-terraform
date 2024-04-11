/*managed node group role*/
resource "aws_iam_role" "eks_self_managed_node_group" {
  name               = "${var.node_group_name}-role"
  assume_role_policy = file("${path.module}/iam_ec2_assume_role_policy.json")
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_self_managed_node_group.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_self_managed_node_group.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_self_managed_node_group.name
}

resource "aws_iam_instance_profile" "eks_self_managed_node_group" {
  name = "${var.node_group_name}-instance-profile"
  role = aws_iam_role.eks_self_managed_node_group.name
}

/*cluster role */
resource "aws_iam_role" "eks_cluster_role" {
  name               = "${var.cluster_name}-role"
  assume_role_policy = file("${path.module}/iam_eks_assume_role_policy.json")
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}
resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_read_only_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  role       = aws_iam_role.eks_self_managed_node_group.name
}