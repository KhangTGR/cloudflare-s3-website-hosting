#!/bin/bash

# Description: This script destroys the AWS resources provisioned by Terraform for the current project. 
# It retrieves the S3 bucket name from Terraform output, deletes all objects in the bucket, and then runs 'terraform destroy' with the '-auto-approve' option to automatically confirm the destruction of resources.

echo "Destroying Terraform-managed resources..."

cd ../terraform
# Retrieve the S3 bucket name from Terraform output
bucket_name=$(terraform output -raw bucket_name)

# Check if bucket_name is empty
if [ -z "$bucket_name" ]; then
    echo "Error: Failed to retrieve the S3 bucket name from Terraform output."
    exit 1
fi

# Remove all objects in the S3 bucket
aws s3 rm s3://$bucket_name --recursive

# Run 'terraform destroy' to destroy AWS resources
terraform destroy -auto-approve

echo "Script completed."
