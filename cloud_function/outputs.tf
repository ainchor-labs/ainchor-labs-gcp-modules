output "https_trigger_url" {
  value = var.create_event_trigger ? google_cloudfunctions_function.function_with_trigger[0].https_trigger_url : google_cloudfunctions_function.function_without_trigger[0].https_trigger_url
}