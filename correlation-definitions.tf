#
# This config creates a correlation definition
#

# Create a workflow
resource "restapi_object" "similar-services" {
  provider     = restapi.v1
  path         = "/correlation-definitions"
  id_attribute = "data/uuid"
  data = jsonencode({
    name  = "Similar Services"
    scope = ""
    fields_to_correlate = {
      "tags.service" = 0.61
    }
    correlation_time_period = 5400
    incident_description    = "Incident impacting unique(service) service on unique_count(source) nodes, of type ( unique(type) ) and class (unique(class)) "
    created_by              = "richard@moogsoft.com"
    alert_threshold         = 2
    group_id                = "d9a15208-2a75-431d-af27-44410ca98e2e"
  })
}
