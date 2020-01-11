############################
# STEP 1 build executable binary
############################
FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git unzip curl
WORKDIR /root/cloud-torrent
ENV PATH=$HOME/go/bin:$PATH 
RUN set -x && \
    curl -sL -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip -p rclone-*.zip rclone-*/rclone > /usr/local/bin/rclone && \
    chmod +x /usr/local/bin/rclone && rm -rf rclone-*.zip && \
    git clone https://github.com/umardx/cloudx.git . && \
    go get -v -u github.com/shuLhan/go-bindata/... && \
    go get -v -t -d ./... && \
    cd static && \
    sh generate.sh

ENV GO111MODULE=on CGO_ENABLED=0
RUN go build -ldflags "-s -w -X main.VERSION=$(git describe --tags)" -o /usr/local/bin/cloudx
############################
# STEP 2 build a small image
############################
FROM alpine
COPY --from=builder /usr/local/bin/cloudx /usr/local/bin/rclone /usr/local/bin/
RUN apk update && apk add ca-certificates
ENTRYPOINT ["cloudx"]
