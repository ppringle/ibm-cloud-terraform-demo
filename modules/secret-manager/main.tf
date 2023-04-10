data "ibm_resource_group" "secret_manager_rg" {
  name = var.ibm_cloud_secret_manager_rg
}

data "ibm_resource_instance" "demo_secret_manger_instance" {
  name              = var.secret_manager_name
  resource_group_id = data.ibm_resource_group.secret_manager_rg.id
  service           = "secrets-manager"
}

resource "ibm_sm_secret_group" "secret_manager_secret_group" {
  instance_id = local.secret_manager_instance_guid
  region      = var.secret_manager_region
  name        = var.demo_secret_group.name
  description = var.demo_secret_group.description
}

resource "ibm_sm_kv_secret" "sm_kv_secret" {
  instance_id     = local.secret_manager_instance_guid
  region          = var.secret_manager_region
  data            = { "apiKey" : "hello" }
  description     = "Extended description for this secret."
  labels          = ["dev"]
  secret_group_id = local.secret_manager_secret_group_guid
  name            = "kv-secret-example"
}

resource "ibm_iam_access_group" "demo_access_group" {
  name        = "demoAccessGroup"
  description = "This is a Demo Access Group"
}

resource "ibm_iam_service_id" "demo_service_id" {
  name        = "demoService"
  description = "This is a demo Service Id"
}

resource "ibm_iam_service_api_key" "demo_service_id_api_key" {
  name           = "demoService API Key"
  apikey         = "test"
  iam_service_id = ibm_iam_service_id.demo_service_id.iam_id
}

resource "ibm_iam_access_group_members" "demo_access_group_members" {
  access_group_id = ibm_iam_access_group.demo_access_group.id
  iam_service_ids = [ibm_iam_service_id.demo_service_id.id]
}

resource "ibm_iam_access_group_policy" "demoAccessGroupSecretManagerPolicy" {
  access_group_id = ibm_iam_access_group.demo_access_group.id
  roles           = ["SecretsReader"]

  resource_attributes {
    name  = "serviceName"
    value = "secrets-manager"
  }

  resource_attributes {
    name     = "serviceInstance"
    value    = local.secret_manager_instance_guid
    operator = "stringEquals"
  }

  resource_attributes {
    name     = "resource"
    value    = local.secret_manager_secret_group_guid
    operator = "stringEquals"
  }

  resource_attributes {
    name     = "resourceType"
    value    = "secret-group"
    operator = "stringEquals"
  }

}

locals {
  secret_manager_instance_guid     = regex("([a-zA-Z0-9-]*)::$", data.ibm_resource_instance.demo_secret_manger_instance.id)[0]
  secret_manager_secret_group_guid = regex("([a-zA-Z0-9-]*)$", ibm_sm_secret_group.secret_manager_secret_group.id)[0]
}