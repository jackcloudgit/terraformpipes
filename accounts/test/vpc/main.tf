module "ipam" {
  source = "../../module/ipam_lab/"
  region = "ap-south-1"
  supernet_cidr = "20.0.0.0/8"
  regional_cidr = "20.0.0.0/12"
  vpc_cidrs = {
    dev  = "20.0.0.0/16"
    test = "20.2.0.0/16"
  }
  vpc_disallowed_cidrs = {}
  vpc_account_ids = {}    
  
}