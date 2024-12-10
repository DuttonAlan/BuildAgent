locals {
  image_name = "azure-build-agent"
  image_tag = "latest"
}

resource "azurerm_container_registry" "acr" {
  name = var.registry_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location  = data.azurerm_resource_group.rg.location
  sku = "Basic"
  admin_enabled = true
}

resource "null_resource" "docker_image" {
  depends_on = [ azurerm_container_registry.acr ]
  triggers = {
      image_name = local.image_name
      image_tag = local.image_tag
      registry_uri = azurerm_container_registry.acr.login_server
      dockerfile_path = "./image/Dockerfile"
      dockerfile_context = "./image"
      registry_admin_username = azurerm_container_registry.acr.admin_username
      registry_admin_password = azurerm_container_registry.acr.admin_password
      dir_sha1 = sha1(join("", [for f in fileset(path.cwd, "image/*") : filesha1(f)]))
  }
  provisioner "local-exec" {
      command = "./scripts/docker_build_and_push_to_acr.sh ${self.triggers.image_name} ${self.triggers.image_tag} ${self.triggers.registry_uri} ${self.triggers.dockerfile_path} ${self.triggers.dockerfile_context} ${self.triggers.registry_admin_username} ${self.triggers.registry_admin_password}" 
      interpreter = [ "bash", "-c" ]
  }
}