# GitHub repository management
resource "github_repository" "managed_repos" {
  for_each = var.enable_claude_for_all_repos ? toset(var.github_repositories) : toset([])

  name        = each.value
  description = lookup(var.repository_descriptions, each.value, "Managed by Terraform")

  # Repository settings
  visibility             = lookup(var.repository_visibility, each.value, "public")
  has_issues             = true
  has_discussions        = lookup(var.repository_discussions, each.value, false)
  has_projects           = lookup(var.repository_projects, each.value, false)
  has_wiki               = lookup(var.repository_wiki, each.value, false)
  is_template            = false
  delete_branch_on_merge = lookup(var.repository_delete_branch_on_merge, each.value, true)
  auto_init              = false

  # Security settings
  vulnerability_alerts = true

  # Merge settings
  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
  allow_auto_merge   = lookup(var.repository_allow_auto_merge, each.value, false)

  # Archive setting
  archived = false

  lifecycle {
    # Prevent accidental deletion of repositories
    prevent_destroy = true

    # Ignore changes to certain attributes that might be managed outside Terraform
    ignore_changes = [
      auto_init,
      has_downloads,
    ]
  }
}

# GitHub repository branch protection
resource "github_branch_protection" "main" {
  for_each = var.enable_branch_protection ? github_repository.managed_repos : {}

  repository_id = each.value.node_id
  pattern       = "main"

  # Require PR reviews
  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = false
    required_approving_review_count = 1
  }

  # Require status checks
  required_status_checks {
    strict   = true
    contexts = lookup(var.required_status_checks, each.key, [])
  }

  # Enforce admins
  enforce_admins = false

  # Restrict who can push
  allows_deletions    = false
  allows_force_pushes = false
}