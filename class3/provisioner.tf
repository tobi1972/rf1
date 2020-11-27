resource "aws_instance" "provisioner" {
  ami           = "${data.aws_ami.ubuntu.id}"
  availability_zone = "${data.aws_availability_zones.available.names[3]}"
  associate_public_ip_address = true
  instance_type = "t3.micro"
  key_name = "${aws_key_pair.class.key_name}"
  
  provisioner "remote-exec" {
    connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
    host     = "${aws_instance.provisioner.public_ip}"
  }
    inline = [
      "sudo apt-get install apache2 -y",
      "sudo systemctl start apache2",
    ]
  }

  provisioner "file" {
    connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
    host     = "${aws_instance.provisioner.public_ip}"
  }
    source      = "README.md"
    destination = "/tmp/README.md"
  }
}