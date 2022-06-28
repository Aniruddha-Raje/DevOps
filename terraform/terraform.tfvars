dev_vpc_cidr = { cidr_block = "50.0.2.0/24", name = "dev_vpc" }
stage_vpc_cidr = { cidr_block = "100.0.0.0/24", name = "stage_vpc" }
prod_vpc_cidr = { cidr_block = "200.0.0.0/24", name = "prod_vpc" }

dev_pub_subnet = [{ cidr_block = "50.0.1.0/24", name = "prod_subnet" }, { cidr_block = "50.0.2.0/24", name = "dev_subnet" }]
dev_app_subnet = [{ cidr_block = "10.0.1.0/24", name = "prod_subnet" }, { cidr_block = "50.0.2.0/24", name = "dev_subnet" }]
dev_db_subnet = [{ cidr_block = "10.0.1.0/24", name = "prod_subnet" }, { cidr_block = "50.0.2.0/24", name = "dev_subnet" }]

stage_pub_subnet = [{ cidr_block = "100.0.1.0/24", name = "prod_subnet" }, { cidr_block = "100.0.2.0/24", name = "dev_subnet" }]
stage_app_subnet = [{ cidr_block = "100.0.1.0/24", name = "prod_subnet" }, { cidr_block = "100.0.2.0/24", name = "dev_subnet" }]
stage_db_subnet = [{ cidr_block = "100.0.1.0/24", name = "prod_subnet" }, { cidr_block = "100.0.2.0/24", name = "dev_subnet" }]

prod_pub_subnet = [{ cidr_block = "200.0.1.0/24", name = "prod_subnet" }, { cidr_block = "200.0.2.0/24", name = "dev_subnet" }]
prod_app_subnet = [{ cidr_block = "200.0.1.0/24", name = "prod_subnet" }, { cidr_block = "200.0.2.0/24", name = "dev_subnet" }]
prod_db_subnet = [{ cidr_block = "200.0.1.0/24", name = "prod_subnet" }, { cidr_block = "200.0.2.0/24", name = "dev_subnet" }]
