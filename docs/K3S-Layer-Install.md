# Extend the previously built core setup to support K3S.

### Add meta-virtualization layer

```bash
export BRANCH="zeus" && \
     cd ${HOME}/playground/mender-raspberrypi/sources && \
     git clone git://git.yoctoproject.org/meta-virtualization -b ${BRANCH}
```
