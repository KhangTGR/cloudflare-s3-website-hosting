terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.12.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.14.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
