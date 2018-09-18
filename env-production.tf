### API

resource "heroku_app" "api_production" {
  name   = "${var.heroku_team_name}-api-production"
  region = "us"
  acm    = true

  organization = {
    name = "${var.heroku_team_name}"
  }
}

resource "heroku_addon" "papertrail_web_ui_production" {
  app  = "${heroku_app.api_production.id}"
  plan = "papertrail:choklad"
}

resource "heroku_app_release" "api_production" {
  app     = "${heroku_app.api_production.id}"
  slug_id = "${var.api_slug_production}"
}

resource "heroku_formation" "api_production" {
  app        = "${heroku_app.api_production.id}"
  type       = "web"
  quantity   = 2
  size       = "standard-1x"
  depends_on = ["heroku_app_release.api_production"]
}

### UI

resource "heroku_app" "web_ui_production" {
  name   = "${var.heroku_team_name}-ui-production"
  region = "us"
  acm    = true

  organization = {
    name = "${var.heroku_team_name}"
  }

  config_vars = {
    API_URL = "https://${heroku_app.api_production.name}.herokuapp.com"
  }
}

resource "heroku_addon" "papertrail_api_production" {
  app  = "${heroku_app.web_ui_production.id}"
  plan = "papertrail:choklad"
}

resource "heroku_app_release" "web_ui_production" {
  app     = "${heroku_app.web_ui_production.id}"
  slug_id = "${var.web_ui_slug_production}"
}

resource "heroku_formation" "web_ui_production" {
  app        = "${heroku_app.web_ui_production.id}"
  type       = "web"
  quantity   = 2
  size       = "standard-1x"
  depends_on = ["heroku_app_release.web_ui_production"]
}
