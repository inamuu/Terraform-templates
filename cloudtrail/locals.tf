resource "random_id" "this" {
  byte_length = 4
}

locals {
  cloudtrail_gmd_prefix = "cloudtrail-get-metrics-data-${random_id.this.hex}"
}
