FROM apsl/circusbase
MAINTAINER Edu Herraiz <eherraiz@apsl.net>

VOLUME /logs

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

# remotecv user and dirs
RUN \
    addgroup --system --gid 500 remotecv;\
    adduser --system --shell /bin/bash --gecos 'Remotecv app user' --uid 500 --gid 500 --disabled-password --home /code remotecv 

# remotecv conf
COPY circus.d/remotecv.ini.tpl /etc/circus.d/

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
RUN su -c "pew-new env -i ipython" remotecv
RUN su -c "pew-in env pip install -r /code/requirements.txt" remotecv

# Include opencv in virtualenv
RUN su -c "ln -s /usr/lib/python2.7/dist-packages/cv2.so /code/env/lib/python2.7/site-packages/cv2.so" remotecv
RUN su -c "ln -s /usr/lib/python2.7/dist-packages/cv.py /code/env/lib/python2.7/site-packages/cv.py" remotecv
