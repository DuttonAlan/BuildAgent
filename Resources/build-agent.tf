resource "azurerm_container_app_environment" "env" {
  depends_on = [ azurerm_log_analytics_workspace.analytics ]
  name = var.container_app_env_name
  location = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.analytics.id
}

resource "azurerm_container_app_job" "placeholder_agent_job" {
  depends_on = [ null_resource.docker_image, azurerm_container_app_environment.env ]
  name = "ph-${var.container_app_job_name}"
  location = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.env.id

  replica_timeout_in_seconds = 300
  replica_retry_limit = 0

  manual_trigger_config {
    replica_completion_count = 1
    parallelism = 1
  }

  secret {
    name = "acr-admin-password"
    value = azurerm_container_registry.acr.admin_password
  }

  secret {
    name  = "personal-access-token"
    value = var.devops_token
  }

  secret {
    name  = "organization-url"
    value = var.organisation_url
  }

  registry {
    server = azurerm_container_registry.acr.login_server
    username = azurerm_container_registry.acr.admin_username
    password_secret_name = "acr-admin-password"
  }

  template {
    container {
      image = "${azurerm_container_registry.acr.login_server}/${local.image_name}:${local.image_tag}"
      name  = var.container_app_job_name

      env {
        name  = "AZP_TOKEN"
        secret_name = "personal-access-token"
      }

      env {
        name  = "AZP_URL"
        secret_name = "organization-url"
      }

      env {
        name  = "AZP_POOL"
        value = var.agent_pool
      }

      env {
        name = "AZP_PLACEHOLDER"
        value = "1"
      }

      env {
        name = "AZP_AGENT_NAME"
        value = "placeholder-agent"
      }

      cpu = 1.0
      memory = "2Gi"
    }
  }
}

resource "null_resource" "start_placeholder_job" {
  depends_on = [ azurerm_container_app_job.placeholder_agent_job, azurerm_container_app_environment.env ]
  provisioner "local-exec" {
    command = "az containerapp job start -n ${azurerm_container_app_job.placeholder_agent_job.name} -g ${azurerm_container_app_job.placeholder_agent_job.resource_group_name}"
  }
}

resource "azurerm_container_app_job" "agent_job" {
  depends_on = [ null_resource.docker_image, azurerm_container_app_environment.env ]
  name = var.container_app_job_name
  location = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.env.id

  replica_timeout_in_seconds = 1800
  replica_retry_limit = 0
  
  secret {
    name = "acr-admin-password"
    value = azurerm_container_registry.acr.admin_password
  }

  secret {
    name  = "personal-access-token"
    value = var.devops_token
  }

  secret {
    name  = "organization-url"
    value = var.organisation_url
  }

  event_trigger_config {
    replica_completion_count = 1
    parallelism = 1
    scale {
      min_executions = 0
      max_executions = 10
      polling_interval_in_seconds = 30
      rules {
        name = "azure-pipelines"
        custom_rule_type = "azure-pipelines"
        metadata = {
          "poolName" = var.agent_pool,
          "targetPipelinesQueueLength" = "1"
        }
        authentication {
          trigger_parameter = "personalAccessToken"
          secret_name = "personal-access-token"
        }
        authentication {
          trigger_parameter = "organizationURL"
          secret_name = "organization-url"
        }
      }
    }
  }

  registry {
    server = azurerm_container_registry.acr.login_server
    username = azurerm_container_registry.acr.admin_username
    password_secret_name = "acr-admin-password"
  }

  template {
    container {
      image = "${azurerm_container_registry.acr.login_server}/${local.image_name}:${local.image_tag}"
      name  = var.container_app_job_name

      env {
        name  = "AZP_TOKEN"
        secret_name = "personal-access-token"
      }

      env {
        name  = "AZP_URL"
        secret_name = "organization-url"
      }

      env {
        name  = "AZP_POOL"
        value = var.agent_pool
      }

      cpu = 1.0
      memory = "2Gi"
    }
  }
}