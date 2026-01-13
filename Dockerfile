FROM busybox:stable-musl AS builder
RUN mkdir -p /etc/xray
COPY config.jsonc /etc/xray/config.json
RUN chown -R 10014:10014 /etc/xray && chmod 755 /etc/xray

FROM ghcr.io/xtls/xray-core:latest
COPY --from=builder /bin/busybox /busybox
COPY --from=builder --chown=10014:10014 /etc/xray /etc/xray

USER 10014
ENTRYPOINT ["/busybox", "sh", "-c"]
CMD ["/busybox sed -i \"s/\\$PORT/$PORT/g; s/\\$UUID/$UUID/g; s|\\$PATH|$PATH|g\" /etc/xray/config.json && exec /usr/local/bin/xray -config /etc/xray/config.json"]
