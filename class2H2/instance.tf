resource "aws_instance" "centos6" {
	ami = "ami-e3fdd999"
	instance_type = "t2.micro"
    associate_public_ip_address = "true"
    iam_instance_profile = "${aws_iam_instance_profile.admin.name}"
    key_name = "aws_bastion"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Centos6"
        Enviroment = "Dev"
    }
}
resource "aws_iam_role_policy_attachment" "ec2_attach" {
  role       = "${aws_iam_role.ec2_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

}
resource "aws_volume_attachment" "ebs_att" {
device_name = "/dev/sdi"
volume_id = "${aws_ebs_volume.centos6.id}"
instance_id = "${aws_instance.centos6.id}"
}