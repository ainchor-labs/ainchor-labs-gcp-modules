data "template_file" "workflow_template" {
    template = file("${var.file_path}")
    vars = var.vars
}

module "workflow" {
  source                 = "GoogleCloudPlatform/cloud-workflows/google"
  version                = "~> 0.1"
  project_id             = var.project_id
  workflow_name          = "${var.project_id}-${var.workflow_name}"
  region                 = var.region
  service_account_email = var.service_account_email
  workflow_source        = data.template_file.workflow_template.rendered
  workflow_trigger       = var.workflow_trigger
}