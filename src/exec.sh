#!/bin/sh -e

# set a configuration file if not already set
! (: "${GEOIP_CONFIG_FILE?}") 2>/dev/null && {
    GEOIP_CONFIG_FILE="/usr/local/etc/GeoIP.conf"
    mkdir -p $(dirname $GEOIP_CONFIG_FILE)
    echo "UserId ${GEOIP_USER_ID:-"999999"}" > $GEOIP_CONFIG_FILE
    echo "LicenseKey ${GEOIP_LICENSE_KEY:-"000000000000"}" >> $GEOIP_CONFIG_FILE
    echo "ProductIds ${GEOIP_PRODUCT_IDS:-"GeoLite2-City GeoLite2-Country"}" >> $GEOIP_CONFIG_FILE
    echo "DatabaseDirectory ${GEOIP_DIRECTORY:-"/usr/local/share/GeoIP"}" >> $GEOIP_CONFIG_FILE
}

# execute the updates with verbose output
geoipupdate -f $GEOIP_CONFIG_FILE -v
