# ==================================
#   Project general Configuration
# ==================================
variable "prefix" {
  description = "A prefix to be added to resource names."
  type        = string
  default     = ""
}

variable "domain" {
  description = "The primary domain for which DNS records will be managed in CloudFlare."
  type        = string
}

variable "subdomain" {
  description = "The optional subdomain for which DNS records will be created. Leave it blank or set to null if you don't want to specify a subdomain."
  type        = string
  default     = ""
}



# ==================================
#   AWS Credentials Configuration
# ==================================
variable "profile" {
  description = "AWS named profile to use for authentication. This profile should be configured in your AWS CLI or SDK credentials file."
  type        = string
  default     = "default"
}



# ============================
#   S3 Bucket Configuration
# ============================
variable "region" {
  description = "AWS region where the S3 bucket will be created"
  type        = string
}

variable "index_document" {
  description = "The name of the index document for the S3 website"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "The name of the error document for the S3 website"
  type        = string
  default     = "error/index.html"
}

variable "versioning_status" {
  description = "Enable or disable versioning for the S3 bucket"
  type        = string
  default     = "Disabled"
}

variable "object_ownership_rule" {
  description = "The object ownership setting for the S3 bucket"
  type        = string
  default     = "BucketOwnerPreferred"
}

variable "block_public_acls_status" {
  description = "Block public ACLs for the S3 bucket"
  type        = bool
  default     = false
}

variable "block_public_policy_status" {
  description = "Block public bucket policies for the S3 bucket"
  type        = bool
  default     = false
}

variable "ignore_public_acls_status" {
  description = "Ignore public ACLs for the S3 bucket"
  type        = bool
  default     = false
}

variable "restrict_public_buckets_status" {
  description = "Restrict public access to the S3 bucket"
  type        = bool
  default     = false
}

variable "bucket_acl_status" {
  description = "The ACL (Access Control List) for the S3 bucket"
  type        = string
  default     = "private"
}



# ==================================
#   Lambda Function Configuration
# ==================================
variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "UpdateCloudFlareIPsToS3Policy"
}

variable "lambda_function_description" {
  description = "Description of the Lambda function"
  type        = string
  default     = "This Lambda function, named update-cloudflare-ips-to-s3-policy, is responsible for periodically updating the access policy of an Amazon S3 bucket to grant public read access to objects within the bucket based on CloudFlare's IP address ranges."
}

variable "lambda_function_role" {
  description = "Name of the IAM role associated with the Lambda function"
  type        = string
  default     = "UpdateCloudFlareIPsToS3Policy-Role"
}

variable "lambda_function_role_policy_name" {
  description = "Name of the IAM policy attached to the Lambda function's role"
  type        = string
  default     = "UpdateCloudFlareIPsToS3Policy-Role-Policy"
}

variable "lambda_trigger_event_name" {
  type        = string
  default     = "LambdaScheduledRule"
  description = "Name for the CloudWatch Event Rule that triggers the Lambda function."
}

variable "lambda_trigger_event_description" {
  type        = string
  default     = "lambda_trigger_event_description"
  description = "Description for the CloudWatch Event Rule that triggers the Lambda function."
}

variable "lambda_trigger_event_schedule_expression" {
  type        = string
  default     = "rate(30 days)"
  description = "Schedule expression for the CloudWatch Event Rule that determines when the Lambda function is triggered."
}

variable "eventbridge_lambda_permission_statement_id" {
  type        = string
  default     = "AllowExecutionFromEventBridge"
  description = "Statement ID for the Lambda function permission to be used with EventBridge."
}



# =============================
#   CloudFlare Configuration
# =============================
variable "cloudflare_api_token" {
  description = "The CloudFlare API token used to authenticate and manage DNS records for the specified domain."
  type        = string
}
