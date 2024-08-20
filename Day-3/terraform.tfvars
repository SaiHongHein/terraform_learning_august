my_vpc_name = "welcome to Day Three VPC"

#variable for vpc cidr
my_vpc_cird = "10.0.0.0/16"

#variable for public subnets
zone_for_public_subnet = [ "ap-southeast-1a", "ap-southeast-1b","ap-southeast-1c" ]
cidr_for_public_subnet = [ "10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24" ]
zonename_for_public_subnet = [ "public_subnet-1", "public_subnet-2", " public_subnet-3" ]

#variable for private subnets
zone_for_private_subnet = [ "ap-southeast-1a", "ap-southeast-1b","ap-southeast-1c" ]
cidr_for_private_subnet = [ "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24" ]
zonenmae_for_private_subnet = [ "private_subnet-1", "private_subnet-2", " private_subnet-3" ]


#variable for public and private name
public_rtb_name = "day three public route table"
private_rtb_name = "day three private route table"

#variable for internet gateway
my_public_internet_gateway = "Day three public internet gateway"