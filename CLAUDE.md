# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository manages GitHub organization infrastructure using Terraform. It configures the ANA-DX organization, repositories, users, webhooks, labels, and Claude AI integration through GitHub Actions.

## Common Commands

### Initial Setup
```bash
# Copy and configure variables
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your Anthropic API key

# Set GitHub authentication
export GITHUB_TOKEN=$(gh auth token)

# Initialize and apply Terraform
terraform init
terraform plan
terraform apply
```

### Development Workflow
```bash
# Preview changes before applying
terraform plan

# Apply changes with approval
terraform apply

# Apply changes automatically
terraform apply -auto-approve

# Format Terraform files
terraform fmt

# Validate configuration
terraform validate
```

### Import Existing Resources
```bash
# Import a repository
terraform import 'github_repository.managed_repos["REPO_NAME"]' REPO_NAME

# Import organization settings
terraform import 'github_organization_settings.ana_dx[0]' ANA-DX

# Import webhooks
terraform import 'github_repository_webhook.repo_webhooks["KEY"]' REPO_NAME/WEBHOOK_ID

# Import labels (use the provided script)
./import-labels.sh
```

## Architecture

### Resource Organization

The codebase is organized by resource type:

- **main.tf**: Provider configuration and core variables
- **organization.tf** + **organization-variables.tf**: GitHub organization settings and security configurations
- **repositories.tf**: Repository management and branch protection rules
- **users.tf**: User data sources and organization membership
- **github.tf**: GitHub Actions secrets for Claude API
- **webhooks.tf**: Repository webhooks configuration
- **labels.tf**: Standardized issue labels across repositories
- **outputs.tf**: Exported values for other systems

### Key Design Patterns

1. **Resource Toggles**: Most resources use feature flags (e.g., `manage_organization`, `manage_labels`) to enable/disable management
2. **For-each Patterns**: Resources are created using `for_each` loops over repository lists for consistency
3. **Sensitive Data**: API keys and secrets use Terraform's `sensitive` attribute and are never committed
4. **Import-friendly**: Resources are structured to easily import existing GitHub infrastructure

### Critical Variables

- `github_repositories`: List of repositories to manage
- `anthropic_api_key`: Claude AI API key (sensitive)
- `manage_organization`: Toggle for organization-level management
- `enable_claude_for_all_repos`: Enable Claude GitHub Actions across repositories

### GitHub Actions Integration

The repository sets up Claude AI integration through:
1. GitHub Actions secrets (`ANTHROPIC_API_KEY`) per repository
2. Workflow file at `.github/workflows/claude-anthropic.yml`
3. Claude GitHub App installation (manual step)

Users can interact with Claude in issues/PRs using `@claude` mentions.