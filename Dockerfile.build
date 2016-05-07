FROM python:2

MAINTAINER Edu Herraiz <ghark@gmail.com>

# Things required for a python/pip environment
COPY system-requirements-build.txt /system-requirements-build.txt
RUN  \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y autoremove && \
    xargs apt-get -y -q install < /system-requirements-build.txt && \
    apt-get clean

ENV WHEELHOUSE=/wheelhouse
ENV PIP_WHEEL_DIR=/wheelhouse
ENV PIP_FIND_LINKS=/wheelhouse
VOLUME /wheelhouse

RUN pip install wheel
COPY requirements-build.txt /requirements.txt
CMD pip wheel -r /requirements.txt
