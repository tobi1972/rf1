resource "aws_key_pair" "ubuntu" {
	key_name = "ubuntu_key"
	public_key = "${file("~/.ssh/id_rsa.pub")}"
}
