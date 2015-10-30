#!/usr/bin/env bash

if [ `uname -s` == 'Darwin' ]; then
    CROSSTOOL_BUILD_PLATFORM=osx-`uname -m`
elif [ `uname -s` == 'Linux' ]; then
    CROSSTOOL_BUILD_PLATFORM=linux-`uname -m`
else
    echo "Error: '`uname -s`' is not a supported platform"
    exit 1
fi

if [ ! -d configs/${CROSSTOOL_BUILD_PLATFORM} ]; then
    echo "Error: There are no scripts available for '${CROSSTOOL_BUILD_PLATFORM}'. The build platforms are:"
    for i in configs/* ; do echo \* $(basename $i) ; done
    exit 1
fi

if [ -z "$1" -o ! -d "configs/${CROSSTOOL_BUILD_PLATFORM}/$1" ]; then
    echo "Error: You must specify a host platform. The host platforms for '${CROSSTOOL_BUILD_PLATFORM}' are"
    for i in configs/${CROSSTOOL_BUILD_PLATFORM}/* ; do echo \* $(basename $i) ; done
    exit 1
fi

export CROSSTOOL_ROOT_FOLDER=`pwd`
export CROSSTOOL_TOOLCHAIN_NAME=${CROSSTOOL_BUILD_PLATFORM}/$1

ulimit -n 1024

(cd configs/${CROSSTOOL_TOOLCHAIN_NAME} && ct-ng build)
