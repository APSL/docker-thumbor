FROM python:2.7-slim-buster as builder

COPY requirements/system-requirements.txt /srv/system-requirements.txt
RUN apt-get update \
    && xargs apt-get -y -q install < /srv/system-requirements.txt \
    && apt-get clean

COPY requirements/requirements.txt /srv/requirements.txt
RUN pip install -r /srv/requirements.txt


FROM python:2.7-slim-buster

LABEL maintainer="Edu Herraiz <ghark@gmail.com>"

ENV HOME /usr/src/app
ENV SHELL bash
ENV WORKON_HOME $HOME
ENV THUMBOR_VERSION 6.7.5

WORKDIR $HOME

COPY --from=builder /usr/local/lib/python2.7/site-packages /usr/local/lib/python2.7/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/bin /usr/bin

COPY thumbor.conf.template $HOME/thumbor.conf.tpl

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["thumbor"]

VOLUME /data

EXPOSE 8000
