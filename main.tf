# ----------------------------------------------------------------------------
# main.tf
# ----------------------------------------------------------------------------
# Main entrypoint of this Terraform module.
# ----------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Local values used in this module
locals {
  module_common_tags = var.common_tags
  subnet_cidrs = cidrsubnets(var.network_cidr, 8, 8, 8, 4, 4, 4, 4, 4, 4)
  public_web_subnet_cidrs = slice(local.subnet_cidrs, 0, 3)
  private_app_subnet_cidrs = slice(local.subnet_cidrs, 3, 6)
  private_data_subnet_cidrs = slice(local.subnet_cidrs, 6, 9)
  bastion_enabled = var.number_of_bastion_instances > 0 ? true : false
}

data aws_region current {

}

data aws_availability_zones zones {
  state = "available"
}
