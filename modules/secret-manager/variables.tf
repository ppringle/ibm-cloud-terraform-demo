variable ibm_cloud_secret_manager_rg {
  description = "Secret Manager Resource Group"
  type        = string
}

variable region {
  description = "Default region"
  type        = string
  default     = "us-east"
}

variable secret_manager_region {
  description = "Secret Manager Region"
  type        = string
}

variable secret_manager_name {
  description = "The name given to the Secrets Manager Instance"
  type        = string
}

variable demo_secret_group {
  description = "The name given to the demo secret group"
  type        = map(string)
  default     = {
    name        = "demoSecretGroup"
    description = "Demo Secret Group"
  }
}