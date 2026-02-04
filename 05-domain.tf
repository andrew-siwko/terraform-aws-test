# I use this once to get the siwko.org zone into the state file
# terraform import linode_domain.siwko_org 1228113

# This will update the dns records in my siwko.org domain for the new instances.
resource "linode_domain" "siwko_org" {
    type = "master"
    domain = "siwko.org"
    soa_email = "asiwko@siwko.org"
    refresh_sec = 30
    retry_sec   = 30
    ttl_sec     = 30
}

# one record for the virtual machine
resource "linode_domain_record" "aws01_siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws01"
    record_type = "A"
    ttl_sec = 5
    target = aws_instance.virtual_machine_01.public_ip
}
