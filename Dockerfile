FROM alpine
RUN apk add --update \
    bash \
    curl \
    openssl \
    && rm -rf /var/cache/apk/*
    
ADD https://raw.githubusercontent.com/dehydrated-io/dehydrated/master/dehydrated /bin/dehydrated
RUN chmod +x /bin/dehydrated
ADD renewCert.sh /renewCert.sh

ADD config /dehydrated/config

WORKDIR /dehydrated
ENTRYPOINT ["bash", "/renewCert.sh"]
