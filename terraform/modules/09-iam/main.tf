#========================================
# IAM Role for K8s Nodes to create Load Balancers
#========================================
resource "aws_iam_role" "k8s_nodes_role" {
  name = "k8s-nodes-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "k8s-nodes-role"
  }
}

#========================================
# IAM Policy for ELB/CLB Creation
#========================================
resource "aws_iam_policy" "k8s_elb_policy" {
  name        = "k8s-elb-policy"
  description = "Policy to allow K8s nodes to create and manage ELB/CLB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "elasticloadbalancing:*",
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeAddresses",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeInstances",
          "ec2:DescribeNetworkInterfaces",
          "ec2:CreateSecurityGroup",
          "ec2:CreateTags",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "k8s-elb-policy"
  }
}

#========================================
# Attach ELB Policy to K8s Nodes Role
#========================================
resource "aws_iam_role_policy_attachment" "k8s_elb_attach" {
  role       = aws_iam_role.k8s_nodes_role.name
  policy_arn = aws_iam_policy.k8s_elb_policy.arn
}

#========================================
# IAM Instance Profile for K8s Nodes
#========================================
resource "aws_iam_instance_profile" "k8s_nodes_profile" {
  name = "k8s-nodes-instance-profile"
  role = aws_iam_role.k8s_nodes_role.name

  tags = {
    Name = "k8s-nodes-instance-profile"
  }
}

#========================================
# IAM Role for Jenkins EC2 Instance
#========================================
resource "aws_iam_role" "jenkins_role" {
  name = "jenkins-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "jenkins-ecr-role"
  }
}

#========================================
# IAM Policy for ECR Access
#========================================
resource "aws_iam_policy" "jenkins_ecr_policy" {
  name        = "jenkins-ecr-policy"
  description = "Policy to allow Jenkins to push images to ECR"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr-public:GetAuthorizationToken",
          "sts:GetServiceBearerToken"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr-public:BatchCheckLayerAvailability",
          "ecr-public:GetRepositoryPolicy",
          "ecr-public:DescribeRepositories",
          "ecr-public:DescribeImages",
          "ecr-public:InitiateLayerUpload",
          "ecr-public:UploadLayerPart",
          "ecr-public:CompleteLayerUpload",
          "ecr-public:PutImage"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "jenkins-ecr-policy"
  }
}

#========================================
# Attach Policy to Role
#========================================
resource "aws_iam_role_policy_attachment" "jenkins_ecr_attach" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = aws_iam_policy.jenkins_ecr_policy.arn
}

#========================================
# IAM Instance Profile
#========================================
resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins-instance-profile"
  role = aws_iam_role.jenkins_role.name

  tags = {
    Name = "jenkins-instance-profile"
  }
}
