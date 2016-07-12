FROM debian:wheezy

MAINTAINER Shawn Sit <xueqingxiao@gmail.com>

RUN buildDeps=" \
    wget \
  "; \
  set -x \
  && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
  && VERSION=`wget -O- http://shadowsocks.org/debian/dists/wheezy/main/binary-amd64/Packages|grep Version` \
  && wget -O- http://shadowsocks.org/debian/1D27208A.gpg | apt-key add - \
  && echo "deb http://shadowsocks.org/debian wheezy main" > /etc/apt/sources.list.d/shadowsocks.list \
  && apt-get update \
  && apt-get install -y shadowsocks-libev --no-install-recommends && rm -rf /var/lib/apt/lists/* \
  && apt-get purge -y --auto-remove $buildDeps

ENTRYPOINT ["/usr/bin/ss-server"]

ADD shadowsocks.json /etc/