# GitHub Organization Settings Management
# Note: This requires organization owner permissions

# Organization settings
resource "github_organization_settings" "ana_dx" {
  count = var.manage_organization ? 1 : 0
  
  # Basic information
  billing_email = var.organization_billing_email
  company       = var.organization_company
  name          = var.organization_name
  description   = var.organization_description
  location      = var.organization_location
  
  # Optional fields
  blog              = var.organization_blog
  email             = var.organization_email
  twitter_username  = var.organization_twitter_username
  
  # Repository permissions
  has_organization_projects                 = var.org_has_organization_projects
  has_repository_projects                   = var.org_has_repository_projects
  default_repository_permission             = var.org_default_repository_permission
  members_can_create_repositories           = var.org_members_can_create_repositories
  members_can_create_internal_repositories  = var.org_members_can_create_internal_repositories
  members_can_create_private_repositories   = var.org_members_can_create_private_repositories
  members_can_create_public_repositories    = var.org_members_can_create_public_repositories
  
  # Pages permissions
  members_can_create_pages                  = var.org_members_can_create_pages
  members_can_create_public_pages           = var.org_members_can_create_public_pages
  members_can_create_private_pages          = var.org_members_can_create_private_pages
  
  # Fork permissions
  members_can_fork_private_repositories     = var.org_members_can_fork_private_repositories
  
  # Advanced security (if applicable)
  advanced_security_enabled_for_new_repositories = var.org_advanced_security_enabled
  dependabot_alerts_enabled_for_new_repositories = var.org_dependabot_alerts_enabled
  dependabot_security_updates_enabled_for_new_repositories = var.org_dependabot_security_updates_enabled
  dependency_graph_enabled_for_new_repositories = var.org_dependency_graph_enabled
  secret_scanning_enabled_for_new_repositories = var.org_secret_scanning_enabled
  secret_scanning_push_protection_enabled_for_new_repositories = var.org_secret_scanning_push_protection_enabled
  
  # Web commit signing
  web_commit_signoff_required = var.org_web_commit_signoff_required
}

# Organization webhooks (optional)
resource "github_organization_webhook" "webhook" {
  for_each = var.manage_organization && length(var.organization_webhooks) > 0 ? var.organization_webhooks : {}
  
  configuration {
    url          = each.value.url
    content_type = lookup(each.value, "content_type", "json")
    insecure_ssl = lookup(each.value, "insecure_ssl", false)
    secret       = lookup(each.value, "secret", null)
  }
  
  active = lookup(each.value, "active", true)
  events = each.value.events
}

# Organization security managers (teams that can manage security alerts)
resource "github_organization_security_manager" "security_teams" {
  for_each = var.manage_organization && length(var.security_manager_teams) > 0 ? toset(var.security_manager_teams) : toset([])
  
  team_slug = each.value
}

# Organization custom repository roles
resource "github_organization_custom_role" "custom_roles" {
  for_each = var.manage_organization && length(var.custom_repository_roles) > 0 ? var.custom_repository_roles : {}
  
  name        = each.key
  description = each.value.description
  base_role   = each.value.base_role
  permissions = each.value.permissions
}