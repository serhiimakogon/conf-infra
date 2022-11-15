resource "confluent_environment" "shared" {
  display_name = "shared"

  lifecycle {
    prevent_destroy = true
  }
}

module "governance_cluster" {
  source = "../../modules/confluent/governance-cluster"

  cloud            = var.cloud
  region           = var.cloud_region
  confluent_env_id = confluent_environment.shared.id
}

module "kafka_cluster" {
  source = "../../modules/confluent/kafka-cluster"

  cluster_prefix   = "shared"
  cloud            = var.cloud
  region           = var.cloud_region
  confluent_env_id = confluent_environment.shared.id

  depends_on = [module.governance_cluster]
}

module "ksql_cluster" {
  source = "../../modules/confluent/ksql-cluster"

  cluster_prefix         = "shared"
  kafka_cluster_rbac_crn = module.kafka_cluster.rbac_crn
  kafka_cluster_id       = module.kafka_cluster.id
  confluent_env_id       = confluent_environment.shared.id

  depends_on = [module.kafka_cluster]
}