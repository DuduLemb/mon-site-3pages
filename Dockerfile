FROM nginx:alpine
COPY . /usr/share/nginx/html
# Optionnel: custom nginx conf
# COPY nginx.conf /etc/nginx/conf.d/default.conf
