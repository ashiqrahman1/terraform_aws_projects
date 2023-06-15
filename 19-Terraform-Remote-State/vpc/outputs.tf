output "vpc_id" {
    value = module.vpc.this_vpc_id
}

output "public_subnets" {
    value = module.vpc.this_vpc_public_subnet
}

output "public_subnets_id" {
    value = module.vpc.this_vpc_public_subnet_id
}

output "private_subnets" {
    value = module.vpc.this_vpc_private_subnet
}

output "private_subnets_id" {
    value = module.vpc.this_vpc_private_subnet_id
}

output "db_subnets" {
    value = module.vpc.this_vpc_db_subnet
}