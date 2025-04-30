resource "aws_eks_cluster" "staging1-eks-cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.staging1-eks-cluster-role.arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_public_access  = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
    public_access_cidrs     = var.public_access_cidrs
    security_group_ids      = [aws_security_group.node_group_one.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.stage1-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.stage1-AmazonRDSFullAccess,
  ]
}

resource "aws_eks_node_group" "staging1-eks-worker-node-group" {
  cluster_name    = aws_eks_cluster.staging1-eks-cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.staging1-eks-node-group-role.arn
  subnet_ids      = var.subnet_ids
  instance_types  = var.instance_types

  remote_access {
    source_security_group_ids = [aws_security_group.node_group_one.id]
    ec2_ssh_key               = var.key_pair
  }

  scaling_config {
    desired_size = var.scaling_desired_size
    max_size     = var.scaling_max_size
    min_size     = var.scaling_min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.stage1-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.stage1-AmazonEC2FullAccess,
    aws_iam_role_policy_attachment.stage1-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_security_group" "node_group_one" {
  name_prefix = "node_group_one"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS to Kubernetes API"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Optional: Access to your app (HTTP)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
