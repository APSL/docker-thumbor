FROM apsl/circusbase
MAINTAINER Edu Herraiz <eherraiz@apsl.net>

#nginx
RUN \
    add-apt-repository -y ppa:nginx/stable && \
    apt-get update && \
    apt-get install nginx-full && \
    apt-get clean

ADD circus.d/nginx.ini.tpl /etc/circus.d/
ADD setup.d/nginx /etc/setup.d/30-nginx
ADD conf/nginx.conf /etc/nginx/nginx.conf

VOLUME /logs

# Things required for a python/pip environment
RUN  \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y -q install python-numpy python-opencv git \
    mercurial curl build-essential libcurl4-openssl-dev \
    python python-dev python-distribute python-pip && \
    apt-get -y -q install libdc1394-22 libdc1394-22-dev libjpeg-dev \
    libpng12-dev libtiff4-dev libjasper-dev && \
    apt-get clean

# thumbor user and dirs
RUN \
    addgroup --system --gid 500 thumbor;\
    adduser --system --shell /bin/bash --gecos 'Thumbor app user' --uid 500 --gid 500 --disabled-password --home /code thumbor ;\
    mkdir -p /data;\
    chown thumbor.thumbor /data -R

# thumbor conf
ADD setup.d/thumbor /etc/setup.d/40-thumbor
ADD circus.d/thumbor.ini.tpl /etc/circus.d/

# virtualenv
RUN \
    pip --no-input install virtualenv==1.11.6 && \
    pip --no-input install pew==0.1.14 && \
    pip --no-input install chaussette==1.2 && \
    pip --no-input install PyYAML==3.11 # needed for install_crons

# create Virtualenv
ENV HOME /code
ENV SHELL bash
ENV WORKON_HOME /code
WORKDIR /code/src

RUN su -c "pew-new env -i ipython" thumbor

COPY thumbor.conf /tmp/thumbor.conf
COPY requirements.txt /tmp/requirements.txt
RUN su -c "pew-in env pip install -r /tmp/requirements.txt" thumbor

# nginx thumbor
EXPOSE 8001 80
