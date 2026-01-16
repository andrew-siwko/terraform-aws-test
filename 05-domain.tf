# This will update the dns records in my siwko.org domain for the new instances.
resource "linode_domain" "siwko_org" {
    type = "master"
    domain = "siwko.org"
    soa_email = "asiwko@siwko.org"
    refresh_sec = 300
    retry_sec   = 300
    ttl_sec     = 300
}

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

