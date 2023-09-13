#!/bin/bash

# Description: This script initializes and applies a Terraform configuration to provision an S3 bucket for website hosting.
# It also syncs the current directory with the specified S3 bucket.

# Main script
echo "Initializing and applying Terraform configuration..."
terraform init
terraform apply -auto-approve

# Get the S3 bucket name from the Terraform output
bucket_name=$(terraform output -raw bucket_name)

# Check if bucket_name is empty
if [ -z "$bucket_name" ]; then
    echo "Error: Failed to retrieve the S3 bucket name from Terraform output."
    exit 1
fi

# Sync the current directory with the specified S3 bucket
cd source
echo "Syncing the source code directory with the S3 bucket: $bucket_name"
aws s3 sync . "s3://$bucket_name" --delete

echo "Script completed."
