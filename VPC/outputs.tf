output "vpc_id"{
  description = "vpc_id"
  value = aws_vpc.main.id
}
output "private_subnet_ids"{
  description = "private_subnet_ids"
  value = aws_subnet.private[*].id
}
output "public_subnet_ids"{
  description = "public_subnet_ids"
  value = aws_subnet.public[*].id
}

output "source_bucket"{
  description = "source_bucket"
  value = aws_s3_bucket.source_bucket.bucket
}

output "processed_bucket "{
  description = "processed_bucket"
  value = aws_s3_bucket.processed_bucket.bucket
}

output "lambda_function_name"{
  description = "lambda_function"
  value = aws_lambda_function.image_processor.function_name
}
