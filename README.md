# docker-bind
Dockerized Authoritative-Only BIND DNS Server with catch-all (wildcard) for any domain.

```
tail -f queries.log | pv --line-mode --bytes --timer --rate --average-rate --interval 1 > /dev/null
```
