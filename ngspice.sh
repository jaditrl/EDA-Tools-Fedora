#!/usr/bin/env bash
# 2026-10-01
# Builds and installs ngspice (mixed-signal circuit simulator) on Fedora 44.
# Usage: chmod +x ngspice.sh && ./install_ngspice.sh

set -e  # stop on first error

# Creates a file called eda-tools where all the git repos will be downloaded to  
[ -d "$HOME/eda-tools" ] || mkdir "$HOME/eda-tools" 

cd $HOME/eda-tools

echo "==> Installing build dependencies..."
sudo dnf install gcc-c++ git make bison flex libXaw-devel \
    libX11-devel readline-devel libtool automake autoconf

echo "==> Cloning ngspice..."
[ -d "$HOME/eda-tools/ngspice" ] || git clone https://github.com/ngspice/ngspice.git
cd ngspice

echo "==> Configuring"
./configure

echo "==> Building..."
make CFLAGS="-std=gnu17"

echo "==> Installing..."
sudo make install

echo "==> Done. Try running: ngspice"
