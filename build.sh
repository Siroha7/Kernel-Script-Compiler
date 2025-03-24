#!/bin/bash

# Konfigurasi
KERNEL_DIR=$(pwd)  # Direktori kernel (sesuai lokasi skrip)
OUT_DIR=$KERNEL_DIR/out
TOOLCHAIN_DIR=$KERNEL_DIR/toolchain
CROSS_COMPILE=$TOOLCHAIN_DIR/bin/aarch64-linux-android-

# Export variabel toolchain
export PATH=$TOOLCHAIN_DIR/bin:$PATH
export CROSS_COMPILE=$CROSS_COMPILE
export ARCH=arm64
export SUBARCH=arm64

# Bersihkan build lama
make clean && make mrproper

# Konfigurasi kernel
make O=$OUT_DIR rolex_defconfig

# Kompilasi kernel
make -j$(nproc) O=$OUT_DIR \
    CROSS_COMPILE=${CROSS_COMPILE} \
    CC=clang \
    CLANG_TRIPLE=aarch64-linux-android-

# Cek hasil build
if [ -f "$OUT_DIR/arch/arm/boot/zImage-dtb" ]; then
    echo "Kernel berhasil dikompilasi!"
    cp "$OUT_DIR/arch/arm/boot/zImage-dtb" "$KERNEL_DIR"
else
    echo "Kompilasi gagal!"
fi