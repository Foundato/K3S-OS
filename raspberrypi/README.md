# Raspberry-PI OTA

### Build yocto

```bash
# Sync repository if not already done
cd ${HOME}/playground/raspberrypi && \
     repo sync

# Setup build environment
export BRANCH="dunfell" && \
     cd ${HOME}/playground/raspberrypi && \
     source setup-environment raspberrypi

# Build
MACHINE=raspberrypi4 bitbake core-image-base
```

The build artifacts are now the following two files:

- SD-Card image: `${HOME}/playground/raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4.sdimg`
- Mender Artifact: `${HOME}/playground/raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4.mender`

### Test build on remote server via QEMU docker container

Install docker

```bash
curl -fsSL https://get.docker.com -o get-docker.sh && \
     sudo sh get-docker.sh && \
     rm get-docker.sh
```

Run previously build image in container

```bash
sudo docker run -it -v ${HOME}/playground/raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4.sdimg:/sdcard/filesystem.img lukechilds/dockerpi:vm pi3

# Bare qemu
sudo apt-get install qemu -y
# Get the kernel
mkdir -p ${HOME}/qemu && \
     curl https://raw.githubusercontent.com/dhruvvyas90/qemu-rpi-kernel/master/kernel-qemu-4.19.50-buster -o ${HOME}/qemu/kernel-qemu-4.19.50-buster && \
     curl https://raw.githubusercontent.com/dhruvvyas90/qemu-rpi-kernel/master/versatile-pb-buster-5.4.51.dtb -o ${HOME}/qemu/versatile-pb-buster-5.4.51.dtb

# Filesystem image
qemu-img convert -f raw -O qcow2 ${HOME}/playground/raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4.sdimg ${HOME}/qemu/under-test.qcow && \
     qemu-img resize ${HOME}/qemu/under-test.qcow +4G

qemu-img convert -f raw -O qcow2 ${HOME}/qemu/2020-08-20-raspios-buster-armhf-lite.img ${HOME}/qemu/under-test.qcow && \
     qemu-img resize ${HOME}/qemu/under-test.qcow +4G

# Let root own the directory and all its files
sudo chown -R $USER:$USER ${HOME}/qemu/

# Run in QEMU
qemu-system-arm \
  -M versatilepb \
  -cpu arm1176 \
  -m 256 \
  -hda ${HOME}/qemu/under-test.qcow \
  -dtb ${HOME}/qemu/versatile-pb-buster-5.4.51.dtb \
  -kernel ${HOME}/qemu/kernel-qemu-4.19.50-buster \
  -append 'root=/dev/sda2 panic=1' \
  -no-reboot


sudo qemu-system-arm \
-kernel ${HOME}/qemu/kernel-qemu-4.4.34-jessie \
-append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
-hda ${HOME}/qemu/under-test.qcow \
-cpu arm1176 -m 256 \
-M versatilepb \
-no-reboot \
-serial stdio \
-net nic -net user \
-net tap,ifname=vnet0,script=no,downscript=no


sudo mount -v -o offset=67108864 -t ext4 ${HOME}/playground/raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4.sdimg2 /mnt/raspbian
```

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
