.PHONY: build
build:
	docker buildx build --push --tag adoyle/clash-dashboard:${tag} -f ./dashboard.Dockerfile \
		--platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6 \
		.
