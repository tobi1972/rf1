resource "aws_s3_bucket" "john_oshikoya" {
  bucket = "johnoshikoy"
  
  tags = {
    Name       = "My_bucket"
    Enviroment = "Dev"
    acl        = "private"
  }

  versioning {
    enabled = true
  }
}
