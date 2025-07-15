resource "azurerm_resource_group" "rg" {
    for_each = var.resource_group
  name  =each.value.name
  location = each.value.location
}

resource "azurerm_kubernetes_cluster" "aks" {
    depends_on = [ azurerm_resource_group.rg ]
    for_each = var.aks
  name                = "zayo-aks"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}

