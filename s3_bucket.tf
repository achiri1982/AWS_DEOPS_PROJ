resource "aws_s3_bucket" "demomy-s3-bucket" {
  bucket = "${var.name}my-s3-bucket"

  tags = {
    terraform = "true"
    Name      = "${var.name}my-s3-bucket"
  }
}

resource "aws_s3_bucket_acl" "demo-s3-bucket-acl" {
  bucket = aws_s3_bucket.demomy-s3-bucket.id
  acl    = "private"
}


#Bucket Policy
resource "aws_s3_bucket_policy" "allow_access_for_user" {
  bucket = aws_s3_bucket.demomy-s3-bucket.id
  policy = data.aws_iam_policy_document.allow_access_for_user.json
}

data "aws_iam_policy_document" "allow_access_for_user" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::250659921336:user/achiri"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.demomy-s3-bucket.arn,
      "${aws_s3_bucket.demomy-s3-bucket.arn}/*",
    ]
  }
}