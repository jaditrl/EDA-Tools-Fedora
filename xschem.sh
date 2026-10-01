#!/usr/bin/env bash
# install_xschem.sh
# Builds and installs xschem (schematic capture / netlisting tool) on Fedora 44.
# Usage: chmod +x install_xschem.sh && ./install_xschem.sh

set -e  # stop on first error
[ -d "$HOME/eda-tools" ] || mkdir "$HOME/eda-tools"

cd $HOME/eda-tools

echo "==> Installing build dependencies..."
sudo dnf install gcc-c++ git make automake flex bison \
    libX11-devel libXrender-devel libxcb-devel \
    cairo-devel tcl8-devel tk8-devel libXpm-devel libjpeg-turbo-devel

echo "==> Cloning xschem..."
[ -d "$HOME/eda-tools/xschem" ] || git clone https://github.com/StefanSchippers/xschem.git
cd xschem

echo "==> Configuring and building..."
./configure
make

echo "==> Installing..."
sudo make install

echo "==> Done. Try running: xschem"
