# Clash in Container

Run clash-meta in container.

## Usage

1. Copy `config.yaml` to project root directory. The config refer to https://wiki.metacubex.one/config/
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
- Build and push images for multi arch: `just build 1.19.3` or `GITHUB_PROXY=https://ghfast.top/ just build 1.19.3`
  - 1.19.3 is clash meta version.
  - Install [just](https://github.com/casey/just) before build.

## Suggestion, Bug Reporting, Contributing

**Before opening new Issue/Discussion/PR and posting any comments**, please read [Contributing Guidelines](https://gcg.adoyle.me/CONTRIBUTING).

## Copyright and License

Copyright 2023-2025 ADoyle (adoyle.h@gmail.com) All Rights Reserved.
The project is licensed under the **Apache License Version 2.0**.

See the [LICENSE][] file for the specific language governing permissions and limitations under the License.

See the [NOTICE][] file distributed with this work for additional information regarding copyright ownership.


<!-- links -->

[LICENSE]: ./LICENSE
[NOTICE]: ./NOTICE
