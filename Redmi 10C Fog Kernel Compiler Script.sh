#!/bin/bash
# Copyright cc 2025 RahmatSobrian

# Setup color
red='\033[0;31m'
green='\033[0;32m'
white='\033[0m'
yellow='\033[0;33m'
cyan='\033[0;36m'

WORK_DIR=$(pwd)
export KBUILD_OUTPUT=$WORK_DIR/out
DEFCONFIG="vendor/fog-perf_defconfig"
KERN_IMG="${WORK_DIR}/out/arch/arm64/boot/Image-gz.dtb"
KERN_IMG2="${WORK_DIR}/out/arch/arm64/boot/Image.gz"

export CROSS_COMPILE=aarch64-linux-gnu-
export CROSS_COMPILE_ARM32=arm-linux-gnueabi-
export CROSS_COMPILE_COMPAT=arm-linux-gnueabi-

function welcome() {
    echo -e "\n"
    echo -e "$cyan [ Kernel Compiler Script By Rahmat Sobrian v1.0 ] \n$white"
    echo -e "\n"
}

function clean() {
    echo -e "\n"
    echo -e "$red [ cleaning up... ] \n$white"
    echo -e "\n"
    rm -rf out
}

function build_kernel() {
    echo -e "\n"
    echo -e "$yellow [ building kernel... ] \n$white"
    echo -e "\n"

    make O=out ARCH=arm64 $DEFCONFIG
    make O=out ARCH=arm64 oldconfig

    make ARCH=arm64 O=out -j$(nproc --all) \
                          CROSS_COMPILE=$CROSS_COMPILE \
                          CROSS_COMPILE_ARM32=$CROSS_COMPILE_ARM32 \
                          CROSS_COMPILE_COMPAT=$CROSS_COMPILE_COMPAT

    if [ -e "$KERN_IMG" ] || [ -e "$KERN_IMG2" ]; then
        echo -e "\n"
        echo -e "$green [ compile kernel sukses! ] \n$white"
        echo -e "\n"
    else
        echo -e "\n"
        echo -e "$red [ compile kernel gagal! ] \n$white"
        echo -e "\n"
    fi
}

welcome
clean
build_kernel