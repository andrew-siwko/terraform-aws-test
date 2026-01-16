# This will update the dns records in my siwko.org domain for the new instances.
resource "linode_domain" "siwko_org" {
    type = "master"
    domain = "testdomainfortf.org"
    soa_email = "asiwko@siwko.org"
}

resource "linode_domain_record" "aws01_siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws01"
    record_type = "A"
    target = aws_instance.test_virtual_machine_01.public_ip
}

resource "linode_domain_record" "aws02_siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws02"
    record_type = "A"
    target = aws_instance.test_virtual_machine_02.public_ip
}