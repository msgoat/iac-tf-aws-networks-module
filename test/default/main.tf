provider "aws" {
  region  = var.region_name
  version = "~> 2.7"
}

# Local values used in this module
locals {
  networks_common_tags = {
    Organization = var.organization_name
    Department   = var.department_name
    Project      = var.project_name
    Stage        = var.stage
  }
}

module "network" {
  source = "../.."
  region_name = var.region_name
  organization_name = var.organization_name
  department_name = var.department_name
  project_name = var.project_name
  stage = var.stage
  network_name = var.network_name
  inbound_traffic_cidrs = var.inbound_traffic_cidrs
}