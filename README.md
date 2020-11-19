# Raspberry-PI OTA

## Setup (Ubuntu 18.04)

### Initialize machine

```bash
# Secure root user (if not already done)
passwd

# Create a separate user (bitbake does not support root user to build)
adduser yocto && \
     usermod -aG sudo yocto && \
     su - yocto


# Install YOCO essential dependencies (file added manually)
sudo apt-get update && sudo apt-get install -y \
     gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
     pylint3 xterm file

# Install Google Repo
sudo apt-get install -y python && \
     git config --global user.email "user@foundato.com" && \
     git config --global user.name "Foundato User" && \
     git config --global color.ui false && \
     mkdir ${HOME}/bin && \
     curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ${HOME}/bin/repo && \
     chmod a+x ${HOME}/bin/repo && \
     PATH=${PATH}:~/bin
```

### Mount build volume

```bash
# Link and move to persisten volume if working in virtual machine
export EXT_VOLUME=HC_Volume_8028620 && \
     sudo ln -sf /mnt/${EXT_VOLUME}/ ${HOME}/playground && \
     cd ${HOME}/playground && \
     sudo chown -R yocto /mnt/${EXT_VOLUME}
```

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
