FROM apsl/thumbor

MAINTAINER Edu Herraiz <ghark@gmail.com>

COPY requirements.txt /usr/src/app/requirements.txt
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt


ADD conf/circus.ini.tpl /etc/
ADD start.sh /bin/
RUN mkdir  /etc/circus.d /etc/setup.d
ADD conf/thumbor.ini.tpl /etc/circus.d/

EXPOSE 8888
CMD ["/bin/start.sh"]
