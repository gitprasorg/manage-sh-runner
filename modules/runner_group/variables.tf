variable "org_name" {
  type        = string
  description = "Organization name"
}

variable "runner_groups" {
  type = list(object({
    name           = string
    visibility     = string
    selected_repos = list(string)
  }))
  description = "Runner group definitions"
}
