module "resources" {
  source = "./Resources"
  resource_group_name = var.resource_group_name
  registry_name = var.registry_name
  log_analytics_name = var.log_analytics_name
  container_app_env_name = var.container_app_env_name
  container_app_job_name = var.container_app_job_name
  agent_name = var.agent_name
  agent_pool = var.agent_pool
  organisation_url = var.organisation_url
  devops_token = var.devops_token
}


