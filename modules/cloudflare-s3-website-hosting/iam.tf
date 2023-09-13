# Define an IAM role for the Lambda function.
resource "aws_iam_role" "lambda_role" {
  name = var.lambda_function_role

  # Define the permissions policy for assuming the Lambda role.
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

# Define an IAM policy for the Lambda function.
resource "aws_iam_policy" "lambda_policy" {
  name        = var.lambda_function_role_policy_name
  path        = "/"
  description = "Basic IAM Policy for Lambda"

  # Define the permissions policy for the Lambda function.
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
                "arn:aws:s3:::${var.bucket_name}"
            ]
        }
    ],
    "Version": "2012-10-17"
}
EOF
}

# Attach the IAM policy to the IAM role.
resource "aws_iam_role_policy_attachment" "policy_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
