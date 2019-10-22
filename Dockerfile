FROM alpine:3.10 as certs

RUN apk --update add ca-certificates && \
    rm -rf /var/cache/apk/*

FROM scratch
ENV PATH=/bin:/go/bin

COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
# Copy our static executable.

ARG version=none
ENV VERSION=$version

COPY bin/draft-test /go/bin/draft-test

ENTRYPOINT ["/go/bin/draft-test"]