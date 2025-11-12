# IPAM Resource
resource "aws_vpc_ipam" "main" {
  description = "Central IPAM for all environments"
  operating_regions {
    region_name = var.region
  }
}

# Top-level pool
resource "aws_vpc_ipam_pool" "top_level" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.main.private_default_scope_id
}

resource "aws_vpc_ipam_pool_cidr" "top_level_cidr" {
  ipam_pool_id = aws_vpc_ipam_pool.top_level.id
  cidr         = var.supernet_cidr
}

# Regional pool
resource "aws_vpc_ipam_pool" "regional" {
  address_family                     = "ipv4"
  ipam_scope_id                     = aws_vpc_ipam.main.private_default_scope_id
  locale                           = var.region
  source_ipam_pool_id               = aws_vpc_ipam_pool.top_level.id
  allocation_default_netmask_length = 16
  allocation_max_netmask_length     = 24
  allocation_min_netmask_length     = 16
}

resource "aws_vpc_ipam_pool_cidr" "regional_cidr" {
  ipam_pool_id = aws_vpc_ipam_pool.regional.id
  cidr         = var.regional_cidr
}

# Shared VPC pool
resource "aws_vpc_ipam_pool" "vpc_shared" {
  address_family           = "ipv4"
  ipam_scope_id            = aws_vpc_ipam.main.private_default_scope_id
  locale                   = var.region
  source_ipam_pool_id      = aws_vpc_ipam_pool.regional.id
  description              = "Shared pool for Dev/Test/Prod VPCs"

  allocation_resource_tags = {
    "Purpose" = "VPC"
  }
}

# Provision VPC CIDRs
resource "aws_vpc_ipam_pool_cidr" "vpc_cidrs" {
  for_each     = var.vpc_cidrs
  ipam_pool_id = aws_vpc_ipam_pool.vpc_shared.id
  cidr         = each.value
}

# Allocate VPC CIDRs with disallowed_cidrs
resource "aws_vpc_ipam_pool_cidr_allocation" "vpc" {
  for_each         = var.vpc_cidrs
  ipam_pool_id     = aws_vpc_ipam_pool.vpc_shared.id
  cidr             = each.value
  disallowed_cidrs = lookup(var.vpc_disallowed_cidrs, each.key, [])
}

# Share VPC Pool CIDRs via RAM to specific AWS accounts
# resource "aws_ram_resource_share" "vpc_share" {
#   for_each                  = var.vpc_account_ids
#   name                      = "ipam-vpc-share-${each.key}"
#   allow_external_principals = false  
# }

# resource "aws_ram_principal_association" "vpc_assoc" {
#   for_each           = var.vpc_account_ids
#   principal          = each.value
#   resource_share_arn = aws_ram_resource_share.vpc_share[each.key].arn
# }

# resource "aws_ram_resource_association" "vpc_resource_assoc" {
#   for_each           = var.vpc_account_ids
#   resource_arn       = aws_vpc_ipam_pool.vpc_shared.arn
#   resource_share_arn = aws_ram_resource_share.vpc_share[each.key].arn
# }