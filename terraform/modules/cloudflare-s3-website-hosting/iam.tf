resource "aws_iam_role" "lambda_execution_role" {
  name = var.prefix != "" ? "${var.prefix}-${var.lambda_function_role}" : var.lambda_function_role

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_function_policy" {
  name        = var.prefix != "" ? "${var.prefix}-${var.lambda_function_role_policy_name}" : var.lambda_function_role_policy_name
  path        = "/"
  description = "Basic IAM Policy for Lambda"

  policy = <<EOF
{
    "Statement": [
        {
            "Sid": "AllowCloudWatchLogs",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Sid": "AllowS3BucketPolicyUpdate",
            "Effect": "Allow",
            "Action": [
                "s3:PutBucketPolicy"
            ],
            "Resource": [
                "arn:aws:s3:::${local.bucket_name}"
            ]
        }
    ],
    "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_function_policy.arn
}
