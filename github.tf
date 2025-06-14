# GitHub repository secrets for Anthropic API key
resource "github_actions_secret" "anthropic_api_key" {
  for_each        = var.enable_claude_for_all_repos ? toset(var.github_repositories) : toset([])
  repository      = each.value
  secret_name     = "ANTHROPIC_API_KEY"
  plaintext_value = var.anthropic_api_key
}