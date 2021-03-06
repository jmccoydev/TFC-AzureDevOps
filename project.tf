# Create the AzDO Project and a variable group to be used with pipelines

resource "azuredevops_project" "project" {
  project_name = var.adoProjectName
  description  = "Terraform build ADO Project"

  # (Optional) Disable unused features
  features = {
    testplans = "disabled"
    boards    = "disabled"
    testplans = "disabled"
    artifacts = "disabled"
  }
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
    name         = "tfeToken"
    secret_value = var.tfeToken
    is_secret    = true
  }
}
