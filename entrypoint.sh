#!/bin/bash
set -euo pipefail

mkdir -p /conf
mkdir -p /log

[ ! -f /conf/zones.conf ] && echo 'zone "." { type master; file "/conf/root.zone"; };' > /conf/zones.conf

[ ! -f /conf/root.zone ] && cat > /conf/root.zone <<'EOL'
$TTL 86400

@ IN SOA ns1.example.net. dnsadmin.example.net. (
 2025010203 ; Serial
 86400      ; Refresh
 86400      ; Retry
 86400      ; Expire
 3600 )     ; Negative Cache TTL

   IN NS   ns1.example.net.
   IN NS   ns2.example.net.

*. IN A    127.0.0.1
*. IN AAAA ::1

EOL

chown -R bind:bind /conf
chown -R bind:bind /log
exec /usr/sbin/named -f -u bind
