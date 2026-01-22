# This will update the dns records in my siwko.org domain for the new instances.

resource "linode_domain" "siwko_org" {
    type = "master"
    domain = "siwko.org"
    soa_email = "asiwko@siwko.org"
    refresh_sec = 30
    retry_sec   = 30
    ttl_sec     = 30
}
# command to import the domain
# Records for the public IP addresses.

# use this once to get the zone into the state file
# terraform import linode_domain.siwko_org 1228113

# one record for the virtual machine
resource "linode_domain_record" "aws01_siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws01"
    record_type = "A"
    ttl_sec = 5
    target = aws_instance.virtual_machine_01.public_ip
}

# one record for the private address
resource "linode_domain_record" "aws01p_siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws01p"
    record_type = "A"
    ttl_sec = 5
    target = aws_instance.virtual_machine_01.private_ip
}

