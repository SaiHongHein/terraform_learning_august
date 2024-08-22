# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

#create vpc
resource "aws_vpc" "base_vpc" {
  cidr_block = var.base_vpc.cidr //10.0.0.0/16
  tags = {
    Name = var.base_vpc.Name // VPC-A
  }

}

#referenc variable on public subnet
locals {
  vpc_name = aws_vpc.base_vpc.tags.Name
}


#create internet gateway
resource "aws_internet_gateway" "base_internet_gateway" {
  vpc_id = aws_vpc.base_vpc.id
  tags = {
    Name = var.base_igw.Name //VPC-A-IGW
  }
}

//list of objects
// list , set -> default = [VPC-A , VPC-A], [VPC-A , VPC-B] // list value can using same but set value is unique
// map        -> default = {"key1" = "value1", "key2" = "value2", "key3" = "value3"} have to same value.   

# variable "love_letter" {
#   type = map(string)
#   default = {
#     "myanmar" = "chit tel"
#     "english" = "I love you"
#     "chinese" = "Wo Ai Ni"
#     "japanese" = "a i shite ru"
#   }
# }

# resource "local_file" "love_letter" {
#   filename = "./yesarrsar.txt"
#   content = var.love_letter["myanmar"]
# }


#variable for public subnet <using object type>
# variable "public_subnet" {
#   type = object({
#     Name = string
#     cidr = string
#     zone = string
#   })
#   default = {
#     Name = "Public-Subnet-1"
#     cidr = "10.0.1.0/24"
#     zone = "ap-southeast-1a"
#   }
# }


# #variable for public subnet <using list of object>
# variable "public_subnets" {
#   type = list(object({
#     Name = string
#     cidr = string
#     zone = string
#   }))

#   default = [
#     {
#       Name = "Public-Subnet-1"
#       cidr = "10.0.1.0/24"
#       zone = "ap-southeast-1a"
#     },
#     {
#       Name = "Public-Subnet-2"
#       cidr = "10.0.2.0/24"
#       zone = "ap-southeast-1b"
#     },
#     {
#       Name = "Public-Subnet-3"
#       cidr = "10.0.3.0/24"
#       zone = "ap-southeast-1c"
#     }
#   ]
# }

#create subnet using for each loop using map
resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets //map(object) ->3
  vpc_id                  = aws_vpc.base_vpc.id
  cidr_block              = each.value.cidr //10.0.1.0/24
  map_public_ip_on_launch = true   //assign resources public ip when create on that subnet
  availability_zone       = each.value.zone //ap-southeast-1a
  tags = {
    #Name = "${local.vpc_name}-${var.public_subnet.Name}" //VPC-A-public-subnet-1 // reference with local and public subnet variable
    Name = "${local.vpc_name}-${each.value.Name}"
  }
}

# #create subnet using count loop using list
# resource "aws_subnet" "public_subnets" {
#   count = length(var.public_subnets)  // 3 subnets object
#   vpc_id                  = aws_vpc.base_vpc.id
#   cidr_block              = var.public_subnets[count.index].cidr //10.0.1.0/24
#   map_public_ip_on_launch = true                   //assign resources public ip when create on that subnet
#   availability_zone       = var.public_subnets[count.index].zone //ap-southeast-1
#   tags = {
#     #Name = "${local.vpc_name}-${var.public_subnet.Name}" //VPC-A-public-subnet-1 // reference with local and public subnet variable
#     Name = "${local.vpc_name}-${var.public_subnets[count.index].Name}"
#   }
# }

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.base_vpc.id
  tags = {
    #Name = "${local.vpc_name}-Public-RTB"
    Name = var.public_rtb.Name
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.base_internet_gateway.id
    }
}

resource "aws_route_table_association" "public_rtb_association" {
  for_each = aws_subnet.public_subnets
  route_table_id = aws_route_table.public_rtb.id
  subnet_id = each.value.id
}