variable "account_id" {
  description = "The service account ID."
  type        = string
}

variable "description" {
  description = "(Optional) The description of the service account."
  type        = string
  default     = null
}

variable "project" {
  description = "The project ID where the service account will be created."
  type        = string
}

variable "roles" {
  description = "List of IAM roles to be associated with the service account."
  type        = list(string)
  default     = []
}
