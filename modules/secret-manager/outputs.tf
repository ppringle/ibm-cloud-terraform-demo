output "demo_secret_manager_details" {
  value = {
    crn  = data.ibm_resource_instance.demo_secret_manger_instance.id
    name = data.ibm_resource_instance.demo_secret_manger_instance.name

  }
}

output "demo_secret_group_details" {
  value = {
    id   = ibm_sm_secret_group.secret_manager_secret_group.id
    name = ibm_sm_secret_group.secret_manager_secret_group.name
  }
}