# # 2. Create the VPC
# resource "aws_vpc" "main_vpc" {
#   cidr_block           = "192.168.52.0/23"
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags = {
#     Name = "asiwko-vpc-192-168-52-0"
#   }
# }

# # 3. Create an Internet Gateway (to allow traffic out)
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main_vpc.id

#   tags = {
#     Name = "main-igw"
#   }
# }

# # 4. Create a Public Subnet (Example: using half of the /23 range)
# resource "aws_subnet" "public_subnet" {
#   vpc_id                  = aws_vpc.main_vpc.id
#   cidr_block              = "192.168.52.0/24"
#   map_public_ip_on_launch = true
#   availability_zone       = "us-east-1a"

#   tags = {
#     Name = "public-subnet-01"
#   }
# }

# resource "aws_subnet" "private_subnet" {
#   vpc_id                  = aws_vpc.main_vpc.id
#   cidr_block              = "192.168.53.0/24"
#   map_public_ip_on_launch = true
#   availability_zone       = "us-east-1a"

#   tags = {
#     Name = "private-subnet-01"
#   }
# }

# # 5. Create a Route Table
# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.main_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   tags = {
#     Name = "public-route-table"
#   }
# }

# # 6. Associate Route Table with Subnet
# resource "aws_route_table_association" "public_assoc" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_rt.id
# }