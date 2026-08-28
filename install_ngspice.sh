#!/usr/bin/env bash
# install_ngspice.sh
# Builds and installs ngspice (mixed-signal circuit simulator) on Fedora.
# Usage: chmod +x install_ngspice.sh && ./install_ngspice.sh

set -e  # stop on first error

echo "==> Installing build dependencies..."
sudo dnf install -y gcc make git bison flex \
    libX11-devel readline-devel libtool automake autoconf

echo "==> Cloning ngspice..."
git clone https://github.com/ngspice/ngspice.git
cd ngspice

echo "==> Preparing build directory..."
./autogen.sh
mkdir -p release
cd release

echo "==> Configuring (with X11, XSpice, CIDER, readline, OpenMP)..."
../configure --with-x --enable-xspice --disable-debug --enable-cider \
    --with-readline=yes --enable-openmp

echo "==> Building..."
make

echo "==> Installing..."
sudo make install

echo "==> Done. Try running: ngspice"
