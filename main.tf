resource "random_pet" "project" {
  length = 3
}

resource "azuredevops_project" "project" {
  project_name = random_pet.project.id
  description  = "Terraform build ADO Project"
}

resource "azuredevops_variable_group" "tfe" {
  project_id   = azuredevops_project.project.id
  name         = "TFE Variable Group"
  description  = "Variables for TFE that are generic across pipelines"
  allow_access = true

  variable {
    name  = "tfeHostName"
    value = var.tfeHostName
  }
  variable {
    name  = "tfeOrganizationName"
    value = var.tfeOrganizationName
  }
  variable {
    name      = "tfeToken"
    value     = var.tfeToken
    is_secret = true
  }
}
