# Azure Build Agent

This repository includes an Azure build agent that is deployed using Terraform to easily create build agents for your Azure Pipelines.

## Prerequisites

Before you begin, ensure the following tools are installed on your system:

### Docker

To check if Docker is installed, run:

```bash
docker --version
```

If Docker is not recognized, you need to install it. Follow the installation guide [here](https://docs.docker.com/engine/install/).

### Terraform

To check if Terraform is installed, run:

```bash
terraform --version
```

If Terraform is not recognized, you need to install it. Follow the installation guide [here](https://developer.hashicorp.com/terraform/install).

## How to Use

### Clone the Repository

Clone this repository by running the following command:

```bash
git clone <repository-url>
```

### Configure Variables

Once the repository is downloaded, set up the required variables for the configuration.

1. Create a `terraform.tfvars` file in the root folder of the project.
2. Define the variables in the following format:

```hcl
<variable_name> = "<value>"
```

3. To set the following variables, you need to create a service principal in Azure:
   - `client_id`: appId
   - `client_secret`: password
   - `tenant_id`: tenant

   Follow the guide [here](https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal) to create a service principal.

#### Required Variables

- `subscription_id`: The unique identifier of your Azure subscription where the resources will be deployed.
- `client_id`: The application (client) ID of the service principal used for authentication.
- `client_secret`: The password or secret associated with the service principal.
- `tenant_id`: The Azure Active Directory (AAD) tenant ID.
- `devops_token`: The personal access token (PAT) for authenticating with Azure DevOps.
- `organisation_url`: The URL of your Azure DevOps organization.
- `agent_pool`: The name of the agent pool where the build agent will be registered.
- `resource_group_name`: The name of the Azure resource group to contain the deployed resources.
- `registry_name`: The name of the Azure Container Registry (ACR) to store the azure-build-agent image.

#### Optional Variables

- `agent_name`: A custom name for the build agent.
- `log_analytics_name`: The name of the Log Analytics workspace for monitoring logs.
- `container_app_env_name`: The name of the container environment.
- `container_app_job_name`: The name of the container app job associated with the build agent.

## Running the Configuration

1. **Start Docker:** Ensure the Docker engine is running in the background. If it’s not, start Docker Desktop.

2. **Initialize the Configuration:**

   Navigate to the root folder of the project and run:

   ```bash
   terraform init
   ```

3. **Create a Plan:**

   Generate a plan to review the changes Terraform will make:

   ```bash
   terraform plan
   ```

   Review the output to see what will be added, changed, or deleted.

4. **Apply the Configuration:**

   Deploy the Azure build agent by running:

   ```bash
   terraform apply
   ```

   When prompted, type **yes** to confirm the deployment. Once completed, your Azure build agent will be running.

### Test the Agent

To verify that the agent is working, run a pipeline. Ensure the pipeline’s pool matches the pool where the agent is running.

## Contact

- **Jannik Funk**
- **Alan Dutton**

