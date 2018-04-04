FROM ruby:alpine

ARG VERSION
RUN apk add --update curl && \
    apk add --virtual .build-deps \
        autoconf \
        automake \
        curl-dev \
        gcc \
        git \
        libtool \
        make \
        musl-dev \
        zlib-dev && \
    git clone https://github.com/maxmind/geoipupdate.git /tmp/geoipupdate && \
    cd /tmp/geoipupdate && \
    git checkout ${VERSION} && \
    ./bootstrap && \
    ./configure && \
    make && \
    make install && \
    cd - && \
    apk del .build-deps && \
    rm -rf /tmp/geoipupdate* && \
    rm -rf /var/cache/apk/*

RUN gem install pure_mmdb

ENV VALID_GEOIP_IP ""
ENV GEOIP_USER_ID ""
ENV GEOIP_PRODUCT_IDS GeoIP2-City
ENV GEOIP_LICENSE_KEY ""
ENV GEOIP_DIRECTORY /usr/local/share/GeoIP
ENV CRON_SCHEDULE ""

COPY src/startup.sh /
COPY validate_mmdb.rb /
ADD src/exec.sh /
CMD [ "/startup.sh" ]
