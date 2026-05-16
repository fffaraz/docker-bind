FROM debian:stable-slim

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update < /dev/null && \
	apt-get -yq install bind9 bind9utils bind9-host tini < /dev/null && \
	mv /etc/bind/named.conf /etc/bind/named.conf.default && \
	mkdir -m 0775 -p /var/run/named && \
	chown root:bind /var/run/named && \
	mkdir -m 0775 -p /var/cache/bind && \
	chown root:bind /var/cache/bind && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	exit 0

ENTRYPOINT ["/tini", "--"]

COPY named.conf /etc/bind/named.conf

COPY entrypoint.sh /
RUN chown root:root /entrypoint.sh && chmod 544 /entrypoint.sh

CMD ["/entrypoint.sh"]
