#!/bin/bash
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive
apt-get -yq update < /dev/null
apt-get -yq upgrade < /dev/null
apt-get -yq install bind9 bind9utils bind9-host < /dev/null

mkdir -m 0775 -p /var/run/named
chown root:bind /var/run/named

mkdir -m 0775 -p /var/cache/bind
chown root:bind /var/cache/bind

rm -rf /var/lib/apt/lists/*

cat > /etc/bind/named.conf <<'EOL'
include "/etc/bind/named.conf.options";
include "/etc/bind/named.conf.local";
include "/data/zone.conf";
EOL

cat > /etc/bind/named.conf.options <<'EOL'
options {
	directory "/var/cache/bind";
	dnssec-validation auto;
	auth-nxdomain no; # conform to RFC1035
	listen-on-v6 { any; };
	recursion no;
	allow-query { any; };
	allow-transfer { none; };
};
EOL

cat > /etc/bind/named.conf.local <<'EOL'
zone "." {
	type master;
	file "/data/root.zone";
};
EOL
