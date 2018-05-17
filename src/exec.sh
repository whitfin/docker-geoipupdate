#!/bin/sh -e

# set a configuration file if not already set
! (: "${GEOIP_CONFIG_FILE?}") 2>/dev/null && {
    GEOIP_CONFIG_FILE="/usr/local/etc/GeoIP.conf"
    echo "UserId ${GEOIP_USER_ID:-"999999"}" > $GEOIP_CONFIG_FILE
    echo "LicenseKey ${GEOIP_LICENSE_KEY:-"000000000000"}" >> $GEOIP_CONFIG_FILE
    echo "ProductIds ${GEOIP_PRODUCT_IDS:-"GeoLite2-City"}" >> $GEOIP_CONFIG_FILE
    echo "DatabaseDirectory /tmp " >> $GEOIP_CONFIG_FILE
}

# execute the updates with verbose output
geoipupdate -f $GEOIP_CONFIG_FILE -v

ruby validate_mmdb.rb /tmp/GeoIP2-City.mmdb ${VALID_GEOIP_IP}

[[ ! -d ${GEOIP_DIRECTORY} ]] && mkdir -p ${GEOIP_DIRECTORY}
mv /tmp/GeoIP2-City.mmdb ${GEOIP_DIRECTORY}/geoip.mmdb

