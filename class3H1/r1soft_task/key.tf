resource "aws_key_pair" "class3H" {
  key_name   = "r1soft"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
