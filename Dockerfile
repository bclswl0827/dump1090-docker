FROM debian:buster
ARG DEBIAN_FRONTEND=noninteractive
LABEL maintainer "Yuki Kikuchi <bclswl0827@yahoo.co.jp>"

RUN sed -i "s/deb.debian.org/mirrors.bfsu.edu.cn/g" /etc/apt/sources.list \
 && sed -i "s/security.debian.org/mirrors.bfsu.edu.cn/g" /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y git \
                       build-essential \
                       debhelper \
                       rtl-sdr \
                       libusb-1.0-0-dev \
                       librtlsdr-dev \
                       pkg-config \
                       dh-systemd \
                       libncurses5-dev \
                       libbladerf-dev \
                       lighttpd \
 && mkdir /tmp/build

RUN git clone https://github.com/bclswl0827/dump1090 /tmp/build/dump1090 \
 && cd /tmp/build/dump1090 \
 && dpkg-buildpackage -b \
 && rm -rf /tmp/build/dump1090-fa-dbgsym*

RUN dpkg --install /tmp/build/*.deb \
 && rm -rf /tmp/build \
 && apt-get remove --purge -y build-essential git pkg-config debhelper \
 && apt-get autoremove -y --purge

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]
