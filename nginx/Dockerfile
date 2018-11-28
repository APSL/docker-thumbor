FROM nginx:1.15.7-alpine

LABEL maintainer="Edu Herraiz <ghark@gmail.com>"

ENV RESULT_STORAGE_FILE_STORAGE_ROOT_PATH /data/result_storage
ENV PATH_FORMAT_VERSION v2
ENV THUMBOR_HOST thumbor
ENV THUMBOR_PORT 8000
ENV NGINX_PORT 80

RUN apk --update add bash

COPY nginx.conf /etc/nginx/nginx.conf
COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx-daemon"]
