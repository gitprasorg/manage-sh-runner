# Repo lookup
data "github_repository" "repo" {
  for_each  = toset(flatten([for g in var.runner_groups : g.selected_repos]))
  full_name = "${var.org_name}/${each.key}"
}

# Create or manage runner group
resource "github_actions_runner_group" "group" {
  for_each = { for g in var.runner_groups : g.name => g }

  name       = each.value.name
  visibility = each.value.visibility

  selected_repository_ids = [
    for repo_name in each.value.selected_repos :
    data.github_repository.repo[repo_name].repo_id
  ]
}
