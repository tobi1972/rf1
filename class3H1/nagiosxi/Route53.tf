resource "aws_route53_record" "www" {
  zone_id = "Z072691037T3UF5W6Z7KL"
  name    = "www.johnoshikoya.com"
  type    = "A"
  ttl     = "5"
  records = ["${aws_instance.nagiosxi.public_ip}"]
}