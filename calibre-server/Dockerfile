FROM ubuntu:16.04
MAINTAINER Mikhail Petrov <azalio@azalio.net>

RUN apt-get update
RUN apt-get -y install wget python git xz-utils imagemagick xdg-utils xvfb
RUN rm /tmp/calibre* -Rf 2>&1 >/dev/null && wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"

RUN mkdir -p /calibre-lib/toadd
WORKDIR /calibre-lib/toadd
RUN wget http://www.gutenberg.org/ebooks/1342.kindle.noimages -O pride.mobi
RUN xvfb-run calibredb add /calibre-lib/toadd/* --library-path /calibre-lib
WORKDIR /opt/calibre
VOLUME ["/calibre-lib"]
EXPOSE 8080

CMD /opt/calibre/calibre-server --disable-auth --port=8080 "/calibre-lib" 
