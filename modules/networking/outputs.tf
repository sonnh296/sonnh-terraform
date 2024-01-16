output "vpc_id" {
  value = aws_vpc.s_vpc
}

output "public_subnets" {
  value = aws_subnet.public_subnets
}
