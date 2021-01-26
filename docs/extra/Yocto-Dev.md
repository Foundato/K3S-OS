# Important links for developing Yocto distributions

### Understanding Bitbake's basic syntax

- [Basic Syntax](https://www.yoctoproject.org/docs/1.6/bitbake-user-manual/bitbake-user-manual.html#basic-syntax)

### Feature configuration

- [Chapter 11. Features](https://www.yoctoproject.org/docs/1.8/ref-manual/ref-manual.html#ref-features)

### Searching for layers/recipes

- [OpenEmbedded Layer Index](https://layers.openembedded.org/layerindex/branch/master/layers)

### Lessons learned

- `IMAGE_INSTALL += "<package>"` is not equal to `IMAGE_INSTALL_append = " <package>"` !!! (Second approach should be prefered if ordering of installs does matter)

### [A beginners guide to OpenEmbedded](https://www.wolfssl.com/docs/yocto-openembedded-recipe-guide)

### [Cookbook:Example:Adding packages to your OS image](https://wiki.yoctoproject.org/wiki/Cookbook:Example:Adding_packages_to_your_OS_image)
