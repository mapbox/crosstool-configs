#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "You must specify a toolchain name"
    exit 1
fi

export CROSSTOOL_ROOT_FOLDER=`pwd`
export CROSSTOOL_TOOLCHAIN_NAME=$1

ulimit -n 1024

(cd configs/${CROSSTOOL_TOOLCHAIN_NAME} && ct-ng build)
