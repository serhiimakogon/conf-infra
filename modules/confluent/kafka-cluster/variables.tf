variable "confluent_env_id" {
  description = "Confluent env id"
  type        = string
}

variable "cluster_prefix" {
  description = "Kafka cluster prefix"
  type        = string
}

variable "cloud" {
  description = "Cloud name"
  type        = string
  default     = "AWS"
}

variable "region" {
  description = "Cloud region"
  type        = string
  default     = "us-east-2"
}
