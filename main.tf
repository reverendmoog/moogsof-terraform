# Use the RESTapi Provider
terraform {
  required_providers {
    restapi = {
      source = "fmontezuma/restapi"
      version = "1.14.1"
    }
  }
}

# apiKey is stored in external variables file
variable "apiKey" {
    type = string
    sensitive = true
}

# Configure the provider
provider "restapi" {
  uri                   = "https://api.moogsoft.ai/v2"
  debug                 = true
  write_returns_object  = true
  create_returns_object = true
  update_method         = "PATCH"
  read_method           = "GET"
  id_attribute          = "data/id"
  headers               = {
    "Content-Type": "application/json",
    "apiKey" : var.apiKey
  }
}

# Create an empty catalog
resource "restapi_object" "test_catalog" {
  path = "/catalogs"
  data = jsonencode({
    name = "Test"
    description = "This is an API test"
    schema = {
      fields = [
        {
          name = "source"
          required = false
          type = "STRING" 
        },
        {
          name = "service"
          required = false
          type = "STRING" 
        } 
      ]
    }
  })
}

# Add a document (row) to the catalog
resource "restapi_object" "test_document" {
  path = "/catalogs/${restapi_object.test_catalog.id}/documents"
  read_path = "/catalogs/${restapi_object.test_catalog.id}/documents"
  id_attribute = "data"
  data = jsonencode({
    source = "barney"
    service = "pebbles"
  })
}
