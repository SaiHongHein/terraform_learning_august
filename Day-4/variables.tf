#variable object for vpc
variable "base_vpc" {
  type = object({
    Name = string
    cidr = string
  })
}

#igw
variable "base_igw" {
  type = object({
    Name = string 
  })
}

#variable for public subnet <using map of object>
variable "public_subnets" {
  type = map(object({
    Name = string
    cidr = string
    zone = string
  }))

}

#for route table
variable "public_rtb" {
  type = object({
    Name = string
  })
}