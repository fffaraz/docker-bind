FROM debian:stable-slim

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install -yq --no-install-recommends bind9 bind9utils bind9-host tini && \
	mv /etc/bind/named.conf /etc/bind/named.conf.default && \
	mkdir -m 0775 -p /var/run/named && \
	chown root:bind /var/run/named && \
	mkdir -m 0775 -p /var/cache/bind && \
	chown root:bind /var/cache/bind && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 53/udp 53/tcp

COPY named.conf /etc/bind/named.conf
COPY --chmod=0544 entrypoint.sh /

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/entrypoint.sh"]
