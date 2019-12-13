ARG FROMTAG=latest
FROM apsl/thumbor:${FROMTAG}

LABEL MAINTAINER Edu Herraiz <ghark@gmail.com>

COPY requirements/system-requirements-full.txt /srv/system-requirements-full.txt
RUN apt-get update \
    && xargs apt-get -y -q install < /srv/system-requirements-full.txt \
    && apt-get clean
