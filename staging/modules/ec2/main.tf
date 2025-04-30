resource "aws_instance" "jumpbox" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  tags = {
    Name = "EC2-Jumpbox"
  }
}

resource "aws_iam_role" "jumpbox_role" {
  name = var.jumpbox_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "jumpbox_policy" {
  name        = var.jumpbox_policy_name
  description = "Policy for EC2 jump host to interact with EKS"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "eks:DescribeCluster",
        "eks:ListClusters"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.jumpbox_role.name
  policy_arn = aws_iam_policy.jumpbox_policy.arn
}

resource "aws_iam_instance_profile" "jumpbox_profile" {
  name = var.jumpbox_instance_profile_name
  role = aws_iam_role.jumpbox_role.name
}
