#!/usr/bin/env bash
# install_xschem.sh
# Builds and installs xschem (schematic capture / netlisting tool) on Fedora.
# Usage: chmod +x install_xschem.sh && ./install_xschem.sh

set -e  # stop on first error

mkdir ~/eda-tools

echo "==> Installing build dependencies..."
sudo dnf install -y gcc git make automake flex bison \
    libX11-devel libXrender-devel libxcb-devel \
    cairo-devel tcl-devel tk-devel libXpm-devel libjpeg-turbo-devel

echo "==> Installing Tcl/Tk 8.6 compat headers (avoids Tcl 9 header/lib mismatch)..."
sudo dnf install -y tcl8-devel tk8-devel

echo "==> Cloning xschem..."
git clone https://github.com/StefanSchippers/xschem.git
cd xschem

echo "==> Configuring and building..."
./configure
make

echo "==> Installing..."
sudo make install

echo "==> Done. Try running: xschem"
