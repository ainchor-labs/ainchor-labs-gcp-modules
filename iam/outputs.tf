output "service_account_email" {
  description = "Email address of the service account."
  value       = google_service_account.service_account.email
}

output "id" {
  value = google_service_account.service_account.id
}