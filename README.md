# Docker Geoipupdate

[![Build Status](https://img.shields.io/github/actions/workflow/status/whitfin/docker-geoipupdate/ci.yml?branch=main)](https://github.com/whitfin/docker-geoipupdate/actions) ![Docker Image Version](https://img.shields.io/docker/v/whitfin/geoipupdate) ![Docker Pulls](https://img.shields.io/docker/pulls/whitfin/geoipupdate)

Minimal container for updating Maxmind GeoIP databases on your host system without having to install the required dependencies.

It includes everything you need to customize your installation, whilst remaining much smaller than the other `geoipupdate` images on Docker Hub (approximately 6MB).

## Usage

This image is designed to be executed as a single command, to invoke `geoipupdate` from your host.

```bash
# download defaults into ./geoip
$ docker run --rm \
    -v ./geoip:/usr/local/share/GeoIP \
    whitfin/geoipupdate

# download into ./geoip using a custom configuration file
$ docker run --rm \
    -e GEOIP_CONFIG_FILE=/usr/local/share/GeoIP/config.conf \
    -v ./geoip:/usr/local/share/GeoIP \
    whitfin/geoipupdate

# download into ./geoip using manually configured settings
$ docker run --rm \
    -e GEOIP_ACCOUNT_ID=999999 \
    -e GEOIP_LICENSE_KEY=000000000000 \
    -e GEOIP_EDITION_IDS='GeoLite2-City GeoLite2-Country' \
    -e GEOIP_DIRECTORY='/usr/local/share/GeoIP' \
    -v ./geoip:/usr/local/share/GeoIP \
    whitfin/geoipupdate
```

If you are on older versions of `geoipupdate`, you might need to provide the `GEOIP_USER_ID` instead of `GEOIP_ACCOUNT_ID` and `GEOIP_PRODUCT_IDS` instead of `GEOIP_EDITION_IDS`.

