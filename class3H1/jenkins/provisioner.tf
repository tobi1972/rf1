resource "aws_instance" "jenkins" {
  ami           = "${data.aws_ami.centos.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
  key_name = "${aws_key_pair.jenkins.key_name}"
  tags = {
    Name = "jenkins"
  }
}

resource "null_resource" "remote" {
  triggers = {
    always_run = "${timestamp()}"
  }
  
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = "${file("~/.ssh/id_rsa")}"
      host        = "${aws_instance.jenkins.public_ip}"
    }

    inline = [
      "sudo yum install wget unzip -y",
   "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo",
        "sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key",
        "sudo yum upgrade -y",
        "sudo yum install jenkins java-1.8.0-openjdk-devel -y",
        "sudo systemctl daemon-reload",
        "sudo systemctl start jenkins"
    ]
  }
}
