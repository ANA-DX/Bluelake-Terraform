terraform {
  required_version = ">= 1.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = var.github_owner
}

variable "github_owner" {
  description = "GitHub organization or user name"
  type        = string
  default     = "ANA-DX"
}

variable "github_repositories" {
  description = "List of GitHub repositories to configure"
  type        = list(string)
  default     = ["Bluelake-Terraform", "Bluelake"]
}

variable "anthropic_api_key" {
  description = "Anthropic API key for Claude"
  type        = string
  sensitive   = true
}

variable "enable_claude_for_all_repos" {
  description = "Enable Claude Code GitHub Actions for all repositories"
  type        = bool
  default     = true
}

variable "repository_descriptions" {
  description = "Map of repository names to their descriptions"
  type        = map(string)
  default = {
    "Bluelake-Terraform" = "Terraform configuration for Bluelake infrastructure and Claude AI integration"
    "Bluelake"           = "Bluelake data analytics project with dbt"
  }
}

variable "repository_visibility" {
  description = "Map of repository names to their visibility (public/private)"
  type        = map(string)
  default     = {}
}

variable "repository_discussions" {
  description = "Map of repository names to enable/disable discussions"
  type        = map(bool)
  default     = {}
}

variable "repository_projects" {
  description = "Map of repository names to enable/disable projects"
  type        = map(bool)
  default     = {}
}

variable "repository_wiki" {
  description = "Map of repository names to enable/disable wiki"
  type        = map(bool)
  default     = {}
}

variable "repository_delete_branch_on_merge" {
  description = "Map of repository names to enable/disable branch deletion on merge"
  type        = map(bool)
  default     = {}
}

variable "repository_allow_auto_merge" {
  description = "Map of repository names to enable/disable auto-merge"
  type        = map(bool)
  default     = {}
}

variable "enable_branch_protection" {
  description = "Enable branch protection for main branch"
  type        = bool
  default     = false
}

variable "required_status_checks" {
  description = "Map of repository names to required status check contexts"
  type        = map(list(string))
  default     = {}
}

# User management variables
variable "github_users" {
  description = "List of GitHub usernames to manage"
  type        = list(string)
  default     = ["ANA-MAEDA-KENTARO"]
}

variable "github_user_roles" {
  description = "Map of usernames to organization roles (member/admin)"
  type        = map(string)
  default = {
    "ANA-MAEDA-KENTARO" = "admin"
  }
}

variable "manage_org_members" {
  description = "Whether to manage organization membership"
  type        = bool
  default     = false
}

variable "manage_repo_collaborators" {
  description = "Whether to manage repository collaborators"
  type        = bool
  default     = false
}

variable "repository_collaborators" {
  description = "Map of repository names to lists of collaborator usernames"
  type        = map(list(string))
  default     = {}
}

variable "repository_collaborator_permissions" {
  description = "Map of 'repo:user' to permission level"
  type        = map(map(string))
  default     = {}
}

variable "manage_teams" {
  description = "Whether to manage GitHub teams"
  type        = bool
  default     = false
}

variable "github_teams" {
  description = "Map of team configurations"
  type = map(object({
    description  = string
    privacy      = string
    members      = list(string)
    member_roles = map(string)
  }))
  default = {}
}

variable "organization_name" {
  description = "Full name of the GitHub organization"
  type        = string
  default     = "全日本空輸株式会社"
}

variable "organization_description" {
  description = "Description of the GitHub organization"
  type        = string
  default     = ""
}