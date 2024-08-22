#for vpc
 base_vpc = {
  Name = "VPC-A"
  cidr = "10.0.0.0/16"
}

#for igw
base_igw = {
    Name = "VPC-A-IGW"
}

#for public_subnet
public_subnets = {
  "public_subnet_1" = {
      Name = "Public-Subnet-1"
      cidr = "10.0.1.0/24"
      zone = "ap-southeast-1a"
    },
    "public_subnet_2" = {
      Name = "Public-Subnet-2"
      cidr = "10.0.2.0/24"
      zone = "ap-southeast-1b"
    },
    "public_subnet_3" = {
      Name = "Public-Subnet-3"
      cidr = "10.0.3.0/24"
      zone = "ap-southeast-1c"
    }
}

#for public route table
public_rtb = {
  Name = "VPC-A-Public-RTB"
}

