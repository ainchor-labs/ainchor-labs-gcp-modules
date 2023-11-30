locals {
  zip_name = "${var.path}_${var.commit_sha}.zip"
}

resource "google_storage_bucket_object" "object" {
  name           = local.zip_name
  bucket         = var.bucket
  source         = "../functions/${var.path}/${local.zip_name}"
  metadata       = {
    commit_sha = var.commit_sha
  }
}

resource "google_cloudfunctions_function" "function_with_trigger" {
  depends_on                   = [ google_storage_bucket_object.object ]
  count                        = var.create_event_trigger ? 1 : 0
  name                         = var.function_name
  runtime                      = var.runtime
  source_archive_bucket        = var.bucket
  source_archive_object        = local.zip_name
  entry_point                  = var.entry_point
  available_memory_mb          = var.memory
  service_account_email        = var.service_account_email
  max_instances                = 20
  environment_variables        = var.environment_variables
  timeout                      = var.timeout
  event_trigger {
    event_type = var.event_trigger_config.event_type
    resource   = var.event_trigger_config.resource
  }

  labels = {
    zip-generation = var.commit_sha
  }
}

resource "google_cloudfunctions_function" "function_without_trigger" {
  depends_on                   = [ google_storage_bucket_object.object ]
  count                        = var.create_event_trigger ? 0 : 1
  name                         = var.function_name
  runtime                      = var.runtime
  source_archive_bucket        = var.bucket
  source_archive_object        = local.zip_name
  entry_point                  = var.entry_point
  available_memory_mb          = var.memory
  service_account_email        = var.service_account_email
  max_instances                = 20
  environment_variables        = var.environment_variables
  timeout                      = var.timeout
  trigger_http                 = true
  https_trigger_security_level = "SECURE_ALWAYS"
  ingress_settings = "ALLOW_ALL"
  labels = {
    zip-generation = var.commit_sha
  }
}
resource "google_cloudfunctions_function_iam_member" "invoker" {
  depends_on     = [ google_cloudfunctions_function.function_without_trigger ]
  count          = var.create_event_trigger ? 0 : 1
  project        = var.project
  region         = var.region
  cloud_function = google_cloudfunctions_function.function_without_trigger[count.index].name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers"
}