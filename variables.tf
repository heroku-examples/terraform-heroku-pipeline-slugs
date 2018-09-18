variable "heroku_team_name" {
  description = "Name of the Heroku Team owning this complete deployment."
  type        = "string"
}

variable "api_slug_staging" {
  description = "Heroku slug ID for API app"
  type        = "string"
}

variable "api_slug_production" {
  description = "Heroku slug ID for API app"
  type        = "string"
}

variable "web_ui_slug_staging" {
  description = "Heroku slug ID for web UI app"
  type        = "string"
}

variable "web_ui_slug_production" {
  description = "Heroku slug ID for web UI app"
  type        = "string"
}
