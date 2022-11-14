variable "confluent_env_id" {
  description = "Confluent env id"
  type        = string
}

variable "cluster_prefix" {
  description = "ksql cluster prefix"
  type        = string
}

variable "kafka_cluster_rbac_crn" {
  description = "Kafka cluster rbac confluent resource name"
  type        = string
}

variable "kafka_cluster_id" {
  description = "Kafka cluster id"
  type        = string
}
