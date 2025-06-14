output "github_repository_secrets" {
  description = "Map of repository names to their Anthropic API secret names"
  value = {
    for repo, secret in github_actions_secret.anthropic_api_key :
    repo => secret.secret_name
  }
}

output "configured_repositories" {
  description = "List of repositories configured with Claude Code GitHub Actions"
  value       = var.enable_claude_for_all_repos ? var.github_repositories : []
}

output "managed_repositories" {
  description = "Map of managed GitHub repositories"
  value = {
    for name, repo in github_repository.managed_repos :
    name => {
      html_url       = repo.html_url
      ssh_clone_url  = repo.ssh_clone_url
      default_branch = repo.default_branch
    }
  }
}

output "current_user" {
  description = "Current authenticated GitHub user"
  value = {
    login = data.github_user.current.login
    name  = data.github_user.current.name
    email = data.github_user.current.email
  }
}

output "organization_info" {
  description = "GitHub organization information"
  value       = local.organization_info
}

output "github_users" {
  description = "Map of GitHub users"
  value = {
    for username, user in data.github_user.users :
    username => {
      login = user.login
      name  = user.name
      bio   = user.bio
    }
  }
}

output "organization_settings" {
  description = "Current organization settings"
  value = var.manage_organization ? {
    company                         = github_organization_settings.ana_dx[0].company
    location                        = github_organization_settings.ana_dx[0].location
    default_repository_permission   = github_organization_settings.ana_dx[0].default_repository_permission
    members_can_create_repositories = github_organization_settings.ana_dx[0].members_can_create_repositories
  } : null
}

output "organization_members" {
  description = "Managed organization members"
  value = var.manage_org_members ? {
    for username, member in github_membership.org_members :
    username => {
      role  = member.role
      state = member.state
    }
  } : {}
}

output "repository_collaborators" {
  description = "Managed repository collaborators"
  value = var.manage_repo_collaborators ? {
    for key, collab in github_repository_collaborator.repo_collaborators :
    key => {
      repository = collab.repository
      username   = collab.username
      permission = collab.permission
    }
  } : {}
}

output "teams" {
  description = "Managed GitHub teams"
  value = var.manage_teams ? {
    for name, team in github_team.teams :
    name => {
      id          = team.id
      slug        = team.slug
      description = team.description
      privacy     = team.privacy
    }
  } : {}
}