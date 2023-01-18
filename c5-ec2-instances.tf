

#declaring our ec2 instances
resource "aws_instance" "myec2" {
  ami                    = data.aws_ami.amz-linux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data              = file("/Users/rayhanalam/Documents/Training/Terraform/Terraform-basics-03/User-data/app1-install.sh")
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  # create EC2 instance in all availability zones of a Vpc
  #for_each = toset (data.aws_availability_zones.my-az.names )  //need more refined list
  for_each = toset(keys({ for az, details in data.aws_ec2_instance_type_offerings.myec2_type :
  az => details.instance_types if length(details.instance_types) != 0 })) //for_each only allows set of strings or maps hence need to use a toset
  availability_zone = each.key
  # You can also use each.value because for list items each.key == each.value
  tags = {
    Name = "EC2 instance 1-${each.key}" //or each.value 
  }
}
