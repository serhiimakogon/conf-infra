resource "random_id" "cluster_suffix" {
  byte_length = 4
}

resource "confluent_kafka_cluster" "basic" {
  display_name = "${var.cluster_prefix}_${random_id.cluster_suffix.hex}"
  availability = "SINGLE_ZONE"
  cloud        = var.cloud
  region       = var.region

  basic {}

  environment {
    id = var.confluent_env_id
  }

  lifecycle {
    prevent_destroy = true
  }
}
