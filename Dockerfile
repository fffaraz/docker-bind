FROM ubuntu:latest
ENTRYPOINT ["/docker-entrypoint.sh"]

COPY docker-install.sh /
RUN chown root:root /docker-install.sh && chmod 544 /docker-install.sh && sync && /docker-install.sh

COPY docker-entrypoint.sh /
RUN chown root:root /docker-entrypoint.sh && chmod 544 /docker-entrypoint.sh
