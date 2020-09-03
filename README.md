# Dehydrated dockerized
Docker container for signing certificate with an ACME-server (by default using [letsencrypt.org](https://letsencrypt.org)) using [dehydrated](https://github.com/dehydrated-io/dehydrated).
The certification container is implemented as a one-shot container and it will exist after renewing the certificates.

## Usage with nginx
1. Add your domain to ```domains.txt``` (and remove example.com)
  **IMPORTANT**: Make sure to keep the empty line at the end.
2. Create nginx conf based on conf.d/nginx.example.com.conf and change all mentions of example.com to your domain name. 
3. Run ```docker-compose up certs```. 
   This will create the required Diffie-Hellman file as well as dummy certificates.
   It is expected that this command will fail after creating the dummy certificates. 
   These are required as nginx won't start if the referenced certificate files do not exist.
4. Start nginx ```docker-compose up -d nginx```
5. Start certs to create signed certificates ```docker-compose up certs```
6. Reload nginx ```docker-compose exec nginx nginx -s reload```

Done

## Auto renew
You can automatically check weekly for the renewal of your certificates by adding the following cron-job to ```/etc/cron.weekly/certs``` and change the path to your compose file.
```
#!/bin/sh

set -e
cd /path/to/docker-compose-file
docker-compose up certs
docker-compose exec nginx nginx -s reload
```

## Build container from source
```
make build-latest
```
