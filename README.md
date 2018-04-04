# Docker Geoipupdate

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
    -e GEOIP_USER_ID=999999 \
    -e GEOIP_LICENSE_KEY=000000000000 \
    -e GEOIP_PRODUCT_IDS='GeoLite2-City GeoLite2-Country' \
    -e GEOIP_DIRECTORY='/usr/local/share/GeoIP' \
    -v ./geoip:/usr/local/share/GeoIP \
    whitfin/geoipupdate
```

### Environment Variables

#### GEOIP_DIRECTORY

Directory where the GeoIP mmdb file is installed to

#### GEOIP_PRODUCT_IDS

Space separated string of all MaxMind GeoIP products

#### GEOIP_USER_ID

User ID of the GeoIP account

#### GEOIP_LICENSE_KEY

License key for GeoIP DB product

#### VALID_GEOIP_IP

IP to test connection to GeoIP service