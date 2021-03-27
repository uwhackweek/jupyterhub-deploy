locals {
  common = yamldecode(file(find_in_parent_folders("common.yaml")))
}

include {
  path = find_in_parent_folders()
}

inputs = {
  region = local.common.aws_region
  hackweek_name = local.common.hackweek_name
}