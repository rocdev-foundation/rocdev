provider "github" {}

variable "site_domain" {
  type    = "string"
  default = "rocdev.org"
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
