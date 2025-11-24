output "ipam_id" {
  description = "ID of the IPAM resource"
  value       = module.ipam.ipam_id
}

output "vpc_shared_pool_id" {
  description = "ID of the shared VPC IPAM pool"
  value       = module.ipam.vpc_shared_pool_id
}

output vpc_cidrs {
  description = "Map of VPC names to their allocated CIDRs"
  value       = module.ipam.vpc_cidrs
}