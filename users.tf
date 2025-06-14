# Data source for current authenticated user
data "github_user" "current" {
  username = ""  # Empty string gets the current authenticated user
}

# Organization information variable (to avoid permission issues)
# We'll use variables instead of data source for organization info
locals {
  organization_info = {
    login       = var.github_owner
    name        = var.organization_name
    description = var.organization_description
  }
}

# Data source for specific users
data "github_user" "users" {
  for_each = toset(var.github_users)
  username = each.value
}

# Organization membership management
# Note: Managing org membership requires org owner permissions
resource "github_membership" "org_members" {
  for_each = var.manage_org_members ? toset(var.github_users) : toset([])
  
  username = each.value
  role     = lookup(var.github_user_roles, each.value, "member")
}

# Repository collaborators
resource "github_repository_collaborator" "repo_collaborators" {
  for_each = var.manage_repo_collaborators ? merge([
    for repo in var.github_repositories : {
      for user in var.repository_collaborators[repo] : 
      "${repo}:${user}" => {
        repository = repo
        username   = user
        permission = lookup(var.repository_collaborator_permissions["${repo}:${user}"], "permission", "pull")
      }
      if contains(keys(var.repository_collaborators), repo)
    }
  ]...) : {}
  
  repository = each.value.repository
  username   = each.value.username
  permission = each.value.permission
}

# Teams (if needed in the future)
resource "github_team" "teams" {
  for_each = var.manage_teams ? var.github_teams : {}
  
  name        = each.key
  description = each.value.description
  privacy     = each.value.privacy
}

# Team memberships
resource "github_team_membership" "team_members" {
  for_each = var.manage_teams ? merge([
    for team_name, team in var.github_teams : {
      for member in team.members :
      "${team_name}:${member}" => {
        team_id  = github_team.teams[team_name].id
        username = member
        role     = lookup(team.member_roles, member, "member")
      }
    }
  ]...) : {}
  
  team_id  = each.value.team_id
  username = each.value.username
  role     = each.value.role
}