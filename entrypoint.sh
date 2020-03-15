#!/bin/bash
set -euxo pipefail

mkdir -p /conf
mkdir -p /log

[ ! -f /conf/zone.conf ] && touch /conf/zone.conf

[ ! -f /conf/root.zone ] && cat > /conf/root.zone <<'EOL'
$TTL 600
@ IN SOA . dnsadmin.example.net. (
 2017010101 ; Serial
 604800     ; Refresh
 86400      ; Retry
 1206900    ; Expire
 600 )      ; Negative Cache TTL
   IN NS   ns1.example.net.
*. IN A    127.0.0.1
*. IN AAAA ::1

EOL

chown -R bind:bind /conf
chown -R bind:bind /log
exec /usr/sbin/named -4 -f -u bind
