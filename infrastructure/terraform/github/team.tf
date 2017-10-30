variable "admins" {
  type = "list"

  default = [
    "geowa4",
    "dantswain",
  ]
}

variable "members" {
  type = "list"

  default = [
    "bdesham",
    "brandonramirez",
    "chorn",
    "jfine",
    "RyPeck",
    "Scotchester",
    "sfacci",
    "kylemacey",
  ]
}

variable "webmasters" {
  type = "list"

  default = [
    "Scotchester",
    "sfacci",
  ]
}

variable "gitmasters" {
  type = "list"

  default = [
    "kylemacey",
  ]
}

variable "legacy_web_repos" {
  type = "list"

  default = [
    "homepage",
    "585-software.github.io",
  ]
}

resource "github_membership" "admin_membership" {
  count    = "${length(var.admins)}"
  username = "${element(var.admins, count.index)}"
  role     = "admin"
}

resource "github_membership" "regular_membership" {
  count    = "${length(var.members)}"
  username = "${element(var.members, count.index)}"
  role     = "member"
}

resource "github_team" "webmasters" {
  name        = "Webmasters"
  description = "Authors of web applications."
  privacy     = "closed"
}

resource "github_team_membership" "webmaster_maintainer_membership" {
  count    = "${length(var.admins)}"
  team_id  = "${github_team.webmasters.id}"
  username = "${element(var.admins, count.index)}"
  role     = "maintainer"
}

resource "github_team_membership" "webmaster_membership" {
  count    = "${length(var.webmasters)}"
  team_id  = "${github_team.webmasters.id}"
  username = "${element(var.webmasters, count.index)}"
  role     = "member"
}

resource "github_team_repository" "webmasters_app_repo" {
  team_id    = "${github_team.webmasters.id}"
  repository = "${github_repository.app_repo.name}"
  permission = "push"
}

resource "github_team_repository" "webmasters_legacy_repo" {
  count      = "${length(var.legacy_web_repos)}"
  team_id    = "${github_team.webmasters.id}"
  repository = "${element(var.legacy_web_repos, count.index)}"
  permission = "push"
}

resource "github_team" "gitmasters" {
  name        = "Git Masters"
  description = "Those well versed in Git and GitHub"
  privacy     = "closed"
}

resource "github_team_membership" "gitmaster_maintainer_membership" {
  count    = "${length(var.admins)}"
  team_id  = "${github_team.gitmasters.id}"
  username = "${element(var.admins, count.index)}"
  role     = "maintainer"
}

resource "github_team_membership" "gitmaster_membership" {
  count    = "${length(var.gitmasters)}"
  team_id  = "${github_team.gitmasters.id}"
  username = "${element(var.gitmasters, count.index)}"
  role     = "member"
}
