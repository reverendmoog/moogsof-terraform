#
# This config creates a workflow. A second action is required to enable it
#

# Create a workflow
resource "restapi_object" "test_workflow" {
  provider     = restapi.v1
  path         = "/workflows"
  id_attribute = "data/id"
  data = jsonencode({
    name        = "Terraform Test"
    description = "This is a Terraform provisioned workflow"
    trigger = {
      type        = "EVENT_CREATED"
      entryFilter = "tags.collector_source = nginx"
    }
    type     = "EVENT"
    priority = 3
    steps = [
      {
        actionName = "TemplateFieldAction"
        configuration = {
          template        = "$${source}"
          outputFieldName = "tags.nginx_webserver"
        }
      }
    ]
  })
}

resource "null_resource" "enable_test_workflow" {
  provisioner "local-exec" {
    command = <<EOT
      curl -o /tmp/curlout \
        -XPATCH https://api.moogsoft.ai/v1/workflows/${restapi_object.test_workflow.id}/status \
        -H 'Content-Type: application/json' \
        -H 'apiKey: ${var.apiKey}' \
        -d '{\"status\": \"RUNNING\"}'
EOT
  }
}
