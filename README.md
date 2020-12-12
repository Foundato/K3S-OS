# QEMU OTA

### Setup yocto environment (only if mount volume is empty!!!) ([Raspberry PI Model 4 B](https://hub.mender.io/t/raspberry-pi-4-model-b/889))

```bash
# Use latest supported Yocto-Branch
export BRANCH="zeus" && \
     mkdir intel && \
     cd ${HOME}/playground/intel

# Initialize repository
repo init -u https://github.com/Foundato/raspberry-pi-ota-yocto.git \
     -m raspberrypi/scripts/manifest-intel.xml \
     -b ${BRANCH} && \
     repo sync
```
