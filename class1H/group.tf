resource "aws_iam_group" "Infosec" {
  name = "Infosec"
  path = "/"
}
resource "aws_iam_group_membership" "Infosec" {
  name = "Infosec-group-membership"

  users = [
    "${aws_iam_user.Ron.name}",
    "${aws_iam_user.Sam.name}",
    "${aws_iam_user.Billy.name}",
  ]

  group = "${aws_iam_group.Infosec.name}"
}


resource "aws_iam_group_policy_attachment" "power" {
  group      = "${aws_iam_group.Infosec.name}",
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}


