# Repository Webhooks
resource "github_repository_webhook" "repo_webhooks" {
  for_each = var.repository_webhooks

  repository = each.value.repository

  configuration {
    url          = each.value.url
    content_type = lookup(each.value, "content_type", "json")
    insecure_ssl = lookup(each.value, "insecure_ssl", false)
    secret       = lookup(each.value, "secret", null)
  }

  active = lookup(each.value, "active", true)
  events = each.value.events
}

# Variables for webhooks
variable "repository_webhooks" {
  description = "Map of repository webhooks"
  type = map(object({
    repository   = string
    url          = string
    content_type = optional(string)
    insecure_ssl = optional(bool)
    secret       = optional(string)
    active       = optional(bool)
    events       = list(string)
  }))
  default = {}
}