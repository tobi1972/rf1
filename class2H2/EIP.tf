resource "aws_eip" "centos6" {
  vpc      = "true"
  tags = {
      Name = "centos6"
  }
}
resource "aws_eip_association" "ass" {
  instance_id   = "${aws_instance.centos6.id}"
   allocation_id = "${aws_eip.centos6.id}"
}