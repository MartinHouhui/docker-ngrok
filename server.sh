#!/bin/sh
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please set DOMAIN"
    exit 1
fi

echo "ngrokd is not build,will be build it now..."
/build.sh


/usr/local/ngrok/bin/ngrokd  -domain="${DOMAIN}" -httpAddr=${HTTP_ADDR} 

