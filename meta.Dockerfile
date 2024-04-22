FROM alpine:3.19.1

WORKDIR /root

ARG CLASH_VERSION=v1.18.3
ARG TARGETPLATFORM

ENV TZ=Asia/Shanghai

RUN <<EOF
  sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
  apk update
  apk add --no-cache bash curl gzip
  rm -rf /var/cache/apk/*
EOF

RUN <<EOF
  echo "TARGETPLATFORM=$TARGETPLATFORM"
  case "$TARGETPLATFORM" in
    linux/amd64)
      meta_type=amd64
      tini_type=amd64
    ;;
    linux/arm64)
      meta_type=arm64
      tini_type=arm64
    ;;
    linux/arm/v*)
      meta_type=armv7
      tini_type=armhf
    ;;
    *)
      meta_type=unknown-arch
      tini_type=unknown-arch
    ;;
  esac

  curl -Lfo /tini "https://mirror.ghproxy.com/https://github.com/krallin/tini/releases/latest/download/tini-static-$tini_type"
  chmod +x /tini

  curl -Lfo ./clash.gz "https://mirror.ghproxy.com/https://github.com/MetaCubeX/mihomo/releases/latest/download/mihomo-linux-$meta_type-$CLASH_VERSION.gz"
  gunzip ./clash.gz
  rm -f ./clash.gz
  chmod +x ./clash
EOF

LABEL maintainer="ADoyle <adoyle.h@gmail.com>"
LABEL description="The clash meta"

ENTRYPOINT ["/tini", "--"]
CMD ["/root/clash"]
