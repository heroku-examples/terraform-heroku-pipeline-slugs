### API

resource "heroku_app" "api_staging" {
  name   = "${var.heroku_team_name}-api-staging"
  region = "us"
  acm    = true

  organization = {
    name = "${var.heroku_team_name}"
  }
}

resource "heroku_addon" "papertrail_web_ui_staging" {
  app  = "${heroku_app.api_staging.name}"
  plan = "papertrail:choklad"
}

resource "heroku_app_release" "api_staging" {
  app     = "${heroku_app.api_staging.name}"
  slug_id = "${var.api_slug_staging}"
}

resource "heroku_formation" "api_staging" {
  app        = "${heroku_app.api_staging.name}"
  type       = "web"
  quantity   = 1
  size       = "standard-1x"
  depends_on = ["heroku_app_release.api_staging"]
}

### UI

resource "heroku_app" "web_ui_staging" {
  name   = "${var.heroku_team_name}-ui-staging"
  region = "us"
  acm    = true

  organization = {
    name = "${var.heroku_team_name}"
  }

  config_vars = {
    API_URL = "https://${heroku_app.api_staging.name}.herokuapp.com"
  }
}

resource "heroku_addon" "papertrail_api_staging" {
  app  = "${heroku_app.web_ui_staging.name}"
  plan = "papertrail:choklad"
}

resource "heroku_app_release" "web_ui_staging" {
  app     = "${heroku_app.web_ui_staging.name}"
  slug_id = "${var.web_ui_slug_staging}"
}

resource "heroku_formation" "web_ui_staging" {
  app        = "${heroku_app.web_ui_staging.name}"
  type       = "web"
  quantity   = 1
  size       = "standard-1x"
  depends_on = ["heroku_app_release.web_ui_staging"]
}
