output PIP {
  value       = "${aws_instance.ubuntu.public_ip}"
  description = "This is the public_ip"
}
output keyname {
  value       = "${aws_key_pair.ubuntu.key_name}"
  description = "This is the keyname"
}
output DNS {
  value       = "${aws_route53_record.org.name}"
  description = "This is the A record DNS"
}
output AZ {
  value       = "${aws_instance.ubuntu.availability_zone}"
  description = "This is the AZ"
}


