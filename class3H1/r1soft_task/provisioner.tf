resource "aws_instance" "provisioner" {
  ami           = "${data.aws_ami.centos.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.r1soft.id}"]
  key_name = "${aws_key_pair.class3H.key_name}"
  tags = {
    Name = "r1soft"
  }
}

resource "null_resource" "remote" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = "${file("~/.ssh/id_rsa")}"
      host        = "${aws_instance.provisioner.public_ip}"
    }

    source      = "r1soft.repo"
    destination = "/tmp/r1soft.repo"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = "${file("~/.ssh/id_rsa")}"
      host        = "${aws_instance.provisioner.public_ip}"
    }

    inline = [
      "sudo mv /tmp/r1soft.repo /etc/yum.repos.d/",
      "sudo yum install serverbackup-enterprise -y ",
      "sudo serverbackup-setup --user john --pass jbnl",
      "sudo /etc/init.d/cdp-server start",
      "sudo serverbackup-setup --http-port 80 --https-port 443",
      "sudo /etc/init.d/cdp-server restart",
    ]
  }
}
