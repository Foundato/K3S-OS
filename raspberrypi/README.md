# Raspberry-PI OTA

### Build yocto

```bash
# Sync repository if not already done
cd ${HOME}/playground/raspberrypi && \
     repo sync

# Setup build environment
export BRANCH="zeus" && \
     cd ${HOME}/playground/raspberrypi && \
     source setup-environment raspberrypi

# Edit ./conf/local.conf
nano ./conf/local.conf

# Build
MACHINE=raspberrypi4 bitbake core-image-base
```

### Inspect files of the previously built image
```bash
# Detatch old device if already mounted
sudo umount /mnt/rpi-rootfs /mnt/rpi-boot && \
     sudo losetup -d /dev/loop0

# Attach new device
sudo losetup -P /dev/loop0 ${HOME}/playground/raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4.sdimg && \
    sudo mkdir -p /mnt/rpi-rootfs /mnt/rpi-boot && \
    sudo mount /dev/loop0p2 /mnt/rpi-rootfs && \
    sudo mount /dev/loop0p1 /mnt/rpi-boot
```

The build artifacts are now the following two files:

- SD-Card image: `${HOME}/playground/raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4.sdimg`
- Mender Artifact: `${HOME}/playground/raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4.mender`

### Copy build artifacts to host (execute from your host)

```bash
# Via scp (slow)
export VM_IP=168.119.52.88 && \
     mkdir -p ${HOME}/yocto && \
     scp yocto@${VM_IP}:/home/yocto/playground/raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4\{.sdimg,.mender\} ${HOME}/yocto

# Via rsync through ssh (fast)
export VM_IP=168.119.52.88 && \
     mkdir -p ${HOME}/yocto && \
     rsync --compress --copy-links -Pe ssh yocto@${VM_IP}:/home/yocto/playground/raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4\{.sdimg,.mender\} ${HOME}/yocto
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
