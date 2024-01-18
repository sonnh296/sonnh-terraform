# \\  //  ||))  //""
#  \\//   ||    \\__

resource "aws_vpc" "my_blog_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "my blogs vpc"
  }
}

resource "aws_internet_gateway" "blogs_vpc_igw" {
  vpc_id = aws_vpc.my_blog_vpc.id

  tags = {
    Name = "blogs vpc igw"
  }

}

# **********************************************************************
# ***************** PUBLIC SUBNET - APP ********************************
# **********************************************************************

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.my_blog_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "blog public subnet"
  }
}

//route table itegrated to internet gateway for public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_blog_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.blogs_vpc_igw.id
  }

  tags = {
    Name = "Public Subnet Route Table."
  }
}

resource "aws_route_table_association" "s_vpc_ap_southeast_1a_public" {
  subnet_id      = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.public_route_table.id
}


# **********************************************************************
# ***************** Privae SUBNET - DB *********************************
# **********************************************************************
resource "aws_eip" "bogs_nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "blogs_nat_gateway" {
  allocation_id = aws_eip.bogs_nat.id
  subnet_id     = aws_subnet.public_subnets.id

  tags = {
    Name = "blogs nat gateway"
  }

  depends_on = [aws_internet_gateway.blogs_vpc_igw]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_blog_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.blogs_nat_gateway.id
  }

  tags = {
    Name = "Private Subnet Route Table."
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id                  = aws_vpc.my_blog_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "blog private subnet for db"
  }
}

resource "aws_route_table_association" "s_vpc_ap_southeast_1b_private" {
  subnet_id      = aws_subnet.private_subnets.id
  route_table_id = aws_route_table.private_route_table.id
}

