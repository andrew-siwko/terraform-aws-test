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

output "filtered_lab_instances" {
  value = [
    for type, details in data.aws_ec2_instance_type.details:
    format("%s: mem_gb=%v, vcpus=%v", type, details.memory_size / 1024, details.default_vcpus)
    if details.memory_size <= 1024 && details.default_vcpus <= 2
  ]
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
  value = sort([
    for ami in data.aws_ami.redhat_details:
    format("%s: %s", ami.name, ami.id)
    if strcontains(ami.name,"9.7")
  ])
}
