provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "source_bucket" {
  bucket = "image-source-bucket"
  lifecycle{
  prevent_destroy = false
  }
}

resource "aws_s3_bucket" "processed_bucket" {
  bucket = "image-processed-bucket"
   lifecycle{
  prevent_destroy = false
  }
}

resource "aws_lambda_function" "image_processor" {
  function_name    = "image_processor"
  role            = aws_iam_role.lambda_role.arn
  handler        = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  filename      = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")
}

resource "aws_s3_bucket_notification" "s3_notification" {
  bucket = aws_s3_bucket.source_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.image_processor.arn
    events             = ["s3:ObjectCreated:*"]
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": { "Service": "lambda.amazonaws.com" },
    "Action": "sts:AssumeRole"
  }]
}
EOF
}

resource "aws_iam_policy_attachment" "lambda_s3_policy" {
  name       = "lambda_s3_policy"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
