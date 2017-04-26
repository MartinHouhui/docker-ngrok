FROM ubuntu:latest

# gcc for cgo
RUN  add-apt-repository ppa:longsleep/golang-backports &&\
     apt-get update &&\
     apt-get install golang-go &&\
     apt-get install git 

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
