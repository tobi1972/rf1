data "aws_availability_zones" "available" {
  state = "available"
}

output "az" {
  value = "${data.aws_availability_zones.available.names}"
}
output DNS {
  value       = "${aws_route53_record.www.name}"
  description = "This is the A record DNS"
}
output "nagiosxiadmin" {
  value = "john"
}

output "Jenkins_password" {
  value = "free"
}


