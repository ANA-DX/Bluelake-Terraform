# Bluelake Terraform with Claude AI Integration (Anthropic API)

This repository integrates Claude AI via Anthropic API for automated code review and assistance.

## Setup Instructions

### Prerequisites
1. Anthropic API key from https://console.anthropic.com/settings/keys
2. GitHub personal access token with repo permissions
3. Terraform installed

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
   - Install it to the ANA-DX/Bluelake repository

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

## Files Overview

- `.github/workflows/claude-anthropic.yml` - GitHub Actions workflow
- `main.tf` - Terraform provider configuration
- `github.tf` - GitHub secrets configuration
- `outputs.tf` - Terraform outputs
- `terraform.tfvars.example` - Example variables file

## Security Notes

- Never commit your API key to the repository
- Use terraform.tfvars (it's in .gitignore)
- API key is stored as encrypted GitHub secret