# Verify build using QEMU

### Install dependencies

```bash
sudo apt-get install qemu-system -y
```

### Download raspberry kernel for emulation

```bash
mkdir ${HOME}/playground/qemu && \
     cd ${HOME}/playground/qemu && \
     curl -L wget https://github.com/dhruvvyas90/qemu-rpi-kernel/blob/master/kernel-qemu-4.4.34-jessie > kernel-qemu
```

### Inspect built image

Following output shows the two equally sized root partitions (sdimg2/sdimg3) and the additionally created data partition (sdimg4)

![fdisk-output](img/fdisk-output.png)

If we now want to boot the first root partition (sdimg2), we have to calculate its offset for the following mount. This is done by multiplying the Start-Sector by 512.

`In this example: 131072 * 512 = 67108864`

### Mount one partition

export PART_OFFSET=67108864 && \
 export PART_FILE=${HOME}/playground/mender-raspberrypi/build/tmp/deploy/images/raspberrypi4/core-image-base-raspberrypi4.sdimg2 && \
     sudo mkdir /mnt/raspbian && \
     sudo mount -v -o offset=${PART_OFFSET} -t ext4 \${PART_FILE} /mnt/raspbian
