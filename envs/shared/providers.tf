terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.13.0"
    }
  }

  cloud {
    organization = "serhiimakogon"

    workspaces {
      name = "clarks-shared"
    }
  }
}