# Bluelake Terraform - GitHub Organization Infrastructure as Code

This repository manages the ANA-DX GitHub organization infrastructure using Terraform, including repositories, users, teams, webhooks, labels, and Claude AI integration via Anthropic API.

## Setup Instructions

### Prerequisites
1. Anthropic API key from https://console.anthropic.com/settings/keys
2. GitHub personal access token with appropriate permissions:
   - `repo` - Full control of repositories
   - `admin:org` - Full control of orgs and teams (if managing users/teams)
   - `write:org` - Read and write org and team membership (if managing users/teams)
3. Terraform installed (v1.0+)

### Configuration Steps

1. **Create terraform.tfvars file**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```
   Edit the file and add your Anthropic API key:
   ```hcl
   anthropic_api_key = "sk-ant-..."
   ```

2. **Set GitHub Token**:
   ```bash
   export GITHUB_TOKEN=$(gh auth token)
   ```

3. **Apply Terraform**:
   ```bash
   terraform plan
   terraform apply
   ```

4. **Install Claude GitHub App**:
   - Visit https://github.com/apps/claude
   - Install it to the ANA-DX/Bluelake-Terraform repository

5. **Push changes to repository**:
   ```bash
   git add .
   git commit -m "Add Claude AI integration with Anthropic API"
   git push origin main
   ```

## Usage

Once setup is complete, you can interact with Claude in issues and PRs:

- `@claude help me implement this feature`
- `@claude fix the bug in this code`
- `@claude review this PR`

## Features

### User Management
- **Organization Members**: Manage organization membership and roles (admin/member)
- **Repository Collaborators**: Add external collaborators to specific repositories
- **Teams**: Create and manage teams with hierarchical permissions

### Repository Management
- Create and configure repositories
- Branch protection rules
- Webhook configuration
- Standardized issue labels

### Organization Settings
- Security configurations
- Default repository permissions
- Organization-wide settings

## Files Overview

- `.github/workflows/claude-anthropic.yml` - GitHub Actions workflow for Claude AI
- `main.tf` - Terraform provider configuration and variables
- `organization.tf` - Organization-level settings
- `repositories.tf` - Repository definitions and branch protection
- `users.tf` - User, team, and collaborator management
- `github.tf` - GitHub Actions secrets configuration
- `webhooks.tf` - Repository webhooks
- `labels.tf` - Standardized issue labels
- `outputs.tf` - Terraform outputs
- `terraform.tfvars.example` - Example variables file

## User Management Examples

### Enable User Management
In your `terraform.tfvars`:
```hcl
# Organization members
manage_org_members = true
github_users = ["user1", "user2", "user3"]
github_user_roles = {
  "user1" = "admin"
  "user2" = "member"
  "user3" = "member"
}

# Repository collaborators
manage_repo_collaborators = true
repository_collaborators = {
  "Bluelake" = ["external-dev1", "external-dev2"]
}
repository_collaborator_permissions = {
  "Bluelake:external-dev1" = { permission = "push" }
  "Bluelake:external-dev2" = { permission = "pull" }
}

# Teams (optional)
manage_teams = true
github_teams = {
  "backend" = {
    description  = "Backend development team"
    privacy      = "closed"
    members      = ["user2", "user3"]
    member_roles = {
      "user2" = "maintainer"
      "user3" = "member"
    }
  }
}
```

## Security Notes

- Never commit your API key to the repository
- Use terraform.tfvars (it's in .gitignore)
- API key is stored as encrypted GitHub secret
- Organization management requires owner-level permissions