FROM python:2

MAINTAINER Edu Herraiz <ghark@gmail.com>

VOLUME /data

# Things required for a python/pip environment
COPY system-requirements.txt /usr/src/app/system-requirements.txt
RUN  \
    awk '$1 ~ "^deb" { $3 = $3 "-backports"; print; exit }' /etc/apt/sources.list > /etc/apt/sources.list.d/backports.list && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y autoremove && \
    xargs apt-get -y -q install < /usr/src/app/system-requirements.txt && \
    apt-get clean

ENV HOME /usr/src/app
ENV SHELL bash
ENV WORKON_HOME /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/requirements.txt
# pinning to 9.0.3 because of tornado-botocore.
# See https://github.com/nanvel/tornado-botocore/pull/14
RUN pip install -U pip==9.0.3
RUN pip install --trusted-host None --no-cache-dir \
   -r /usr/src/app/requirements.txt

COPY conf/thumbor.conf.tpl /usr/src/app/thumbor.conf.tpl

RUN \
    ln /usr/lib/python2.7/dist-packages/cv2.x86_64-linux-gnu.so /usr/local/lib/python2.7/cv2.so && \
    ln /usr/lib/python2.7/dist-packages/cv.py /usr/local/lib/python2.7/cv.py

ARG SIMD_LEVEL
# pinning to 4.3.0 see https://github.com/uploadcare/pillow-simd/issues/17
RUN if [ -n "$SIMD_LEVEL" ]; then pip uninstall -y pillow; CC="cc -m$SIMD_LEVEL" pip install --no-cache-dir -U --force-reinstall Pillow-SIMD==4.3.0.post0; fi

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["thumbor"]

EXPOSE 8000
