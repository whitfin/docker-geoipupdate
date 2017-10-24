FROM alpine:latest

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

ADD src/exec.sh /
CMD [ "/exec.sh" ]
