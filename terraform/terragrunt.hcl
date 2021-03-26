locals {
  common        = yamldecode(file("./common.yaml"))
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "terraform-hackweek-${local.common.hackweek_name}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.common.aws_region
    encrypt        = true
    profile        = "default"
    dynamodb_table = "terraform-hackweek-${local.common.hackweek_name}-lock"

    s3_bucket_tags = {
      Name  = "Terraform ${local.common.hackweek_name} hackweek state storage"
      Hackweek = local.common.hackweek_name
      Owner = local.common.hackweek_owner
    }

    dynamodb_table_tags = {
      Name  = "Terraform ${local.common.hackweek_name} hackweek lock table"
      Hackweek = local.common.hackweek_name
      Owner = local.common.hackweek_owner
    }
  }
}