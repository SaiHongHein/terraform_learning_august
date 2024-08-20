variable "my_vpc_name" {
    #default = "Welcome to Yangon."

}

variable "my_vpc_cird" {
#   default = "10.0.0.0/16"
}

//no default -> user input
//default -> "using default"
//can using other way to overwrite
//terraform apply -var my_vpc_name="something" //using variable to replace default
//terraform apply --var-file=production.tfvars


#                   0,                  1,                  2,
#===========================================================================
#zone           ap-southeast-1a,    ap-southeast-1b,    ap-southeast-1c
#cidr           10.0.0.0/24,        10.0.1.0/24,        10.0.0.2/24
#subnetname     subnet1,            subnet2,            subnet3


variable "zone_for_public_subnet" {
  type = list(string)
  #default = [ "ap-southeast-1a", "ap-southeast-1b","ap-southeast-1c" ]
}
// var.zone_for_public_subnet.[0]


variable "cidr_for_public_subnet" {
  type = list(string)
  #default = [ "10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24" ]
}


variable "zonename_for_public_subnet" {
  type = list(string)
  #default = [ "public subnet1", "public subnet2", " public subnet3" ]
}

variable "zone_for_private_subnet" {
  type = list(string)
}

variable "cidr_for_private_subnet" {
  type = list(string)
}

variable "zonenmae_for_private_subnet" {
  type = list(string)
}

variable "public_rtb_name" {
  
}

variable "private_rtb_name" {
  
}

variable "my_public_internet_gateway" {
  
}