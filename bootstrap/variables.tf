variable "github_owner_id" {
  description = "Numeric GitHub owner ID used in the OIDC subject claim."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9]+$", var.github_owner_id))
    error_message = "github_owner_id must contain only digits."
  }
}

variable "github_repository_id" {
  description = "Numeric GitHub repository ID used in the OIDC subject claim."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9]+$", var.github_repository_id))
    error_message = "github_repository_id must contain only digits."
  }
}
