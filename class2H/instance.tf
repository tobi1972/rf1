resource "aws_instance" "Ubuntu" {
	ami = ""
	instance_type = "t2.micro"
    associate_public_ip_address = "true"
    key_name = "${}"
    user_data = "${file("userdata.sh")}"
    vpc_security_group_ids = ["${}"]
    tags ={
        Name = Ubuntu
    }