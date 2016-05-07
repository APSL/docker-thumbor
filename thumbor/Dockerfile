FROM python:2

MAINTAINER Edu Herraiz <ghark@gmail.com>

VOLUME /data

# Things required for a python/pip environment
COPY system-requirements.txt /usr/src/app/system-requirements.txt
RUN  \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y autoremove && \
    xargs apt-get -y -q install < /usr/src/app/system-requirements.txt && \
    apt-get clean

ENV HOME /usr/src/app
ENV SHELL bash
ENV WORKON_HOME /usr/src/app
WORKDIR /usr/src/app
ENV WHEELHOUSE=/wheelhouse
ENV PIP_WHEEL_DIR=/wheelhouse
ENV PIP_FIND_LINKS=/wheelhouse

COPY wheelhouse /wheelhouse
COPY requirements.txt /usr/src/app/requirements.txt
RUN pip install --no-cache-dir --use-wheel --find-links /wheelhouse -r /usr/src/app/requirements.txt

COPY conf/thumbor.conf.tpl /usr/src/app/thumbor.conf.tpl

RUN \ 
    ln /usr/lib/python2.7/dist-packages/cv2.x86_64-linux-gnu.so /usr/local/lib/python2.7/cv2.so && \
    ln /usr/lib/python2.7/dist-packages/cv.py /usr/local/lib/python2.7/cv.py

RUN rm -Rf /wheelhouse
    
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["thumbor"]

EXPOSE 8000
