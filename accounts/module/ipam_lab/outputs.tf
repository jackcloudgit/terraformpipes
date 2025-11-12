output "ipam_id" {
  description = "ID of the IPAM resource"
  value       = aws_vpc_ipam.main.id
}

output "vpc_shared_pool_id" {
  description = "ID of the shared VPC IPAM pool"
  value       = aws_vpc_ipam_pool.vpc_shared.id
}

output "vpc_cidrs" {
  description = "Map of VPC names to their allocated CIDRs"
  value       = { for k, v in aws_vpc_ipam_pool_cidr.vpc_cidrs : k => v.cidr }
}
