variable "subscription_id" {
    type = string
    description = "The unique identifier of your Azure subscription where the resources will be deployed."
}

variable "client_id" {
    type = string
    description = "The application (client) ID of the service principal used for authentication."
}

variable "client_secret" {
    type = string
    description = "The password or secret associated with the service principal."
}

variable "tenant_id" {
    type = string
    description = "The Azure Active Directory (AAD) tenant ID."
}

variable "resource_group_name" {
    type = string
    description = "The name of the Azure resource group to contain the deployed resources."
}

variable "devops_token" {
    type = string
    description = "The personal access token (PAT) for authenticating with Azure DevOps."
}

variable "organisation_url" {
    type = string
    description = "The URL of your Azure DevOps organization."
}

variable "agent_pool" {
    type = string
    description = "The name of the agent pool where the build agent will be registered."
}

variable "registry_name" {
    type = string
    description = "The name of the Azure Container Registry (ACR) to store the azure-build-agent image."
}

variable "agent_name" {
    type = string
    description = "A custom name for the build agent."
    default = "buildagent"
}

variable "log_analytics_name" {
    type = string
    description = "The name of the Log Analytics workspace for monitoring logs."
    default = "build-agent-log-analytics"
}

variable "container_app_env_name" {
    type = string
    description = "The name of the container environment."
    default = "build-agent-environment"
}

variable "container_app_job_name" {
    type = string
    description = "The name of the container app job associated with the build agent."
    default = "build-agent-container-app-job"
}