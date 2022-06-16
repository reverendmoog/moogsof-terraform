# Use the RESTapi Provider
terraform {
  required_providers {
    restapi = {
      source                = "fmontezuma/restapi"
      version               = "1.14.1"
      configuration_aliases = [restapi.v1, restapi.v2]
    }
  }
}

# Configure the provider
provider "restapi" {
  alias                 = "v1"
  uri                   = "https://api.moogsoft.ai/v1"
  debug                 = true
  write_returns_object  = true
  create_returns_object = true
  update_method         = "PATCH"
  read_method           = "GET"
  id_attribute          = "data/id"
  headers = {
    "Content-Type" : "application/json",
    "apiKey" : var.apiKey
  }
}

provider "restapi" {
  alias                 = "v2"
  uri                   = "https://api.moogsoft.ai/v2"
  debug                 = true
  write_returns_object  = true
  create_returns_object = true
  update_method         = "PATCH"
  read_method           = "GET"
  id_attribute          = "data/id"
  headers = {
    "Content-Type" : "application/json",
    "apiKey" : var.apiKey
  }
}

# apiKey is stored in external variables file
variable "apiKey" {
  type      = string
  sensitive = true
}
