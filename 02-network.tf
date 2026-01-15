# 1. Create the Custom VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block           = "192.168.52.0/23"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "custom-vpc" }
}

# 2. Create an Internet Gateway (Required for internet access)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = { Name = "custom-igw" }
}

# 3. Create a Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "192.168.52.0/24"
  map_public_ip_on_launch = true # Automatically assigns public IPs to instances

  tags = { Name = "public-subnet" }
}

# 4. Create a Route Table and a Route to the Internet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "public-route-table" }
}

# 5. Associate the Route Table with the Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

