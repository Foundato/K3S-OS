# K3S-OS

Operating system with full functional [K3S](https://k3s.io) for IoT use cases using the [Yocto Project](https://www.yoctoproject.org).
## Supported yocto releases
* [Zeus (3.0)](https://github.com/Foundato/raspberry-pi-ota-yocto/tree/zeus)
* [Dunfell (3.1)](https://github.com/Foundato/raspberry-pi-ota-yocto/tree/dunfell)

## Supported target platforms

* Raspberry Pi 4
* Generic intel (corei7-64)

## Getting started

To produce all artifacts that are needed to provision the specific device you have to go through following steps:

1. [Setup build machine](docs/Setup-Build-Machine.md)
2. [Setup build environment](docs/Setup-Build-Environment.md)
3. [Build artifacts](docs/Build-Artifacts.md)
4. [Extract artifacts](docs/Extract-Artifacts.md)
5. [Provision device](docs/Provision-Device.md)

## Additional docs

- [Developing images basics](docs/extra/Yocto-Dev.md)
- [Developing on remote servers (Cheatsheet)](docs/extra/Remote-Dev-Cheatsheet.md)
