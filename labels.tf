# Repository Labels
resource "github_issue_label" "labels" {
  for_each = var.manage_labels ? merge([
    for repo in var.github_repositories : {
      for label_key, label in var.repository_labels :
      "${repo}:${label_key}" => merge(label, { repository = repo })
    }
  ]...) : {}
  
  repository  = each.value.repository
  name        = each.value.name
  color       = each.value.color
  description = lookup(each.value, "description", null)
}

# Variables for labels
variable "manage_labels" {
  description = "Whether to manage repository labels"
  type        = bool
  default     = false
}

variable "repository_labels" {
  description = "Map of labels to apply to repositories"
  type = map(object({
    name        = string
    color       = string
    description = optional(string)
  }))
  default = {
    bug = {
      name        = "bug"
      color       = "d73a4a"
      description = "Something isn't working"
    }
    documentation = {
      name        = "documentation"
      color       = "0075ca"
      description = "Improvements or additions to documentation"
    }
    duplicate = {
      name        = "duplicate"
      color       = "cfd3d7"
      description = "This issue or pull request already exists"
    }
    enhancement = {
      name        = "enhancement"
      color       = "a2eeef"
      description = "New feature or request"
    }
    good_first_issue = {
      name        = "good first issue"
      color       = "7057ff"
      description = "Good for newcomers"
    }
    help_wanted = {
      name        = "help wanted"
      color       = "008672"
      description = "Extra attention is needed"
    }
    invalid = {
      name        = "invalid"
      color       = "e4e669"
      description = "This doesn't seem right"
    }
    question = {
      name        = "question"
      color       = "d876e3"
      description = "Further information is requested"
    }
    wontfix = {
      name        = "wontfix"
      color       = "ffffff"
      description = "This will not be worked on"
    }
  }
}