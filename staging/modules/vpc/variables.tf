variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type = string
}
## Web Tier CIDR Block 1##
variable "public-webtier-subnet-1-cidr" {
  default     = "10.40.0.0/22"
  description = "public_web_subnet1"
  type        = string
}

## Web Tier CIDR Block 2##

variable "public-webtier-subnet-2-cidr" {
  default     = "10.40.4.0/22"
  description = "public_web_subnet2"
  type        = string
}



