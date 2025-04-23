module "atlantis-role" {
  source = "../../modules/iam/atlantis-role"
}

resource "aws_iam_instance_profile" "atlantis_profile" {
  name = "atlantis-instance-profile"
  role = module.atlantis-role.name
}