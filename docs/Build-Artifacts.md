# Build artifacts

## 1. Specify the machine and target to build for

#### Target machines
* Platform: Intel
  * intel-corei7-64
* Platform: Raspberry Pi
  * raspberrypi4
  
#### Target images
* Platform: Intel
  * core-image-full-cmdline
* Platform: Raspberry Pi
  * core-image-base

```bash
export TARGET_MACHINE=intel-corei7-64 && \
     export TARGET_IMAGE=core-image-full-cmdline
```

## 1. Build yocto

```bash
cd ${HOME}/${BUILD_DIR}/build && \
     MACHINE=${TARGET_MACHINE} bitbake ${TARGET_IMAGE}
```

## 2. Detach shell session of screen (optional)
As already mentioned throughout the [machine setup](../docs/Setup-Build-Machine.md) the actual build may take some time!
Therefore you could go ahead and detach/attach yor shell session using screen to run in background when you close your ssh session:

```bash
# 1. Detach your shell session with running yocto build
Press keys: CTRL+A CTRL+D

# 2. Close ssh session

# 4. Login ssh session and type:
screen -r
```

## 3. Inspect build artifacts

The build artifacts are now the following files:

- WIC image (useful for root-fs inspection): `${HOME}/${BUILD_DIR}/build/tmp/deploy/images/intel-corei7-64/core-image-full-cmdline-intel-corei7-64.wic`
- UEFI image (used to boot from [USB-Stick]()): `${HOME}/${BUILD_DIR}/build/tmp/deploy/images/intel-corei7-64/core-image-full-cmdline-intel-corei7-64.uefiimg`
- SD image (used for flashing Raspberry Pi SD-Card) `${HOME}/${BUILD_DIR}/build/tmp/deploy/images/intel-corei7-64/core-image-full-cmdline-intel-corei7-64.sdimg`
- Mender artifact (for OTA-Updates): `${HOME}/${BUILD_DIR}/build/tmp/deploy/images/intel-corei7-64/core-image-base-intel-corei7-64.mender`

## 4. Inspect image root fs (optional)

In order to check if all files got copied into the right directories you can inspect the .wic artifact:
```bash
wic ls ./tmp/deploy/images/intel-corei7-64/core-image-full-cmdline-intel-corei7-64.wic:2/etc
```