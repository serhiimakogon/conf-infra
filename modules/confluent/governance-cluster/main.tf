# See https://docs.confluent.io/cloud/current/stream-governance/packages.html#packages
data "confluent_stream_governance_region" "essentials" {
  cloud   = var.cloud
  region  = var.region
  package = "ESSENTIALS" # ESSENTIALS/ADVANCED
}

resource "confluent_stream_governance_cluster" "essentials" {
  package = data.confluent_stream_governance_region.essentials.package

  environment {
    id = var.confluent_env_id
  }

  region {
    id = data.confluent_stream_governance_region.essentials.id
  }

  lifecycle {
    prevent_destroy = true
  }
}
