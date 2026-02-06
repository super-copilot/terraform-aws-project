terraform {
  # prod 环境使用远端状态（S3 + DynamoDB）
  backend "s3" {}
}
