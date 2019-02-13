FROM alpine:3.9

COPY static/index.html /opt/check/
COPY scripts/exec.sh /opt/check/
COPY scripts/entrypoint.sh /
COPY conf/supervisord.conf /

RUN apk update && apk add --no-cache jq curl darkhttpd  supervisor

RUN mkdir -p /opt/check  && \
    chmod +x /opt/check/exec.sh /entrypoint.sh && \
    chown ${user}: -R /opt/check

WORKDIR  /opt/check

EXPOSE 9001

ENTRYPOINT ["/entrypoint.sh"]

CMD ["supervisord","-c","/supervisord.conf"]
