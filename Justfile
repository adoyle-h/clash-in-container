set dotenv-load

_help:
  @just --list

PLATFORM := "linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6"

# docker buildx build and push images
build VERSION="1.18.3":
  #!/usr/bin/env bash

  tags=( latest {{VERSION}} )

  docker buildx build --push -f ./meta.Dockerfile \
    --build-arg CLASH_VERSION={{VERSION}} \
    --build-arg GITHUB_PROXY=${GITHUB_PROXY} \
    $(printf -- '--tag adoyle/clash-meta:%s ' ${tags[@]}) \
    --platform "{{PLATFORM}}" \
    .
