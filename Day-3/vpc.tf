//create vpc
//create internet gateway
//attach internet gateway to vpc
//create one public subnet per each zone
//create a public routing table associate it with all public subnets


#declare data source not manage by terraform (eg. availability zones, etc..)
data "aws_availability_zones" "available" {
 state = "available"
}

//Intenet Gateway
resource "aws_internet_gateway" "my_igw" {
  tags = {
   # Name = "My internet Gateway"
   Name = var.my_public_internet_gateway
  }
}

//attached to vpc to igw
resource "aws_internet_gateway_attachment" "igw_vpc" {
  internet_gateway_id = aws_internet_gateway.my_igw.id
  vpc_id              = aws_vpc.thirdworld.id
}

//create vpc
resource "aws_vpc" "thirdworld" {
 
 cidr_block = var.my_vpc_cird
 #cidr_block = "10.0.0.0/16" // can use 16 and 28
 tags = {
    Name = var.my_vpc_name
 }

}

// public subnets
//count
//list
resource "aws_subnet" "mypublicsubnet" {
  count = length(data.aws_availability_zones.available.names) //3 (count.index -> 0, 1, 2)
    vpc_id = aws_vpc.thirdworld.id
    cidr_block = var.cidr_for_public_subnet[count.index]
    availability_zone = var.zone_for_public_subnet[count.index]
    tags = {
      Name = var.zonename_for_public_subnet[count.index]
    }
  
}

// private subnets
//count
//list
resource "aws_subnet" "myprivatesubnet" {
  count = length(data.aws_availability_zones.available.names) //3 (count.index -> 0, 1, 2)
    vpc_id = aws_vpc.thirdworld.id
    cidr_block = var.cidr_for_private_subnet[count.index]
    availability_zone = var.zone_for_private_subnet[count.index]
    tags = {
      Name = var.zonenmae_for_private_subnet[count.index]
    }
  
}


//attach subnet associate with ruoute table
resource "aws_route_table_association" "pub_rtb_subnets" {
  count = length(aws_subnet.mypublicsubnet) //
  route_table_id = aws_route_table.my_public_rtb.id
  subnet_id = aws_subnet.mypublicsubnet[count.index].id
}


# resource "aws_subnet" "mysubnet2" {
#     vpc_id = aws_vpc.thirdworld.id
#     cidr_block = "10.0.1.0/24"
#     availability_zone = "ap-southeast-1b"
#     tags = {
#       Name = "mysubnet2"
#     }
  
# }

# resource "aws_subnet" "mysubnet3" {
#     vpc_id = aws_vpc.thirdworld.id
#     cidr_block = "10.0.2.0/24"
#     availability_zone = "ap-southeast-1c"
#     tags = {
#       Name = "mysubnet3"
#     }
  
# }

//route table
resource "aws_route_table" "my_public_rtb" {
  vpc_id = aws_vpc.thirdworld.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    #Name = "day three public routing table"
    Name = var.public_rtb_name
  }
}
//default route table
resource "aws_default_route_table" "my_private_rtb" {
  default_route_table_id = aws_vpc.thirdworld.default_route_table_id
  tags = {
   # Name = "day three private route table"
   Name = var.private_rtb_name
  }
}