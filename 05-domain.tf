# This will update the dns records in my siwko.org domain for the new instances.
resource "linode_domain" "siwko_org" {
    type = "master"
    domain = "siwko.org"
    soa_email = "asiwko@siwko.org"
    refresh_sec = 300
    retry_sec   = 300
    ttl_sec     = 300
}
# command to import the domain
# terraform import linode_domain.siwko_org 1228113
# Records for the public IP addresses.
resource "linode_domain_record" "aws01_siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws01"
    record_type = "A"
    ttl_sec = 5
    target = aws_instance.test_virtual_machine_01.public_ip
}

resource "linode_domain_record" "aws02_siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws02"
    record_type = "A"
    ttl_sec = 5
    target = aws_instance.test_virtual_machine_02.public_ip
}

# Let's add records for the local subnet as well as for
# the public IPs.

resource "linode_domain_record" "aws01p_siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws01p"
    record_type = "A"
    ttl_sec = 5
    target = aws_instance.test_virtual_machine_01.private_ip
}

resource "linode_domain_record" "aws02p_siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws02p"
    record_type = "A"
    ttl_sec = 5
    target = aws_instance.test_virtual_machine_02.private_ip
}


# additional RHEL machines

resource "linode_domain_record" "aws03_siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws03"
    record_type = "A"
    ttl_sec = 5
    target = aws_instance.test_virtual_machine_03.public_ip
}

resource "linode_domain_record" "aws04_siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws04"
    record_type = "A"
    ttl_sec = 5
    target = aws_instance.test_virtual_machine_04.public_ip
}
