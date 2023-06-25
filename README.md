# Clash in Container

Run clash in container.

## Usage

1. Copy `config.yaml` to project root directory.
2. Run `docker compose up`.
3. Visit `http://ip:19091` to view config.

## Ports

- 7890: mixed port
- 7891: socks port
- 19090: The external controller port (RESTful API)
- 19091: The dashboard port

## Config

- Must set `mixed-port: 7890`
- Must set `allow-lan: true`
- Must set `bind-address: '*'`
- Must set `external-controller: '0.0.0.0:9090'`
- Recommended to set `secret: '<secret>'` in config.

## Images

- Build image for local arch: `docker compose build`
- Build and push images for multi arch: `make build tag=0.1.0`
