# If we accept the default VPC, terraform may try to manipulate it and cause failures.
# To avoid this we create our own network definition
resource "aws_vpc" "custom_vpc" {
  cidr_block           = "192.168.52.0/23"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "custom-vpc" }
}

# We may need a gateway to route traffic out of our subnet, 
# but note later each EC2 instance also has a public IP
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = { Name = "custom-igw" }
}

# I don't know why I called this a public subnet.
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "192.168.52.0/24"
  # this next line seems to "do the opposite" of what we're asking for
  # it is very handy
  map_public_ip_on_launch = true 

  tags = { Name = "public-subnet" }
}

# I guess it's because the subnet has an internet gateway in the route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "public-route-table" }
}

# Connect the route table to the subnet.
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

