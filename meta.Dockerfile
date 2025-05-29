FROM alpine:3.21.3

WORKDIR /root

ARG TARGETPLATFORM
ARG CLASH_VERSION=1.18.3
ARG ALPINE_PROXY=mirrors.tuna.tsinghua.edu.cn
ARG GITHUB_PROXY=''

ENV TZ=Asia/Shanghai

RUN <<EOF
  sed -i "s/dl-cdn.alpinelinux.org/$ALPINE_PROXY/g" /etc/apk/repositories
  apk update
  apk add --no-cache bash curl gzip
  rm -rf /var/cache/apk/*
EOF

RUN <<EOF
  echo "TARGETPLATFORM=$TARGETPLATFORM"
  case "$TARGETPLATFORM" in
    linux/amd64)
      meta_type=amd64
    ;;
    linux/arm64)
      meta_type=arm64
    ;;
    linux/arm/v*)
      meta_type=armv7
    ;;
    *)
      meta_type=unknown-arch
    ;;
  esac

  curl -Lfo ./clash.gz "${GITHUB_PROXY}https://github.com/MetaCubeX/mihomo/releases/download/v${CLASH_VERSION}/mihomo-linux-$meta_type-v$CLASH_VERSION.gz"
  gunzip ./clash.gz
  rm -f ./clash.gz
  chmod +x ./clash
EOF

LABEL maintainer="ADoyle <adoyle.h@gmail.com>"
LABEL description="The clash meta"
LABEL clash_meta_version=$CLASH_VERSION

CMD ["/root/clash"]
