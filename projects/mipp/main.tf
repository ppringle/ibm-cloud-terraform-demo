module "mipp_secret_manager" {
  source                      = "../../modules/secret-manager"
  ibm_cloud_secret_manager_rg = try(lookup(var.secret_manager_rg_options, terraform.workspace), null)
  secret_manager_region       = var.secret_manager_region
  secret_manager_name         = var.secret_manager_name
}