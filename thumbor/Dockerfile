FROM apsl/circusbase
MAINTAINER Edu Herraiz <eherraiz@apsl.net>

#nginx
RUN \
    add-apt-repository -y ppa:nginx/stable && \
    apt-get update && \
    apt-get install nginx-full && \
    apt-get clean

COPY circus.d/nginx.ini.tpl /etc/circus.d/
COPY setup.d/nginx /etc/setup.d/30-nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

VOLUME /logs
VOLUME /data

# Things required for a python/pip environment
RUN  \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y -q install python-numpy python-opencv git \
    mercurial curl build-essential libcurl4-openssl-dev \
    python python-dev python-distribute python-pip \
    libdc1394-22 libdc1394-22-dev libjpeg-dev \
    libpng12-dev libtiff4-dev libjasper-dev \
    libjpeg-turbo-progs && \
    apt-get clean

# thumbor user and dirs
RUN \
    addgroup --system --gid 500 thumbor;\
    adduser --system --shell /bin/bash --gecos 'Thumbor app user' --uid 500 --gid 500 --disabled-password --home /code thumbor ;\
    mkdir -p /data;\
    chown thumbor.thumbor /data -R

# thumbor conf
COPY setup.d/thumbor /etc/setup.d/40-thumbor
COPY circus.d/thumbor.ini.tpl /etc/circus.d/

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
WORKDIR /code

COPY requirements.txt /code/requirements.txt
RUN su -c "pew-new env -i ipython" thumbor
RUN su -c "pew-in env pip install -r /code/requirements.txt" thumbor
COPY conf/thumbor.conf.tpl /code/thumbor.conf.tpl

# Include opencv in virtualenv
RUN su -c "ln -s /usr/lib/python2.7/dist-packages/cv2.so /code/env/lib/python2.7/site-packages/cv2.so" thumbor
RUN su -c "ln -s /usr/lib/python2.7/dist-packages/cv.py /code/env/lib/python2.7/site-packages/cv.py" thumbor

# nginx thumbor
EXPOSE 80 8000
