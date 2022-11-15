resource "confluent_environment" "dev" {
  display_name = "dev"

  lifecycle {
    prevent_destroy = true
  }
}

module "governance_cluster" {
  source = "../../modules/confluent/governance-cluster"

  cloud            = var.cloud
  region           = var.cloud_region
  confluent_env_id = confluent_environment.dev.id
}

module "kafka_cluster" {
  source = "../../modules/confluent/kafka-cluster"

  cluster_prefix   = "dev"
  cloud            = var.cloud
  region           = var.cloud_region
  confluent_env_id = confluent_environment.dev.id

  depends_on = [module.governance_cluster]
}

module "ksql_cluster" {
  source = "../../modules/confluent/ksql-cluster"

  cluster_prefix         = "dev"
  kafka_cluster_rbac_crn = module.kafka_cluster.rbac_crn
  kafka_cluster_id       = module.kafka_cluster.id
  confluent_env_id       = confluent_environment.dev.id

  depends_on = [module.kafka_cluster]
}