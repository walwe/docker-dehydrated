#!/bin/bash -e

dehydrated_dir="/dehydrated"
acme_dir=$dehydrated_dir/acme-challenges/

cd $dehydrated_dir

if [[ ! -f certs/dh4096.pem ]]; then
    openssl dhparam -out certs/dh4096.pem 4096
fi

# Create dummy certificates so nginx can start
while read domain; do
    CERT_PATH="certs/${domain}"
    if [[ ! -d "${CERT_PATH}" ]]; then
        echo "Creating dummy certificate for ${CERT_PATH}"
        mkdir -p "${CERT_PATH}"
        openssl req -newkey rsa:2048 -new -nodes -x509 -days 365 \
         -subj "/C=US/ST=Oregon/L=Portland/O=Company Name/OU=Org/CN=${domain}" \
         -keyout "${CERT_PATH}/privkey.pem" \
         -out "${CERT_PATH}/fullchain.pem"
    fi
done <domains.txt

# Create and sign certificates
dehydrated --register --accept-terms
dehydrated -c
