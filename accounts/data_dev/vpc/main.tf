resource "aws_s3_bucket" "example" {
  bucket = "my-example-bucket200244"
  acl    = "private"

  tags = {
    Name        = "My example bucket"
    Environment = "Dev"
  }
}