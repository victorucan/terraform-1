terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "us-east-2"
  access_key = AKIASB2NMKIWDW23SSW5
  secret_key = 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
}