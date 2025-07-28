output "allow_ssh_sg_id" {
    value = aws_security_group.allow_ssh.id
}

output "allow_tls_sg_id" {
    value = aws_security_group.allow_tls.id
}

output "allow_http_sg_id" {
    value = aws_security_group.allow_http.id
}

output "allow_http_https_sg_id" {
    value = aws_security_group.allow_http_https_nat.id
}