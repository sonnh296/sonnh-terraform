//launch VPC

resource "aws_vpc" "s_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "s vpc"
  }
}

resource "aws_internet_gateway" "s_vpc_igw" {
  vpc_id = aws_vpc.s_vpc.id

  tags = {
    Name = "s vpc igw"
  }

}

# **********************************************************************
# ***************** PUBLIC SUBNET **************************************
# **********************************************************************

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.s_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "s public subnet"
  }
}

//route table for public subnet annd associate with public subnet
resource "aws_route_table" "s_vpc_app_route_table" {
  vpc_id = aws_vpc.s_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.s_vpc_igw.id
  }

  tags = {
    Name = "Public Subnet Route Table."
  }
}

resource "aws_route_table_association" "s_vpc_ap_southeast_1a_public" {
  subnet_id      = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.s_vpc_app_route_table.id
}


//================================================================================================

