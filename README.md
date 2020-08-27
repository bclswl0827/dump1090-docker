# Dump1090-Docker

Dump1090-fa in Docker.

# Quick Start

 1. Install docker-ce, example given on Fedora Linux.

```
[tony@localhost ~]$ sudo dnf install curl
[tony@localhost ~]$ curl -fsSL get.docker.com -o get-docker.sh
[tony@localhost ~]$ sudo sh get-docker.sh
[tony@localhost ~]$ sudo groupadd docker
[tony@localhost ~]$ sudo usermod -aG docker $USER
[tony@localhost ~]$ sudo systemctl enable docker && sudo systemctl start docker
```

 2. Run Dump1090-Docker.

```
[tony@localhost]$ docker run -d -i -t \
  --name dump1090 \
  --restart always \
  -p 8080:80 \
  -e LAT="your-latitude" \
  -e LON="your-longitude" \
  --device /dev/bus/usb \
  bclswl0827/dump1090-docker:latest
```

**You should get your latitude and longitude firstly, replace the environment variables when deploying.**

 3. Open browser and access the following address.

```
http://[Your IP]:8080
```
