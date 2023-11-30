variable "path" {
  type = string
}

variable "region" {
  type = string
}

variable "commit_sha" {
  type = string
}

variable "function_name" {
  type = string
}

variable "bucket" {
  type = string
}

variable "entry_point" {
  type = string
}

variable "runtime" {
  type = string
}

variable "timeout" {
  type = number
}

variable "memory" {
  type = string
}

variable "project" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "create_event_trigger" {
  type    = bool
  default = false
}

variable "environment_variables" {
  type    = map(string)
  default = { }
}

variable "event_trigger_config" {
  type    = object({
    event_type     = optional(string)
    resource       = optional(string)
  })
  default = null
}