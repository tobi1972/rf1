resource "aws_key_pair" "nagiosxi" {
  key_name   = "nagiosxi"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
