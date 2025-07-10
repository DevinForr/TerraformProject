output "load_balancer_name" {
  description = "Name of the public load balancer"
  value       = azurerm_lb.load_balancer.name
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.backend_pool.id
}