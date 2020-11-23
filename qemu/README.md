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

## [Original tutorial](https://hub.mender.io/t/qemu-the-fast-processor-emulator/420)

## [Yocto guide](https://wiki.yoctoproject.org/wiki/Steps_for_Automated_Testing_on_QEMU)
