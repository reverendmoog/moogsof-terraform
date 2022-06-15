#
# This config will add a Data Catalog to Moogsoft Cloud. A Data Catalog is
# actually two resources a catalog (table), with multiple documents (rows)
#

# Read a catalog from a csv file
variable "filename" {
  default = "catalog.csv"
}

# Parse the csv file
locals {
  documents = csvdecode(file(var.filename))
}

# Create an empty catalog
resource "restapi_object" "test_catalog" {
  path = "/catalogs"
  data = jsonencode({
    name        = "Test"
    description = "This is an API test"
    schema = {
      fields = [
        {
          name     = "source"
          required = false
          type     = "STRING"
        },
        {
          name     = "service"
          required = false
          type     = "STRING"
        }
      ]
    }
  })
}

# Add documents (rows) to the catalog
resource "restapi_object" "test_document" {
  path         = "/catalogs/${restapi_object.test_catalog.id}/documents"
  read_path    = "/catalogs/${restapi_object.test_catalog.id}/documents"
  id_attribute = "data"

  for_each = { for item in local.documents : item.source => item }

  data = jsonencode({
    source  = each.value.source
    service = each.value.service
  })
}
