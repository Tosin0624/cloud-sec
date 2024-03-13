output "iam_role_name" {
  value = aws_iam_role.granularIAM_role.name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.humber_cloudsec_s3_bucket.bucket
}
