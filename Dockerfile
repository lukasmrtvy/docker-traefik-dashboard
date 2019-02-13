FROM alpine:3.9

COPY static/ /opt/check/
COPY scripts/exec.sh /opt/check/scripts/
COPY scripts/entrypoint /
COPY conf/supervisor.conf /

RUN apk update && apk add --no-cache jq curl darkhttpd bash supervisor

RUN mkdir -p /opt/check  && \
    chmod +x /opt/check/scripts/exec.sh /entrypoint && \
    chown nobody: -R /opt/check

WORKDIR  /opt/check

EXPOSE 9001

ENTRYPOINT ["/entrypoint"]

CMD ["supervisord","-c","/supervisor.conf"]
