FROM ubuntu:latest

RUN  apt-get update &&\
     apt-get install  -y \
     golang-go \
     git \
     git-core

RUN cd /usr/local && git clone https://github.com/MartinHouhui/ngrok.git

ENV GOPATH /usr/local/ngrok/

ADD *.sh /

ENV DOMAIN **None**
ENV TUNNEL_ADDR :4443
ENV HTTP_ADDR :80
ENV HTTPS_ADDR :443

VOLUME ["/release"]

EXPOSE 4443
EXPOSE 80
EXPOSE 443

CMD /bin/sh
