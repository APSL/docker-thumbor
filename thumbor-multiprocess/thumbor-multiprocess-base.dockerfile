ARG FROMTAG=latest
FROM apsl/thumbor:${FROMTAG} as builder

COPY requirements/system-requirements.txt /srv/system-requirements.txt
RUN apt-get update \
    && xargs apt-get -y -q install < /srv/system-requirements.txt \
    && apt-get clean

COPY requirements/requirements.txt /usr/src/app/requirements.txt
RUN pip install --no-cache-dir --only-binary=wheel \
   -r /usr/src/app/requirements.txt

FROM apsl/thumbor:${FROMTAG}

LABEL MAINTAINER Edu Herraiz <ghark@gmail.com>

# ARG DOCKERHOST=172.17.0.1
# ENV DOCKERHOST ${DOCKERHOST}

COPY --from=builder /usr/local/lib/python2.7/site-packages /usr/local/lib/python2.7/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/bin /usr/bin

ADD conf/circus.ini.tpl /etc/
RUN mkdir  /etc/circus.d /etc/setup.d
ADD conf/thumbor.ini.tpl /etc/circus.d/

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["circus"]

EXPOSE 8888 8000