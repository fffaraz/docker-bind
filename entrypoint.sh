#!/bin/bash
set -euxo pipefail

mkdir -p /conf
mkdir -p /log

[ ! -f /conf/zones.conf ] && cat > /conf/zones.conf <<'EOL'
zone "." {
    type master;
    file "/conf/root.zone";
};

EOL

[ ! -f /conf/root.zone ] && cat > /conf/root.zone <<'EOL'
$TTL 3600
@ IN SOA ns1.example.net. dnsadmin.example.net. (
 2019010101 ; Serial
 604800     ; Refresh
 86400      ; Retry
 1206900    ; Expire
 3600 )     ; Negative Cache TTL
   IN NS   ns1.example.net.
   IN NS   ns2.example.net.
*. IN A    127.0.0.1
*. IN AAAA ::1

EOL

chown -R bind:bind /conf
chown -R bind:bind /log
exec /usr/sbin/named -4 -f -u bind
