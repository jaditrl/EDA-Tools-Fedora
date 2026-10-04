#!/usr/bin/env bash
# 2026-10-01
# Builds and installs xschem (schematic capture / netlisting tool) on Fedora 44.
# Usage: chmod +x xschem.sh && ./xschem.sh

set -e  # stop on first error
# Creates a file called eda-tools where all the git repos will be downloaded to  
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
