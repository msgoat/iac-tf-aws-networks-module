# subnets.tf
# Creates a fixed set of subnets in each availability zone.
#

locals {
  subnet_name_prefixes = [for zone in data.aws_availability_zones.zones.names : "sn-${zone}-${var.solution_fqn}-${var.network_name}"]
}

# create a public web subnet in each availability zone
# for ( count = 0 ; count < length(..) ; count++ ) {
resource aws_subnet public_web_subnets {
  count = length(data.aws_availability_zones.zones.names)
  vpc_id = aws_vpc.vpc.id
  cidr_block = local.public_web_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.zones.names[count.index]
  map_public_ip_on_launch = true
  tags = merge({Name = "${local.subnet_name_prefixes[count.index]}-web"}, local.module_common_tags)
}

# create a private application subnet in each availability zone
resource aws_subnet private_app_subnets {
  count = length(data.aws_availability_zones.zones.names)
  vpc_id = aws_vpc.vpc.id
  cidr_block = local.private_app_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.zones.names[count.index]
  map_public_ip_on_launch = false
  tags = merge({Name = "${local.subnet_name_prefixes[count.index]}-app"}, local.module_common_tags)
}

# create a private datastore subnet in each availability zone
resource aws_subnet private_data_subnets {
  count = length(data.aws_availability_zones.zones.names)
  vpc_id = aws_vpc.vpc.id
  cidr_block = local.private_data_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.zones.names[count.index]
  map_public_ip_on_launch = false
  tags = merge({Name = "${local.subnet_name_prefixes[count.index]}-data"}, local.module_common_tags)
}
