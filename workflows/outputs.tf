output "id" { 
    # value = var.is_cron_job ? module.workflow_with_cron_trigger[0].workflow_id : module.workflow_with_eventarc_trigger[0].workflow_id
    value = module.workflow.workflow_id
}

output "name" {
    value = "${var.project_id}-${var.workflow_name}"
}