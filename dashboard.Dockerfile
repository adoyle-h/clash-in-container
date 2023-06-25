FROM node:18-alpine3.17

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

LABEL maintainer="ADoyle <adoyle.h@gmail.com>"
ENV TZ=Asia/Shanghai
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["npm exec --prefix /root/clash-dashboard vite -- preview --port 8080 --host 0.0.0.0 /root/clash-dashboard"]
