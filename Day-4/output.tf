output "available_zones" {
  value = data.aws_availability_zones.available.names
}

output "name" {
  value = "using for_each loop create subnets"
}

output "out_put_vpc_id_on_console" {
  #value = aws_vpc.base_vpc.id
  value = "my vpc id is ${aws_vpc.base_vpc.id}"
}

# output "love_content" {
#   value = local_file.love_letter.content
# }