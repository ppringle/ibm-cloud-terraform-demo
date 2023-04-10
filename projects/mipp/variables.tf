variable region {
  description = "Default region"
  type        = string
  default     = "us-east"
}

variable "secret_manager_region" {
  type    = string
  default = "au-syd"
}

variable secret_manager_name {
  description = "The name given to the Secrets Manager Instance"
  type        = string
  default     = "Secrets Manager-cb"
}

variable "secret_manager_rg_options" {
  description = "A map of the Secret Manager Resource group options per environment"
  type        = map
  default     = {
    default = "Default"
    dev     = "Default"
    test    = "Default"
    prod    = "Default"
  }
}
