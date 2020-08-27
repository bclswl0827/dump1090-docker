#!/bin/bash

mkdir -p /run/dump1090-fa

if [ -z "$LAT" ]; then
	echo >&2 'error: missing required LAT environment variable'
	echo >&2 '  Did you forget to -e LAT="..." ?'
	exit 1
fi

if [ -z "$LON" ]; then
	echo >&2 'error: missing required LON environment variable'
	echo >&2 '  Did you forget to -e LON=... ?'
	exit 1
fi

cat << EOF > /etc/default/dump1090-fa
ENABLED=yes

RECEIVER_OPTIONS="--gain 50 --ppm 0"
DECODER_OPTIONS="--lat ${LAT} --lon ${LON} --max-range 360 --fix"

NET_OPTIONS="--net --net-heartbeat 60 --net-ro-size 1300 --net-ro-interval 0.2 --net-ri-port 0 --net-ro-port 30002 --net-sbs-port 30003 --net-bi-port 30004,30104 --net-bo-port 30005"
JSON_OPTIONS="--json-location-accuracy 1"
EOF

/etc/init.d/lighttpd restart
/usr/share/dump1090-fa/start-dump1090-fa --write-json /run/dump1090-fa --quiet

