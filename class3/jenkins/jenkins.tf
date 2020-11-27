resource "aws_instance" "centos" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t3.large"
  vpc_security_group_ids = ["${aws_security_group.class2.id}"]
  key_name = "${aws_key_pair.class.key_name}"
  tags = {
    Name = "HelloWorld"
  }
}

resource "null_resource" "remote" {
   triggers = {
    always_run = "${timestamp()}"
    }   
    provisioner "remote-exec" {
        connection {
        type     = "ssh"
        user     = "ubuntu"
        private_key = "${file("~/.ssh/id_rsa")}"
        host     = "${aws_instance.centos.public_ip}"
    }
        inline = [
            "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
            "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
            "sudo yum upgrade -y",
            "sudo yum install jenkins java-1.8.0-openjdk-devel -y",
            "sudo systemctl daemon-reload",
        ]
    }
}