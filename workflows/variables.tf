variable "file_path" {
    type = string
}

variable "vars" {
    type = map(string)
}

variable "project_id" {
    type = string
}

variable "workflow_name" {
    type = string
}

variable "region" {
    type = string
}

variable "service_account_email" {
    type = string
}

variable "workflow_trigger" {
    type    = object({
        cloud_scheduler = optional(object({
            name                  = string
            cron                  = string
            time_zone             = string
            deadline              = string
            argument              = optional(map(any))
            service_account_email = string
        }))
        event_arc = optional(object({
            name                  = string
            service_account_email = string
            matching_criteria = set(object({
                attribute = string
                operator  = optional(string)
                value     = string
            }))
            pubsub_topic_id = optional(string)
        }))
    })
}

variable "pubsub_topic_id" {
    type = string
    default = null
}