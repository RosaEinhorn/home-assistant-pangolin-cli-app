# Changelog

All notable changes to the Pangolin CLI Home Assistant App (formerly Add-on) will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-03-08

### Added
- Initial stable release
- Support for Pangolin CLI 0.5.1
- Automatic connection and reconnection to Pangolin networks
- Support for amd64, armv7, armhf, and aarch64 architectures
- TUN device support for WireGuard tunneling
- Configuration via Home Assistant UI
- Comprehensive documentation and troubleshooting guide

### Features
- Connects Home Assistant to private Pangolin resources
- Automatic restart on connection loss
- Secure credential management
- Network interface creation with proper privileges
- Auto-reconnect with 5-second delay on connection failure

[1.0.0]: https://github.com/RosaEinhorn/home-assistant-pangolin-cli-app/releases/tag/v1.0.0
