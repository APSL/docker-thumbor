FROM nginx:1.9
MAINTAINER Edu Herraiz <ghark@gmail.com>

COPY nginx.conf /etc/nginx/
COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx-daemon"]
