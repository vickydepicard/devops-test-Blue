output "connection_string" {
  description = "Chaîne de connexion au service Cloud SQL"
  value       = google_sql_database_instance.instance.connection_name
}

output "admin_user" {
  description = "Compte administrateur créé pour la base"
  value       = google_sql_user.admin_user.name
}

output "admin_password" {
  description = "Mot de passe administrateur généré"
  value       = random_password.admin_pw.result
  sensitive   = true
}

