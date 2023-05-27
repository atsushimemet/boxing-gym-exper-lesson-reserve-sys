output "ec2_glocal_ips" { value = aws_instance.boxing_ec2.*.public_ip }
