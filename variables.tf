variable "aws_region" {
  default = "ap-south-1"
}

variable "cluster_name" {
  default = "devops-eks-cluster"
}

variable "key_pair" {
  description = "EC2 key pair name"
}
