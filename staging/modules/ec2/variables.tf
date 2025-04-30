variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "security_group_id" {
  type        = string
  description = "Security Group ID"
}

variable "key_name" {
  type        = string
  description = "Key pair name for SSH access"
}
variable "jumpbox_role_name" {
  description = "Name of the IAM role for the EC2 jumpbox"
  type        = string
}

variable "jumpbox_instance_profile_name" {
  description = "Name of the IAM instance profile for EC2 jumpbox"
  type        = string
}

variable "jumpbox_policy_name" {
  description = "Name of the IAM policy for EKS access from EC2"
  type        = string
}