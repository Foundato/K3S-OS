# QEMU OTA

### Build yocto

```bash
# Sync repository if not already done
cd ${HOME}/playground/raspberrypi && \
     repo sync

# Setup build environment
export BRANCH="zeus" && \
     cd ${HOME}/playground/raspberrypi && \
     source setup-environment qemu

# Build
MACHINE=qemux86-64 bitbake core-image-base
```

## [Further instructions](https://hub.mender.io/t/qemu-the-fast-processor-emulator/420)
