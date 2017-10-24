# docker-geoipupdate

Minimal container for running `geoipupdate` without needing it installed on your host system.

It includes everything you need to customize your installation, whilst remaining much smaller than the other `geoipupdate` images on Docker Hub (approximately 6MB).

## Usage

This image is designed to be executed as a single command, to invoke `geoipupdate` from your host.

```shell
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
    -e GEOIP_USER_ID=999999 \
    -e GEOIP_LICENSE_KEY=000000000000 \
    -e GEOIP_PRODUCT_IDS='GeoLite2-City GeoLite2-Country' \
    -e GEOIP_DIRECTORY='/usr/local/share/GeoIP' \
    -v ./geoip:/usr/local/share/GeoIP \
    whitfin/geoipupdate
```
