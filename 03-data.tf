data "aws_ec2_instance_types" "discovery" {
  filter {
    name   = "current-generation"
    values = ["true"]
  }
}

data "aws_ec2_instance_type" "details" {
  for_each      = toset(data.aws_ec2_instance_types.discovery.instance_types)
  instance_type = each.value
}

output "supported_types" {
  value = data.aws_ec2_instance_types.available.instance_types
}


data "aws_regions" "available" {}

output "all_region_names" {
  value = data.aws_regions.available
}


data "aws_ami" "rhel9" {
  most_recent = true
  owners      = ["309956199498"] # Official Red Hat Owner ID

}


output "RHEL_images" {
  value = {
    for ami in [data.aws_ami.rhel9] : ami.name => {
      id           = ami.id
      architecture = ami.architecture
    }
  }
}

output "instance_types" {
  value = {
    for type in [data.aws_ec2_instance_types.available] : type.name => {
      id           = type.id
    #   architecture = ami.architecture
    }
  }
}