ARG THUMBOR_TAG=latest
FROM apsl/thumbor:$THUMBOR_TAG

MAINTAINER Edu Herraiz <ghark@gmail.com>

VOLUME /data

ENV HOME /usr/src/app
ENV SHELL bash
ENV WORKON_HOME /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/requirements.txt
RUN pip install --trusted-host None --no-cache-dir \
   -r /usr/src/app/requirements.txt

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["remotecv"]
