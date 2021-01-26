# Extract artifacts

Now we want to extract the artifacts we have built in the previous step from the remote host to our local machine.

## 1. Set environment variables on host machine

We have to set following environment variables on our local machine which were partially specified during the [machine setup](../docs/Setup-Build-Machine.md) and [artifact built](../docs/Build-Artifacts.md).

```bash
# Remote host where artifacts should be pulled from
export VM_IP=168.119.52.88

# Build dir on remote host
export BUILD_DIR=yocto-build

# Local directory where we want to load the artifacts into
export ARTIFACTS_DIR=${HOME}/yocto

# Set target machine and image you want to extract
export TARGET_MACHINE=intel-corei7-64 && \
     export TARGET_IMAGE=core-image-full-cmdline
```



### Copy build artifacts

```bash
# Via scp (slow)
mkdir -p ${ARTIFACTS_DIR} && \
     scp yocto@${VM_IP}:/home/yocto/${BUILD_DIR}/build/tmp/deploy/images/${TARGET_MACHINE}/${TARGET_IMAGE}-${TARGET_MACHINE}\{.uefiimg,.sdimg,.wic,.mender\} ${ARTIFACTS_DIR}

# Via rsync through ssh (fast)
mkdir -p ${ARTIFACTS_DIR} && \
     rsync --compress --copy-links -Pe ssh yocto@${VM_IP}:/home/yocto/${BUILD_DIR}/build/tmp/deploy/images/${TARGET_MACHINE}/${TARGET_IMAGE}-${TARGET_MACHINE}\{.uefiimg,.sdimg,.wic,.mender\} ${ARTIFACTS_DIR}
```