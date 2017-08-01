# docker-bind
Dockerized Authoritative-Only BIND DNS Server with catch-all (wildcard) for any domain.

```
tail -f queries.log | pv --line-mode -b --timer --rate > /dev/null
```
