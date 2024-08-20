terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.62.0" //if not define will use latest version of aws in terraform registry
    }
  }
}


provider "aws" {
  //aws account
  //IAM user
  profile = "terraform-sandbox"  //using terra
  region = "ap-southeast-1" //if not set, will use define region in ~/.aws/config

  //access key -> ~/.aws/credetials [terraform-sandbox]
  //secrect access key -> > ~/.aws/credetials [terraform-sanbox]
  

}