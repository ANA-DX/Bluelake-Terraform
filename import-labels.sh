#!/bin/bash
# Import all existing labels

repos=("Bluelake" "Bluelake-Terraform")
labels=("bug" "documentation" "duplicate" "enhancement" "good_first_issue" "help_wanted" "invalid" "question" "wontfix")

for repo in "${repos[@]}"; do
  for label in "${labels[@]}"; do
    echo "Importing $repo:$label"
    terraform import "github_issue_label.labels[\"${repo}:${label}\"]" "${repo}:${label// /_}" || true
  done
done