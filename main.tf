module "runner_group" {
  source = "./modules/runner_group"

  org_name      = var.org_name
  runner_groups = var.runner_groups
}
