# OTA

### Setup yocto environment (only if mount volume is empty!!!) ([Raspberry PI Model 4 B](https://hub.mender.io/t/raspberry-pi-4-model-b/889))

```bash
# Use latest supported Yocto-Branch
export BRANCH="zeus" && \
     export BUILD_PLATFORM="intel"
     mkdir ${BUILD_PLATFORM} && \
     cd ${HOME}/playground/${BUILD_PLATFORM}

# Initialize repository
repo init -u https://github.com/Foundato/raspberry-pi-ota-yocto.git \
     -m ${BUILD_PLATFORM}/scripts/manifest-${BUILD_PLATFORM}.xml \
     -b ${BRANCH} && \
     repo sync
```
