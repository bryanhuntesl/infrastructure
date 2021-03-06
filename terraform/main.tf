terraform {
  backend "s3" {
    bucket = "aeternity-terraform-states"
    key    = "aeternitystate.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  version = "1.24"
  region  = "ap-southeast-1"
  alias   = "ap-southeast-1"
}

provider "aws" {
  version = "1.24"
  region  = "eu-central-1"
  alias   = "eu-central-1"
}

provider "aws" {
  version                 = "1.24"
  region                  = "us-west-2"
  alias                   = "us-west-2"
  shared_credentials_file = "/aws/credentials"
  profile                 = "aeternity"
}

module "aws_deploy-ap-southeast-1" {
  source = "modules/cloud/aws/deploy"
  env    = "uat"
  color  = "blue"

  static_nodes = 1
  spot_nodes   = 9

  spot_price    = "0.125"
  instance_type = "m4.large"

  epoch = {
    package = "https://s3.eu-central-1.amazonaws.com/aeternity-epoch-releases/epoch-latest-ubuntu-x86_64.tar.gz"
  }

  providers = {
    aws = "aws.ap-southeast-1"
  }
}

module "aws_deploy-eu-central-1" {
  source = "modules/cloud/aws/deploy"
  env    = "uat"
  color  = "blue"

  static_nodes = 1
  spot_nodes   = 9

  spot_price    = "0.125"
  instance_type = "m4.large"

  epoch = {
    package = "https://s3.eu-central-1.amazonaws.com/aeternity-epoch-releases/epoch-latest-ubuntu-x86_64.tar.gz"
  }

  providers = {
    aws = "aws.eu-central-1"
  }
}

module "aws_deploy-us-west-2" {
  source = "modules/cloud/aws/deploy"
  env    = "uat"
  color  = "green"

  static_nodes = 1
  spot_nodes   = 9

  spot_price    = "0.125"
  instance_type = "m4.large"

  epoch = {
    package = "https://s3.eu-central-1.amazonaws.com/aeternity-epoch-releases/epoch-latest-ubuntu-x86_64.tar.gz"
  }

  providers = {
    aws = "aws.us-west-2"
  }
}
