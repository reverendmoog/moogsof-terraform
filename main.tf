# Use the RESTapi Provider
terraform {
  required_providers {
    restapi = {
      source  = "fmontezuma/restapi"
      version = "1.14.1"
    }
    restapiV2 = {
      source  = "fmontezuma/restapi"
      version = "1.14.1"
    }
  }
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
  headers = {
    "Content-Type" : "application/json",
    "apiKey" : var.apiKey
  }
}

provider "restapiV2" {
  uri                   = "https://api.moogsoft.ai"
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
