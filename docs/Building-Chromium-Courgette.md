# Building Chromium Courgette (Binary diff tool) on Ubuntu 16.04

The following guide is derived from [this](https://chromium.googlesource.com/chromium/src/+/master/docs/linux/build_instructions.md) original guide from google.

### Install depot_tools and fetch chromium sources
```bash
# Install packages
sudo apt-get update && \
     sudo apt-get install -y git python

# Install depot_tools
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git ${HOME}/bin/depot_tools  && \
     export PATH=${HOME}/bin/depot_tools:$PATH



# Install build dependencies and run hooks
cd ${HOME}/chromium/src && \
     ./build/install-build-deps.sh && \
     gclient runhooks

# Setup build environment and build Courgette
cd ${HOME}/chromium/src && \
     gn gen out/Default && \
     autoninja -C out/Default courgette

GYP_CROSSCOMPILE=1 GYP_DEFINES="target_arch=arm arm_float_abi=hard component=shared_library linux_use_gold_flags=1" gclient runhooks && \
     ninja -C out/Default courgette

     GYP_CROSSCOMPILE=1 GYP_DEFINES="target_arch=arm arm_float_abi=hard component=shared_library linux_use_gold_flags=1" autoninja -C out/Default courgette
```

### Clone chromium repo (This takes veeeery long!)

```bash
# Clone chromium repo (grab a cup of coffee!)
mkdir ${HOME}/chromium && cd ${HOME}/chromium && \
     fetch --nohooks chromium
```

### Build for (x86)
```bash
# Install build dependencies and run hooks
cd ${HOME}/chromium/src && \
     ./build/install-build-deps.sh && \
     gclient runhooks

# Setup build environment and build Courgette
cd ${HOME}/chromium/src && \
     gn gen out/Default && \
     autoninja -C out/Default courgette
```

### Build for (arm)
```bash

# Install build dependencies and run hooks
cd ${HOME}/chromium/src && \
     ./build/install-build-deps.sh && \
     ./build/install-build-deps.sh --arm

# Set target cpu and os in `.gclient` file 
# Currently supported values can be found here: https://gn.googlesource.com/gn/+/HEAD/docs/reference.md#var_target_cpu
# target_os:  android|chromeos|ios|linux|nacl|mac|win
# target_cpu: x86|x64|arm|arm64|mipsel


# This example is suitable for Raspberry Pi 4 B (Debian armhf/arm32)
cd ${HOME}/chromium && \
cat <<EOF > .gclient
target_cpu = ["arm"]
target_os = ["chromeos"]
EOF

# Sync gclient and run hooks
gclient sync -D -R && \     
     GYP_CROSSCOMPILE=1 GYP_DEFINES="target_arch=arm arm_float_abi=hard component=shared_library linux_use_gold_flags=1" gclient runhooks

# Setup build environment and build Courgette
cd ${HOME}/chromium/src && \
     gn gen out/armhf --args='target_os="chromeos"' && \
     ninja -C out/armhf courgette
```

### Pack binaries
```bash
# The output binary and all shared-libraries are generated in the directory:
cd ${HOME}/chromium/src/out/armhf

# To bundle all important files as one tar file copy the `pack.sh` file from this repository into following directory on teh target host: `${HOME}/chromium/src/pack.sh`

# Then you can pack your binaries using the command
./pack.sh ./out/armhf
```