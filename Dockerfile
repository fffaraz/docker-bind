FROM ubuntu:latest

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update < /dev/null && \
	apt-get -yq upgrade < /dev/null && \
	apt-get -yq install bind9 bind9utils bind9-host tini < /dev/null && \
	mv /etc/bind/named.conf /etc/bind/named.conf.default && \
	mkdir -m 0775 -p /var/run/named && \
	chown root:bind /var/run/named && \
	mkdir -m 0775 -p /var/cache/bind && \
	chown root:bind /var/cache/bind && \
	apt-get -y autoremove && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /var/cache/apk/* /tmp/* /var/tmp/* && \
	exit 0

COPY named.conf /etc/bind/named.conf

COPY entrypoint.sh /
RUN chown root:root /entrypoint.sh && chmod 544 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
