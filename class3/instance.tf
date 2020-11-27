# resource "aws_instance" "ubuntu" {
#   ami           = "${data.aws_ami.ubuntu.id}"
#   availability_zone = "${data.aws_availability_zones.available.names[3]}"
#   instance_type = "t3.micro"
#   tags = {
#     Name = "HelloWorld"
#   }
# }
# resource "aws_instance" "centos" {
#   ami           = "${data.aws_ami.centos.id}"
#   instance_type = "t3.micro"
#   tags = {
#     Name = "HelloWorld"
#   }
# }

