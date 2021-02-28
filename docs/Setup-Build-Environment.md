# Setup build environment

These steps are very much based on this [article]((https://hub.mender.io/t/raspberry-pi-4-model-b/889)) published by Mender.

## 1. Make tough decisions
Specify the build platform as well as the target release (branch) you want to build. 

#### Build platforms
* raspberrypi
* intel

#### Branches
* zeus
* dunfell

This is an example setup for a zeus release for the intel platform. 
```bash
export BRANCH="zeus" && \
     export BUILD_PLATFORM="intel" && \
     export STAGE="prod"
```

## 2. Clone repositories

```bash
cd ${HOME}/${BUILD_DIR} && \
     repo init -u https://github.com/Foundato/K3S-OS.git \
     -m ${BUILD_PLATFORM}/scripts/manifest-${BUILD_PLATFORM}.xml \
     -b ${BRANCH} && \
     repo sync
```

## 3. Initialize build environment

```bash
cd ${HOME}/${BUILD_DIR} && \
     source setup-environment ${BUILD_PLATFORM} ${STAGE}
```
