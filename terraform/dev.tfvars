aws_region = "ap-southeast-1"

vpc_cidr = { cidr_block = "10.50.0.0/16", name = "dev_vpc" }

pub_subnet = [{ cidr_block = "10.50.0.0/20", name = "dev_pub_subnet_1" }, { cidr_block = "10.50.16.0/20", name = "dev_pub_subnet_2"}, { cidr_block = "10.50.32.0/20", name = "dev_pub_subnet_3"}]
app_subnet = [{ cidr_block = "10.50.48.0/20", name = "dev_app_subnet_1" }, { cidr_block = "10.50.64.0/20", name = "dev_app_subnet_2" }, { cidr_block = "10.50.80.0/20", name = "dev_app_subnet_3"}]
db_subnet = [{ cidr_block = "10.50.96.0/20", name = "dev_db_subnet_1" }, { cidr_block = "10.50.112.0/20", name = "dev_db_subnet_2" }, { cidr_block = "10.50.128.0/20", name = "dev_db_subnet_3"}]
