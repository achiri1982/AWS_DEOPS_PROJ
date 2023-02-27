resource "aws_dynamodb_table" "dynamodb-tf-state-lock" {
  name           = "dynamo-tf-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }


  tags = {
    terraform   = "true"
    Name        = "${var.name}-dynamodb-tf-state-lock"
    environment = "${var.environment["dev"]}"
  }
}