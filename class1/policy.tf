resource "aws_iam_policy" "policy" {
  name        = "test_policy3"
  path        = "/"
  description = "My test policy"

  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Sid": "VisualEditor0",
"Effect": "Allow",
"Action": "ec2:*",
"Resource": "*"
}
]
}
EOF
}
