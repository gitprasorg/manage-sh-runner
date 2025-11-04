variable "github_token" {
  description = "GitHub token with admin rights to orgs"
  type        = string
  sensitive   = true
}

variable "org_name" {
  description = "GitHub organization name"
  type        = string
}

variable "runner_groups" {
  description = "List of runner groups to manage"
  type = list(object({
    name           = string
    visibility     = string
    selected_repos = list(string)
  }))
}
