# Utilisation de l'image PHP-FPM officielle
FROM php:8.0-fpm

# Installation de Nginx
RUN apt-get update && apt-get install -y nginx

# Copie des fichiers de l'application
COPY app.php /var/www/html/

# Configuration de Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Exposition du port 3002
EXPOSE 3002

# Commande de démarrage
CMD ["sh", "-c", "service nginx start && php-fpm -F"]

