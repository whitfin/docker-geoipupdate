#!/bin/sh -e

# set a configuration file if not already set
! (: "${GEOIP_CONFIG_FILE?}") 2>/dev/null && {
    GEOIP_CONFIG_FILE="/etc/GeoIP.conf"
    [[ ! -z $GEOIP_USER_ID ]] && {
        echo "AccountID $GEOIP_ACCOUNT_ID" > $GEOIP_CONFIG_FILE
    }
    [[ ! -z $GEOIP_LICENSE_KEY ]] && {
        echo "LicenseKey $GEOIP_LICENSE_KEY" > $GEOIP_CONFIG_FILE
    }
    echo "ProductIds ${GEOIP_PRODUCT_IDS:-"GeoLite2-City GeoLite2-Country"}" >> $GEOIP_CONFIG_FILE
    echo "DatabaseDirectory ${GEOIP_DIRECTORY:-"/usr/local/share/GeoIP"}" >> $GEOIP_CONFIG_FILE
}

# execute the updates with verbose output
geoipupdate -f $GEOIP_CONFIG_FILE -v
