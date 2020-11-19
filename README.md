# Raspberry-PI OTA

Current version using the Yocto-[Zeus](https://github.com/Foundato/raspberry-pi-ota-yocto/tree/zeus) release can be found under the 'zeus' branch.

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
