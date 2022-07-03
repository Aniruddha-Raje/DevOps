aws_region = "ap-southeast-1"

vpc_cidr = { cidr_block = "30.0.0.0/24", name = "prod_vpc" }

pub_subnet = [{ cidr_block = "10.200.0.0/20", name = "prod_pub_subnet_1" }, { cidr_block = "10.200.16.0/20", name = "prod_pub_subnet_2" }, { cidr_block = "10.200.32.0/20", name = "prod_pub_subnet_3"}]
app_subnet = [{ cidr_block = "10.200.48.0/20", name = "prod_app_subnet_1" }, { cidr_block = "10.200.64.0/20", name = "prod_app_subnet_2" }, { cidr_block = "10.200.80.0/20", name = "prod_app_subnet_3"}]
db_subnet = [{ cidr_block = "10.200.96.0/20", name = "prod_db_subnet_1" }, { cidr_block = "10.200.112.0/20", name = "prod_db_subnet_2" }, { cidr_block = "10.200.128.0/20", name = "prod_db_subnet_3"}]
