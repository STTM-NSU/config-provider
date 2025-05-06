FROM golang:1.24.2-alpine3.21

COPY ./ ./

RUN apk add --no-cache make
RUN make install-tools

ENTRYPOINT exec make migrate-up