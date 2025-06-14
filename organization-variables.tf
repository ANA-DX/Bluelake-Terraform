# Organization Management Variables

variable "manage_organization" {
  description = "Whether to manage GitHub organization settings"
  type        = bool
  default     = false
}

# Basic organization information
variable "organization_billing_email" {
  description = "Billing email for the organization"
  type        = string
  default     = ""
}

variable "organization_company" {
  description = "Company name for the organization"
  type        = string
  default     = "All Nippon Airways Co., Ltd."
}

variable "organization_location" {
  description = "Location of the organization"
  type        = string
  default     = "Tokyo, Japan"
}

variable "organization_blog" {
  description = "Blog URL for the organization"
  type        = string
  default     = ""
}

variable "organization_email" {
  description = "Public email for the organization"
  type        = string
  default     = ""
}

variable "organization_twitter_username" {
  description = "Twitter username for the organization"
  type        = string
  default     = ""
}

# Repository permissions
variable "org_has_organization_projects" {
  description = "Whether organization projects are enabled"
  type        = bool
  default     = true
}

variable "org_has_repository_projects" {
  description = "Whether repository projects are enabled"
  type        = bool
  default     = true
}

variable "org_default_repository_permission" {
  description = "Default permission for organization members on repositories"
  type        = string
  default     = "read"
  validation {
    condition     = contains(["read", "write", "admin", "none"], var.org_default_repository_permission)
    error_message = "Must be one of: read, write, admin, none"
  }
}

variable "org_members_can_create_repositories" {
  description = "Whether members can create repositories"
  type        = bool
  default     = true
}

variable "org_members_can_create_internal_repositories" {
  description = "Whether members can create internal repositories"
  type        = bool
  default     = false
}

variable "org_members_can_create_private_repositories" {
  description = "Whether members can create private repositories"
  type        = bool
  default     = true
}

variable "org_members_can_create_public_repositories" {
  description = "Whether members can create public repositories"
  type        = bool
  default     = true
}

# Pages permissions
variable "org_members_can_create_pages" {
  description = "Whether members can create GitHub Pages"
  type        = bool
  default     = true
}

variable "org_members_can_create_public_pages" {
  description = "Whether members can create public GitHub Pages"
  type        = bool
  default     = true
}

variable "org_members_can_create_private_pages" {
  description = "Whether members can create private GitHub Pages"
  type        = bool
  default     = true
}

# Fork permissions
variable "org_members_can_fork_private_repositories" {
  description = "Whether members can fork private repositories"
  type        = bool
  default     = false
}

# Advanced security settings
variable "org_advanced_security_enabled" {
  description = "Whether advanced security is enabled for new repositories"
  type        = bool
  default     = false
}

variable "org_dependabot_alerts_enabled" {
  description = "Whether Dependabot alerts are enabled for new repositories"
  type        = bool
  default     = true
}

variable "org_dependabot_security_updates_enabled" {
  description = "Whether Dependabot security updates are enabled for new repositories"
  type        = bool
  default     = true
}

variable "org_dependency_graph_enabled" {
  description = "Whether dependency graph is enabled for new repositories"
  type        = bool
  default     = true
}

variable "org_secret_scanning_enabled" {
  description = "Whether secret scanning is enabled for new repositories"
  type        = bool
  default     = true
}

variable "org_secret_scanning_push_protection_enabled" {
  description = "Whether secret scanning push protection is enabled for new repositories"
  type        = bool
  default     = false
}

variable "org_web_commit_signoff_required" {
  description = "Whether web commit sign-off is required"
  type        = bool
  default     = false
}

# Webhooks
variable "organization_webhooks" {
  description = "Map of organization webhooks"
  type = map(object({
    url          = string
    content_type = optional(string)
    insecure_ssl = optional(bool)
    secret       = optional(string)
    active       = optional(bool)
    events       = list(string)
  }))
  default = {}
}

# Security managers
variable "security_manager_teams" {
  description = "List of team slugs that can manage security alerts"
  type        = list(string)
  default     = []
}

# Custom repository roles
variable "custom_repository_roles" {
  description = "Map of custom repository roles"
  type = map(object({
    description = string
    base_role   = string
    permissions = list(string)
  }))
  default = {}
}