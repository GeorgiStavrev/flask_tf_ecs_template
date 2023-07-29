# Used for storing API keys for other services using the API
resource "aws_dynamodb_table" "apikeys" {
  name         = "${var.name}-APIKeys"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ACCESS_KEY_ID"

  attribute {
    name = "ACCESS_KEY_ID"
    type = "S"
  }
}

# Used for storing pregenerated text content for users
resource "aws_dynamodb_table" "pregenerated_content" {
  name         = "${var.name}-PregeneratedUserContent"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "TypeDate"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "TypeDate"
    type = "S"
  }
}