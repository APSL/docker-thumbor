FROM apsl/thumbor

MAINTAINER Edu Herraiz <ghark@gmail.com>

COPY requirements.txt /usr/src/app/requirements.txt
RUN pip install --trusted-host None --no-cache-dir --use-wheel \
   --extra-index-url http://172.17.0.1:9009/simple/ \
   --trusted-host 172.17.0.1 \
   -r /usr/src/app/requirements.txt

ADD conf/circus.ini.tpl /etc/
RUN mkdir  /etc/circus.d /etc/setup.d
ADD conf/thumbor.ini.tpl /etc/circus.d/

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["circus"]

EXPOSE 8888 8000