
# General variables
variable "subscription_id" {
    type = string
    description = "Subscription ID"
}

variable "client_id" {
    type = string
    description = "Client ID"
}

variable "client_secret" {
    type = string
    description = "Client Secret"
}

variable "tenant_id" {
    type = string
    description = "Tenant ID"
}

variable "resource_group_name" {
    type = string
    description = "Name of the Resource Group"
}

# DevOps Build Agent specific 
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
    default = "default"
}

variable "agent_name" {
    type = string
    description = "Name of the Agent"
    default = "buildagent"
}

# Container Registry
variable "registry_name" {
    type = string
    description = "Name for the Container Registry"
}

# Log Analytics Workspace
variable "log_analytics_name" {
    type = string
    description = "Name for the Log Analytics Workspace"
    default = "build-agent-log-analytics"
}

# Container App Environment
variable "container_app_env_name" {
    type = string
    description = "Name for the Container Environment"
    default = "build-agent-environment"
}

# Container App Job
variable "container_app_job_name" {
    type = string
    description = "Name for the Container App Job"
    default = "build-agent-container-app-job"
}