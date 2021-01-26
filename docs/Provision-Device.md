# Provision device

### Flash boot USB-Drive (Mac-OS)
```bash
# Identify the USB-Drive
diskutil list
export FLASH_DEV=/dev/disk2

# Unmount device (if not already done)
diskutil unmount ${FLASH_DEV}
# Unmount disk (if dev is already bootable iso)
diskutil unmountDisk ${FLASH_DEV}

# Flash image to USB-Drive
sudo dd if=${ARTIFACTS_DIR}/${TARGET_IMAGE}-${TARGET_MACHINE}.uefiimg of=${FLASH_DEV} bs=1m
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
sudo dd if=${ARTIFACTS_DIR}/${TARGET_IMAGE}-${TARGET_MACHINE}.sdimg of=${FLASH_DEV} bs=1048576
```