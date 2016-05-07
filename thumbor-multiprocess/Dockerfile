FROM apsl/thumbor

MAINTAINER Edu Herraiz <ghark@gmail.com>

ENV WHEELHOUSE=/wheelhouse
ENV PIP_WHEEL_DIR=/wheelhouse
ENV PIP_FIND_LINKS=/wheelhouse

COPY wheelhouse /wheelhouse

COPY requirements.txt /usr/src/app/requirements.txt
RUN pip install --no-cache-dir --use-wheel --find-links /wheelhouse -r /usr/src/app/requirements.txt

ADD conf/circus.ini.tpl /etc/
RUN mkdir  /etc/circus.d /etc/setup.d
ADD conf/thumbor.ini.tpl /etc/circus.d/

RUN rm -Rf /wheelhouse

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["circus"]

EXPOSE 8888 8000