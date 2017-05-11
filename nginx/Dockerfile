FROM nginx:1.13.0

MAINTAINER Edu Herraiz <gshark@gmail.com>

COPY docker-entrypoint.sh /
COPY nginx.conf /etc/nginx/

RUN chmod -R 777 /var/log/nginx /var/cache/nginx/ /var/run /etc/nginx \
    && chmod 644 /etc/nginx/*

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx"]

ENV \
  THUMBOR_DEFAULT_HOST= \
  THUMBOR_DEFAULT_PORT=8000 \
  NGINX_DEFAULT_PORT=80 \
  # THUMBOR_ALLOW_CORS=true \
  # THUMBOR_ALLOW_CONTENT_DISPOSITION=true \
  AUTO_WEBP=true \
  NGINX_CACHE_FILESYSTEM_SIZE_MB= \
  NGINX_CACHE_FILESYSTEM_PATH=
