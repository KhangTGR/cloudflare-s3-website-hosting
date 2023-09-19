[![My Skills](https://skillicons.dev/icons?i=css,html,js,scss,aws,cloudflare,linux,bash,python&perline=9&theme=dark)](https://skillicons.dev)

# Connecting CloudFlare to S3 Bucket

![Architecture Diagram](diagram/diagram.png)

## **Purpose**

The purpose of this project is to **provision an S3 bucket** used for hosting a website. The website is configured to **only allow connections from CloudFlare IP addresses**. This is achieved using a **Lambda Function** that collects IPs from the CloudFlare API and updates the S3 bucket policy accordingly.

## **Requirements**

Before starting, ensure you have the following prerequisites installed and configured:

- **Terraform**: Install Terraform on your local machine. You can download it from the [official website](https://www.terraform.io/downloads.html).

- **AWS CLI (Version 2)**: Install the AWS Command Line Interface (CLI) version 2 on your local machine. You can download it from the [official website](https://aws.amazon.com/cli/).

- **AWS Configuration**: Configure your AWS credentials using the `aws configure` command to set up your AWS Access Key ID, Secret Access Key, default region, and output format. Ensure that your AWS CLI is properly authenticated. [Tutorial](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

- **CloudFlare Account**: You'll need a CloudFlare account with a purchased domain name. 

- **CloudFlare API Token**: Generate a CloudFlare API Token with the necessary permissions for your project. You can create a token by following the steps in the [CloudFlare API Token documentation](https://developers.cloudflare.com/api/tokens/create).

- **Ubuntu OS (Optional)**: Some commands may require UbuntuOS. While not strictly necessary, having UbuntuOS available can be beneficial for certain operations.

## **Instructions**

**1. Setup:**

- **Source code**: Place your static website source code in the `/source` folder, where it will be deployed to the S3 bucket. Ensure the 'index document' in the S3 configuration matches your source code. You can customize the path to the index.html file using the 'index_document' variable.

- **Creating `terraform.tfvars`**: Instead of customizing `main.tf`, create a `terraform.tfvars` file in the `/terraform` directory with the following content:

```hcl
# Required variables
cloudflare_api_token = "YOUR_CLOUDFLARE_API_TOKEN"
domain               = "YOUR_DOMAIN_NAME"
subdomain            = "YOUR_SUBDOMAIN"
region               = "YOUR_AWS_REGION"

# Optional variables
prefix              = "pynamo"
```

**2. CloudFlare Connection `(OPTIONAL)`:**

- Access the CloudFlare dashboard and navigate to DNS -> Records.
- Click 'Add record' and provide the following information:
  - Type: CNAME
  - Name: Your subdomain or '@' if you don't have a subdomain
  - Content: The value of the `website_url` output.
- Click 'Save.' Once done, search for the domain name, which is the `bucket_name` output value, to verify if it's working. Congratulations if it is!

**3. Clean:**

- In the root directory where the `clean.sh` script is located, simply run the script. Wait a few minutes for the resources to be cleaned up.
- Make sure to replace the placeholders in the `terraform.tfvars` section with your actual values.


## **Configuration Variables**

Here are the variables that can be configured in the `variables.tf` file:

| **Name**                                     | **Description**                                                                                                             | **Default Value**                                                                                    | **Type**   | **Required** |
| -------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ---------- | ------------ |
| `prefix`                                     | **A prefix to be added to resource names.**                                                                                 | ""                                                                                                   | **string** | **No**       |
| `profile`                                    | **AWS named profile** to use for authentication. This profile should be configured in your AWS CLI or SDK credentials file. | "default"                                                                                            | **string** | **No**       |
| `bucket_name`                                | **Name of the S3 bucket**                                                                                                   | `N/A`                                                                                                | **string** | **`Yes`**    |
| `region`                                     | **AWS region** where the S3 bucket will be created                                                                          | `N/A`                                                                                                | **string** | **`Yes`**    |
| `index_document`                             | **The name of the index document** for the S3 website                                                                       | "index.html"                                                                                         | **string** | **No**       |
| `error_document`                             | **The name of the error document** for the S3 website                                                                       | "error/index.html"                                                                                   | **string** | **No**       |
| `versioning_status`                          | **Enable or disable versioning** for the S3 bucket                                                                          | "Disabled"                                                                                           | **string** | **No**       |
| `object_ownership_rule`                      | **The object ownership setting** for the S3 bucket                                                                          | "BucketOwnerPreferred"                                                                               | **string** | **No**       |
| `block_public_acls_status`                   | **Block public ACLs** for the S3 bucket                                                                                     | false                                                                                                | **bool**   | **No**       |
| `block_public_policy_status`                 | **Block public bucket policies** for the S3 bucket                                                                          | false                                                                                                | **bool**   | **No**       |
| `ignore_public_acls_status`                  | **Ignore public ACLs** for the S3 bucket                                                                                    | false                                                                                                | **bool**   | **No**       |
| `restrict_public_buckets_status`             | **Restrict public access** to the S3 bucket                                                                                 | false                                                                                                | **bool**   | **No**       |
| `bucket_acl_status`                          | **The ACL (Access Control List)** for the S3 bucket                                                                         | "private"                                                                                            | **string** | **No**       |
| `lambda_function_name`                       | **Name of the Lambda function**                                                                                             | "UpdateCloudFlareIPsToS3Policy"                                                                      | **string** | **No**       |
| `lambda_function_description`                | **Description of the Lambda function**                                                                                      | "This Lambda function, named update-cloudflare-ips-to-s3-policy, is responsible for periodically..." | **string** | **No**       |
| `lambda_function_role`                       | **Name of the IAM role** associated with the Lambda function                                                                | "UpdateCloudFlareIPsToS3Policy-Role"                                                                 | **string** | **No**       |
| `lambda_function_role_policy_name`           | **Name of the IAM policy** attached to the Lambda function's role                                                           | "UpdateCloudFlareIPsToS3Policy-Role-Policy"                                                          | **string** | **No**       |
| `lambda_trigger_event_name`                  | **Name for the CloudWatch Event Rule that triggers the Lambda function.**                                                   | "lambda_scheduled_rule"                                                                              | **string** | **No**       |
| `lambda_trigger_event_description`           | **Description for the CloudWatch Event Rule that triggers the Lambda function.**                                            | "lambda_trigger_event_description"                                                                   | **string** | **No**       |
| `lambda_trigger_event_schedule_expression`   | **Schedule expression for the CloudWatch Event Rule that determines when the Lambda function is triggered.**                | "lambda_trigger_event_schedule_expression"                                                           | **string** | **No**       |
| `eventbridge_lambda_permission_statement_id` | **Statement ID for the Lambda function permission to be used with EventBridge.**                                            | "AllowExecutionFromEventBridge"                                                                      | **string** | **No**       |

## **License**

This static website is based on the Dimension template by [HTML5 UP](https://html5up.net/).

### **Creative Commons License**

All of the site templates I create for [HTML5 UP](https://html5up.net/) are licensed under the **Creative Commons Attribution 3.0 License**, which means you can:

- Use them for personal stuff
- Use them for commercial stuff
- Change them however you like

...all for free, yo. In exchange, just give HTML5 UP credit for the design and tell your friends about it =)

More info [here](https://html5up.net/license).
