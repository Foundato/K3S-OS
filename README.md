# Raspberry-PI OTA

### Setup yocto environment (only if mount volume is empty!!!) ([Raspberry PI Model 4 B](https://hub.mender.io/t/raspberry-pi-4-model-b/889))

```bash
# Use latest supported Yocto-Branch
export BRANCH="zeus" && \
     sudo mkdir mender-raspberrypi && \
     cd ${HOME}/playground/mender-raspberrypi

# Initialize repository
repo init -u git@github.com:Foundato/raspberry-pi-ota-yocto.git \
     -m raspberrypi/scripts/manifest-raspberrypi.xml \
     -b ${BRANCH} && \
     repo sync
```

### Build yocto

```bash
# Setup build environment
export BRANCH="zeus" && \
     cd ${HOME}/playground/mender-raspberrypi && \
     source setup-environment raspberrypi

# Build
MACHINE=raspberrypi4 bitbake core-image-base
```

The build artifacts are now the following two files:

- SD-Card image: `${HOME}/playground/mender-raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4.sdimg`
- Mender Artifact: `${HOME}/playground/mender-raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4.mender`

### Copy build artifacts to host (execute from your host)

```bash
export VM_IP=168.119.52.88 && \
     mkdir ${HOME}/yocto && \
     scp yocto@${VM_IP}:/home/yocto/playground/mender-raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4\{.sdimg,.mender\} ${HOME}/yocto
```

### Flash SD-Card (Mac-OS)

```bash
# Identify the sd card
diskutil list
export FLASH_DEV=/dev/disk2

# Unmount device (if not already done)
diskutil unmount ${FLASH_DEV}
# Unmount disk (if dev is already bootable iso)
diskutil unmountDisk ${FLASH_DEV}

# Flash image to SD-Card
sudo dd if=${HOME}/yocto/core-image-base-raspberrypi4.sdimg of=${FLASH_DEV} bs=1048576
```
