# We will make it fully dynamic in this version 3 of the Utility tool

# Get list of az in a specific region
# Region is set in c1-version.tf in provider block
# Datasource-1
data "aws_availability_zones" "my-az" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}




# Datasource-2
# Check if that respective instance type is supported in that specific region inlist of availability zones
# Get the list of az in a particular region where that respoective instance type 
data "aws_ec2_instance_type_offerings" "myec2_type" {
  for_each = toset(data.aws_availability_zones.my-az.names) //has to be converted to a SET since for_each only accepts a map sets/
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }

  filter {
    name   = "location"
    values = [each.value] //can do each.key or each.value same thing
  }
  location_type = "availability-zone"
}


# Output-1
# Basic output: all az zones mapped to supported instance types
output "output_v3_1" {
  value = { for az, details in data.aws_ec2_instance_type_offerings.myec2_type : az => details.instance_types
  }
}

# Output-2
# Filtered ouput: exclude unsupported availability zones, length 0 are the ones that are unsupported
output "output_v3_2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.myec2_type :
  az => details.instance_types if length(details.instance_types) != 0 } //length not = zero show me
}

# Output-3
#  Filtered ouput: with keys function - which gets keys from a map - only show me the keys not the values i.g. not the instance type
output "output_v3_3" {
  value = keys({ for az, details in data.aws_ec2_instance_type_offerings.myec2_type :
  az => details.instance_types if length(details.instance_types) != 0 })
}

# Output-4
# Filtered output: as the output is list a list now, get the first item from the list (extra learning activity)
output "output_v3_4" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.myec2_type :
  az => details.instance_types if length(details.instance_types) != 0 })[0] //since the output is a list we can say we want [0]
}