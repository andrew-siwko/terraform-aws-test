# This will update the dns records in my siwko.org domain for the new instances.
resource "linode_domain" "siwko_org" {
    type = "master"
    domain = "siwko.org"
    soa_email = "asiwko@siwko.org"
}

resource "linode_domain_record" "siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws-01"
    record_type = "A"
    target = aws_instance.test_virtual_machine_01.*.public_ip
}

resource "linode_domain_record" "siwko_org" {
    domain_id = linode_domain.siwko_org.id
    name = "aws-02"
    record_type = "A"
    target = aws_instance.test_virtual_machine_02.*.public_ip
}