FROM node:18-alpine3.17 as builder

WORKDIR /root

RUN <<EOF
  sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
  apk update
EOF

RUN apk add --no-cache \
  bash git

RUN <<EOF
  git clone --depth 1 --single-branch --progress https://ghproxy.com/https://github.com/Dreamacro/clash-dashboard.git
EOF

RUN <<EOF
  set -o errexit -o nounset -o pipefail
  cd clash-dashboard
  npm config set registry https://registry.npm.taobao.org/
  npm install --force
  npm run build
EOF

FROM joseluisq/static-web-server:2-alpine

COPY --from=builder /root/clash-dashboard/dist /root/public

WORKDIR /root
LABEL maintainer="ADoyle <adoyle.h@gmail.com>"
LABEL description="The dashboard for clash"
ENV TZ=Asia/Shanghai
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["static-web-server --port 8080 --root /root/public"]
