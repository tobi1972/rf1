resource "aws_key_pair" "class" {
	key_name = "jenkins"
	public_key = "${file("~/.ssh/id_rsa.pub")}"
}
