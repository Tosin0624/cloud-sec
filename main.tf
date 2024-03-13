provider "aws" {
  region = var.aws_region
}

resource "aws_iam_role" "granularIAM_role" {
  name = "granularIAM-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "user_policy" {
  name        = "user_policy"
  policy      = file("${path.module}/policy.json")
}

resource "aws_iam_role_policy_attachment" "IAM_role_attachment" {
  role       = aws_iam_role.granularIAM_role.name
  policy_arn = aws_iam_policy.user_policy.arn
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-s3-bucket"
  acl    = "private"

  tags = {
    Name = "My terraform bucket"
  }
}
