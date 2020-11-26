# Raspberry-PI OTA

Current version using the Yocto-[Zeus](https://github.com/Foundato/raspberry-pi-ota-yocto/tree/zeus) release can be found under the 'zeus' branch.

## Must reads

- [Developing images basics](docs/Yocto-Dev.md)
- [Developing on remote servers (Cheatsheet)](docs/Remote-dev-cheatsheet.md)

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
export EXT_VOLUME=HC_Volume_8028620

sudo ln -sf /mnt/${EXT_VOLUME}/ ${HOME}/playground && \
     cd ${HOME}/playground

# Only if the directory does not already belong to yocto user
sudo chown -R yocto /mnt/${EXT_VOLUME}
```

### Setup screen for detached shell session

Due to the fact that yocto needs quite a long time to build (even on a 16-core VM [~ 1h]) it is recommended to use tools like screen to detatch the shell session from the ssh connection. Therefore it is possible to detach and reatach the shell session running the yocto build. To do this you have to follow this 4 simple steps:

```bash
# 1. Install screen
sudo apt-get install screen

# 2. Start screen session (You might be promptet with some license information... just press space to continue)
screen

# 2.1 Start your yocto build

# 3. Detach shell session with running yocto build
Press keys: CTRL+A CTRL+D

# 3.1 Close ssh session

# 4. Login ssh session and type:
screen -r
```
