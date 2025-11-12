variable "region" {
  description = "AWS region for IPAM"
  type        = string
  default     = "ap-south-1"
}

variable "supernet_cidr" {
  description = "Global CIDR for top-level pool (e.g., 10.0.0.0/8)"
  type        = string
}

variable "vpc_cidrs" {
  description = "Map of environment to VPC CIDR (e.g., { dev = '10.0.0.0/16', test = '10.1.0.0/16', prod = '10.2.0.0/16' })"
  type        = map(string)
}

##Additions
variable "vpc_disallowed_cidrs" {
  description = "Map of VPC names to lists of disallowed CIDR blocks"
  type        = map(list(string))
  default     = {}
}

variable "vpc_account_ids" {
  description = "Map of VPC names to AWS account IDs for RAM sharing"
  type        = map(string)
  default     = {}
}
variable "regional_cidr" {
  description = "CIDR block for the regional IPAM pool"
  type        = string  
}