resource "aws_instance" "nagiosxi" {
  ami           = "${data.aws_ami.centos.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  associate_public_ip_address = true
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.nagiosxi.id}"]
  key_name = "${aws_key_pair.nagiosxi.key_name}"
  tags = {
    Name = "nagiosxi"
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
      host        = "${aws_instance.nagiosxi.public_ip}"
    }

    inline = [
    "sudo yum install https://repo.nagios.com/nagios/7/nagios-repo-7-4.el7.noarch.rpm -y",
    "sudo yum install epel-release nagiosxi net-snmp  -y",
    "sudo systemctl start snmpd",
    "sudo rsync -a /etc/snmp/snmpd.conf /tmp/snmpd.conf.dist",
    "sudo echo -e 'rocommunity public \nsyslocation here \nsyscontact root@localhost' > /tmp/snmpd.conf",
    "sudo mv /tmp/snmpd.conf  /etc/snmp/",
    "sudo snmpwalk -v 1 -c public -O e 127.0.0.1",
    ]

  }
}
