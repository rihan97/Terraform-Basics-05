
#terraform outputs values


# EC2 Instance public ip with TOSET
output "instance_publicIP" {
  description = "EC2 instance public IP"
  //these splat wouldn't work because for_each argument accepts only map or string not a list
  #value = aws_instance.myec2.*.public_ip //legacy splat 
  #value = aws_instance.myec2[*].public_ip  //latest splat
  value = [for instance in aws_instance.myec2 : instance.public_ip]
  #value = toset([for instance in aws_instance.myec2: instance.public_ip]) //can use toset to make them all of the same type

}

# EC2 Instance public DNS with TOSET
output "instance_publicDNS" {
  description = "lEC2 instance public DNS"
  //these splat wouldn't work because for_each argument accepts only map or string not a list
  #value = aws_instance.myec2.*.public_dns  //legacy splat 
  #value = aws_instance.myec2[*].public_dns  //latest splat
  value = [for instance in aws_instance.myec2 : instance.public_dns]
  #value = toset([for instance in aws_instance.myec2: instance.public_dns]) //can use toset to make them all of the same type (most general type)
}

# EC2 Instance public DNS with TOMAP
output "instance_publicDNS2" {
  description = "EC2 instance public IP using TOMAP"
  value       = { for az, instance in aws_instance.myec2 : az => instance.public_dns } //with map you need key and value hence az => xxxx
  #value = tomap({ for az,   instance in aws_instance.myec2: az => instance.public_dns}) //if you want all of them to be of the same type (most generatl type)
}
