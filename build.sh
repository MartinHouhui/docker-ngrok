#!/bin/sh
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please set DOMAIN"
    exit 1
fi

cd ${MY_FILES}
if [ ! -f "${MY_FILES}/rootCA.pem" ]; then
    openssl genrsa -out rootCA.key 2048

    openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem

    openssl genrsa -out device.key 2048

    openssl req -new -key device.key -subj "/CN=$NGROK_DOMAIN" -out device.csr

    openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000

    cp rootCA.pem assets/client/tls/ngrokroot.crt

    cp device.crt assets/server/tls/snakeoil.crt

    cp device.key assets/server/tls/snakeoil.key
fi

cp -r /ngrok/bin ${MY_FILES}/bin

echo "build ok !"
