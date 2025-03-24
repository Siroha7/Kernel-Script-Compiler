#!/bin/bash
# Copyright cc 2025 RahmatSobrian
clear
function welcome() {
    echo -e "\n"
    echo -e " [ Kernel Compiler Script By Rahmat Sobrian v1.0 ] \n"
    echo -e "\n"
}
function clean() {
    echo -e "\n"
    echo -e " [ cleaning up... ] \n"
    echo -e "\n"
    rm -rf out
}
function build_kernel() {
    echo -e "\n"
    echo -e " [ building kernel... ] \n"
    echo -e "\n"
    
    make -j$(nproc) O=out ARCH=arm64 rolex_defconfig
    make -j$(nproc) ARCH=arm64 O=out \
                          CROSS_COMPILE=aarch64-linux-gnu- \
                          CROSS_COMPILE_ARM32=arm-linux-gnueabi- 
}
welcome
clean
build_kernel