resource "random_id" "cluster_suffix" {
  byte_length = 4
}

resource "confluent_service_account" "ksql" {
  display_name = "${var.cluster_prefix}_ksql"
  description  = "Service account to manage ksqldb cluster"
}

resource "confluent_role_binding" "ksql_kafka_cluster_admin" {
  principal   = "User:${confluent_service_account.ksql.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = var.kafka_cluster_rbac_crn
}

resource "confluent_ksql_cluster" "ksql" {
  display_name = "${var.cluster_prefix}_${random_id.cluster_suffix.hex}"
  csu          = 1

  kafka_cluster {
    id = var.kafka_cluster_id
  }

  credential_identity {
    id = confluent_service_account.ksql.id
  }

  environment {
    id = var.confluent_env_id
  }

  depends_on = [confluent_role_binding.ksql_kafka_cluster_admin]
}
