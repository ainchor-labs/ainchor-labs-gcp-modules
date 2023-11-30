resource "google_service_account" "service_account" {
  account_id   = var.account_id
  display_name = "${var.account_id}-service-account"
  description  = var.description
  project      = var.project
}

resource "google_project_iam_member" "iam_member" {
  count   = length(var.roles)
  project = var.project
  role    = var.roles[count.index]
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
