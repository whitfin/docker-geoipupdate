#!/bin/sh -ex

./exec.sh
echo "${CRON_SCHEDULE} root /exec.sh" >> /etc/crontab
while true
do
  sleep 3600
done
