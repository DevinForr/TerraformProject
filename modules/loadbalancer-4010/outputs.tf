output "load_balancer_name" {
  description = "Name of the public load balancer"
  value       = azurerm_lb.load_balancer.name
}

