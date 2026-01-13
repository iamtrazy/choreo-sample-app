FROM ghcr.io/xtls/xray-core:latest
USER 10014
ENTRYPOINT [ "/usr/local/bin/xray" ]
CMD [ "-config", "/usr/local/etc/xray/config.jsonc" ]
