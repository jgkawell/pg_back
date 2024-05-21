FROM --platform=$BUILDPLATFORM golang:alpine AS installer
ARG TARGETOS
ARG TARGETARCH

RUN apk add --no-cache git

RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go install github.com/orgrim/pg_back@latest

RUN cp /go/bin/"$TARGETOS"_"$TARGETARCH"/pg_back /go/bin/pg_back

FROM alpine

COPY --from=installer /go/bin/pg_back /usr/bin/pg_back

RUN apk add --no-cache age postgresql
