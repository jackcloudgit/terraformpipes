module "ipam" {
  source = "../../module/ipam_lab/"
  region = "ap-south-1"
  supernet_cidr = "10.0.0.0/8"
  regional_cidr = "10.0.0.0/12"
  vpc_cidrs = {
    dev  = "10.0.0.0/16"
    test = "10.2.0.0/16"
    # prod = "10.4.0.0/16"
    # network = "10.34.0.0/16"
    # hudson = "10.252.0.0/16"
  }
  vpc_disallowed_cidrs = {}
  # vpc_disallowed_cidrs = {
  #   dev  = ["10.0.1.0/24"]
  #   test = ["10.2.1.0/24"]
  #   prod = ["10.4.1.0/24"]
  #   network = ["10.34.187.0/24","10.34.190.0/24"]
  #   hudson = ["10.252.7.0/24","10.250.7.0/24"]
  # }
  vpc_account_ids = {
    # dev  = "123456789012"
    # test = "345678901234"
    # prod = "567890123456"
    # network = "567890123456"
    # hudson = "567890123456"
  }  
}