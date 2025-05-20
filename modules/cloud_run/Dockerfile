# Base PHP-FPM image
FROM php:8.0-fpm

# Installe nginx et gettext pour utiliser envsubst
RUN apt-get update && apt-get install -y nginx gettext-base

# Copie des fichiers de l'application
COPY app.php /var/www/html/
COPY nginx.conf /etc/nginx/nginx.conf

# Expose le port attendu par Cloud Run
EXPOSE 8080

# Commande de démarrage avec substitution dynamique du port
CMD sh -c "envsubst '\$PORT' < /etc/nginx/nginx.conf > /etc/nginx/nginx.subst.conf && \
           php-fpm & \
           nginx -c /etc/nginx/nginx.subst.conf -g 'daemon off;'"

