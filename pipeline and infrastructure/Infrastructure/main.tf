terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket         = "test-tf-bucket-cc"
    key            = "in-the-pipeline/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "StateLocking"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Configure the Kubernetes Provider
provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}


# Create a VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs            = data.aws_availability_zones.available.names
  public_subnets = slice(var.public_subnet_cidr_blocks, 0, var.public_subnet_count)

  enable_nat_gateway   = false
  enable_vpn_gateway   = false
  enable_dns_hostnames = true

  tags = var.resource_tags
}

# Create EC2 for Jenkins
module "JenkinsEC2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "jenkins-master"

  ami                    = "ami-0d527b8c289b4af7f"
  instance_type          = "t2.micro"
  key_name               = "in-the-pipeline-geeky-blinders"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.jenkins_EC2_SG.id, module.eks.cluster_security_group_id, module.eks.worker_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = var.resource_tags
}

resource "aws_security_group" "jenkins_EC2_SG" {
  name        = "SG for Jenkins instance"
  description = "Allow SSH and TCP 8080 traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow TCP on 8080 traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.resource_tags
}

# Create EC2 for GitLab runner
module "GitLab_EC2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "gitlab-runner"

  ami                    = "ami-0d527b8c289b4af7f"
  instance_type          = "t2.micro"
  key_name               = "in-the-pipeline-geeky-blinders"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.gitlab_EC2_SG.id, module.eks.cluster_security_group_id, module.eks.worker_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = var.resource_tags
}

resource "aws_security_group" "gitlab_EC2_SG" {
  name        = "SG for GitLaB-Runner instance"
  description = "Allow SSH and TCP 8093 traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow TCP on 8093 traffic"
    from_port   = 8093
    to_port     = 8093
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.resource_tags
}

# Create EKS Cluster
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_version                 = "1.21"
  cluster_name                    = var.eks_cluster_name
  vpc_id                          = module.vpc.vpc_id
  version                         = "17.24.0"
  subnets                         = module.vpc.public_subnets
  cluster_endpoint_private_access = true

  worker_groups = [
    {
      name                 = "worker-group-1"
      instance_type        = "t2.micro"
      asg_desired_capacity = 2
    }
  ]

  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]

  tags = var.resource_tags
}

# Create SG for Worker Nodes
resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

