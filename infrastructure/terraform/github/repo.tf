variable "site_domain" {
  type    = "string"
  default = "rocdev.org"
}

variable "datadog_api_key_for_github" {
  type    = "string"
  default = ""
}

resource "github_repository" "app_repo" {
  name               = "rocdev"
  description        = "The future of RocDev."
  homepage_url       = "https://${var.site_domain}"
  license_template   = "MIT"
  has_issues         = true
  has_wiki           = false
  has_downloads      = false
  allow_merge_commit = false
  allow_squash_merge = false
  allow_rebase_merge = true
  private            = false
}

resource "github_repository_webhook" "datadog_webhook" {
  name       = "web"
  repository = "${github_repository.app_repo.name}"
  active     = true

  events = [
    "commit_comment",
    "create",
    "delete",
    "deployment",
    "deployment_status",
    "fork",
    "gollum",
    "issue_comment",
    "issues",
    "label",
    "member",
    "milestone",
    "page_build",
    "project",
    "project_card",
    "project_column",
    "public",
    "pull_request",
    "pull_request_review",
    "pull_request_review_comment",
    "push",
    "release",
    "repository",
    "status",
    "team_add",
    "watch",
  ]

  configuration {
    url          = "https://app.datadoghq.com/intake/webhook/github?api_key=${var.datadog_api_key_for_github}"
    content_type = "json"
    insecure_ssl = false
  }
}

resource "github_branch_protection" "app_master" {
  repository     = "${github_repository.app_repo.name}"
  branch         = "master"
  enforce_admins = false

  required_status_checks {
    strict   = true
    contexts = ["continuous-integration/travis-ci"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true

    dismissal_teams = [
      "${github_team.webmasters.id}",
    ]
  }

  restrictions {
    teams = [
      "${github_team.webmasters.id}",
    ]
  }
}
