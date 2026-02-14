data "aws_ec2_instance_types" "available" {
}

output "supported_types" {
  value = data.aws_ec2_instance_types.available.instance_types
}


data "aws_regions" "available" {}

output "all_region_names" {
  value = data.aws_regions.available.names
}


data "aws_ami" "rhel9" {
  most_recent = true
  owners      = ["309956199498"] # Official Red Hat Owner ID

}


output "RHEL_images" {
  value = data.aws_ami.rhel9
}
