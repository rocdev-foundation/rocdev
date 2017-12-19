provider "github" {}

variable "site_domain" {
  type    = "string"
  default = "rocdev.org"
}

variable "datadog_api_key_for_github" {
  type    = "string"
  default = ""
}

module "github" {
  source                     = "./github"
  site_domain                = "${var.site_domain}"
  datadog_api_key_for_github = "${var.datadog_api_key_for_github}"
}

provider "digitalocean" {}

module "web" {
  source = "./web"
}
