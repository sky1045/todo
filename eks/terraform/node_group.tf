resource "aws_eks_node_group" "node_group" {
  for_each        = toset(var.private_subnets)
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "eks-${var.name}-${each.value}"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = [each.value]

  scaling_config {
    desired_size = 2
    max_size     = 20
    min_size     = 2
  }

  update_config {
    max_unavailable = 2
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
  ]
}
