# v8_monolith

v8_monolith provides pre-built static libraries for [v8 js engine][1], which can be downloaded from the [release page](https://github.com/IsumiF/v8_monolith/releases)

## Version Policy
Releases use the same version policy as v8's source repo. Read [official doc](https://v8.dev/docs/version-numbers) for more detail.

For example, tag `8.9.225.24` coorespond to chrome stable version `89.0.4389.114` on Linux, which is released at 03/30/21

### Build for another version

Having cloned this repository, run the following commands:
```
git tag $YOUR_VERSION # specify a valid v8 version number
./build.sh
```
If `build.sh` runs successfully, tarballs will be placed in `output` directory

[1]: https://github.com/v8/v8