resource "aws_instance" "web" {
	ami = "ami-02354e95b39ca8dec"
	instance_type = "t2.micro"
    associate_public_ip_address = "true"
    key_name = "${aws_key_pair.class.key_name}"
    user_data = "${file("userdata_file.sh")}"
    vpc_security_group_ids = ["${aws_security_group.class2.id}"]
    availability_zone = "us-east-1a"
}

resource "aws_ebs_volume" "example" {
availability_zone = "us-east-1a"
size = 100
}

resource "aws_volume_attachment" "ebs_att" {
device_name = "/dev/sdh"
volume_id = "${aws_ebs_volume.example.id}"
instance_id = "${aws_instance.web.id}"
}