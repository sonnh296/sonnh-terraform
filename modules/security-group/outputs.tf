output "allow_ssh_myip_sg" {
  value = aws_security_group.allow_ssh_myip_sg
}
output "allow_ssh_all_sg" {
  value = aws_security_group.allow_ssh_all_sg
}
output "allow_http_sg" {
  value = aws_security_group.allow_http_sg
}
output "allow_mysql_sg" {
  value = aws_security_group.allow_mysql_sg
}

