# v8_monolith

v8_monolith provides pre-built docker images for [v8 js engine][1]. The images are uploaded to [Docker Hub][2]. Dockerfile can be found on [GitHub repo][3]

v8 libraries are built as an all-in-one static library with `g++` without any dependency `libstdc++` shipped with `g++`.

## Installation Location
V8 library is installed at `/usr/local/lib/libv8_monolith.a`, headers are installed in `/usr/local/include/v8`.
You may use this image directly, or copy these files to your own image.

## Compatibility
The static library is compiled by `g++ 7.4.0` on ubuntu 18.04.
It's recommeded to use the same `g++` to build your application, as
using another version of `g++` for your application may result in link error.

## Version Policy
This image use the same version policy as v8's source repo. Read [official doc](https://v8.dev/docs/version-numbers) for more detail.

For example, tag `8.9.225.24` coorespond to chrome stable version `89.0.4389.114` on Linux, which is released at 03/30/21

### Build for another version

Simply checking out another version of v8 submodule, and rerun the build script:
```
git submodule update --init --recursive
cd v8
git checkout $ANOTHER_VERSION
cd ..
./build.sh
```
If finished successfully, a new docker image named `zelinf/v8_monolith:$ANOTHER_VERSION` should be present in your system.

[1]: https://github.com/v8/v8
[2]: https://hub.docker.com/repository/docker/zelinf/v8_monolith
[3]: https://github.com/IsumiF/v8_monolith