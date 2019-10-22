FROM alpine:3.10 as certs
RUN apk --update add ca-certificates

FROM scratch
ENV PATH=/bin:/go/bin

COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
# Copy our static executable.

COPY bin/hello-world /go/bin/hello-world
ENTRYPOINT ["/go/bin/hello-world"]