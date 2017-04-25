FROM golang:1.7.1-alpine
MAINTAINER hteen <i@hteen.cn>

RUN apk add --no-cache git make openssl

RUN git clone https://github.com/inconshreveable/ngrok.git /ngrok

RUN cd /ngrok &&\
    GOOS=linux GOARCH=amd64 make release-server  &&\
    GOOS=linux GOARCH=386 make release-client  &&\
    GOOS=linux GOARCH=amd64 make release-client  &&\
    GOOS=windows GOARCH=386 make release-client  &&\
    GOOS=windows GOARCH=amd64 make release-client  &&\
    GOOS=darwin GOARCH=386 make release-client  &&\
    GOOS=darwin GOARCH=amd64 make release-client  &&\
    GOOS=linux GOARCH=arm make release-client

ADD *.sh /

ENV DOMAIN **None**
ENV MY_FILES /myfiles
ENV TUNNEL_ADDR :4443
ENV HTTP_ADDR :80
ENV HTTPS_ADDR :443

EXPOSE 4443
EXPOSE 80
EXPOSE 443

CMD /bin/sh
