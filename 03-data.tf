data "aws_ec2_instance_types" "discovery" {
  filter {
    name   = "current-generation"
    values = ["true"]
  }
    filter {
        name = "processor-info.supported-architecture"
        values = ["x86_64"]
    }
    filter {
        name = "bare-metal"
        values = ["false"]
    }
  }

data "aws_ec2_instance_type" "details" {
  for_each      = toset(data.aws_ec2_instance_types.discovery.instance_types)
  instance_type = each.value
}

# output "supported_types" {
#   value = data.aws_ec2_instance_types.available.instance_types
# }
output "filtered_lab_instances" {
  value = {
    for type, details in data.aws_ec2_instance_type.details : type => {
      mem_gb     = details.memory_size / 1024
      vcpus      = details.default_vcpus
      arch       = join(", ", details.supported_architectures)
      storage_gb = details.total_instance_storage
    }
    if details.memory_size <= 16384 && details.default_vcpus <= 4
  }
}
# output "instance_catalog" {
#   value = {
#     for type, details in data.aws_ec2_instance_type.details : type => {
#       arch = join(", ", details.supported_architectures)
#       vcpus = details.default_vcpus
#       mem_gb = details.memory_size / 1024
#     }
#   }
# }

data "aws_regions" "available" {}

output "all_region_names" {
  value = data.aws_regions.available
}

data "aws_ami_ids" "redhat_ids" {
  owners      = ["309956199498"] # Official Red Hat Owner ID
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "redhat_details" {
  for_each = toset(data.aws_ami_ids.redhat_ids.ids)
  filter {
    name   = "image-id"
    values = [each.value]
  }
}
output "redhat_images" {
  value = {
    for ami in data.aws_ami.redhat_details : ami.name => {
      id           = ami.id
      architecture = ami.architecture
      description = ami.description
    }
  }
}
# output "instance_types" {
#   value = {
#     for type in [data.aws_ec2_instance_types.available] : type.name => {
#       id           = type.id
#     #   architecture = ami.architecture
#     }
#   }
# }