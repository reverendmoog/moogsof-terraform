#
# This config creates a correlation definition which is assigned to a default group
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
    alert_threshold         = 2
  })
}
