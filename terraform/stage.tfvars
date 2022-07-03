aws_region = "ap-southeast-1"

vpc_cidr = { cidr_block = "20.0.0.0/24", name = "stage_vpc" }

pub_subnet = [{ cidr_block = "10.100.0.0/20", name = "stage_pub_subnet_1" }, { cidr_block = "10.100.16.0/20", name = "stage_pub_subnet_2" }, { cidr_block = "10.100.32.0/20", name = "stage_pub_subnet_3"}]
app_subnet = [{ cidr_block = "10.100.48.0/20", name = "stage_app_subnet_1" }, { cidr_block = "10.100.64.0/20", name = "stage_app_subnet_2" }, { cidr_block = "10.100.80.0/20", name = "stage_app_subnet_3"}]
db_subnet = [{ cidr_block = "10.100.96.0/20", name = "stage_db_subnet_1" }, { cidr_block = "10.100.112.0/20", name = "stage_db_subnet_2" }, { cidr_block = "10.100.128.0/20", name = "stage_db_subnet_3"}]
