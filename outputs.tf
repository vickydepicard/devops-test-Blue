output "sql_connection_string" {
  description = "Chaîne de connexion de l’instance Cloud SQL"
  value       = module.db_module.connection_string
}

output "sql_admin_account" {
  description = "Compte administrateur de la base"
  value       = module.db_module.admin_user
}

output "sql_admin_password" {
  description = "Mot de passe administrateur "
  value       = module.db_module.admin_password
  sensitive   = true
}

