variable "resource_group_name" {
    type = string
    description = "Name of the resource group"
}

variable "registry_name" {
  type = string
  description = "Name of the Azure Container Registry"
}

variable "log_analytics_name" {
    type = string
    description = "Name for the Log Analytics Workspace"
    default = "build-agent-log-analytics"
}

variable "container_app_env_name" {
    type = string
    description = "Name of the Container Environment"
    default = "build-agent-environment"
}

variable "container_app_job_name" {
    type = string
    description = "Name for the Container App Jobs"
    default = "build-agent-container-app-job"
}

variable "devops_token" {
    type = string
    description = "Token"
}

variable "organisation_url" {
    type = string
    description = "The URL of your Organisation."
}

variable "agent_pool" {
    type = string
    description = "Agent Pool"
}

variable "agent_name" {
    type = string
    description = "Name of the Agent"
    default = "azure-build-agent"
}