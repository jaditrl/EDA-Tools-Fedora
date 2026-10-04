#!/usr/bin/env bash
# 2026-10-01
# Builds and installs Magic (VLSI layout tool) tested on Fedora 44.
# Usage: chmod +x magic.sh && ./install_magic.sh

set -e  # stop on first error
[ -d "$HOME/eda-tools" ] || mkdir "$HOME/eda-tools"

cd $HOME/eda-tools

echo "==> Installing build dependencies..."
sudo dnf install m4 tcsh csh gcc-c++ make git \
    libX11-devel tcl8-devel tk8-devel cairo-devel \
    ncurses-devel mesa-libGLU-devel freeglut-devel mesa-libGL-devel \
    libstdc++-devel fontconfig-devel freetype-devel libXi-devel libXext-devel

echo "==> Cloning magic..."
git clone https://github.com/RTimothyEdwards/magic.git
cd magic

echo "==> Configuring..."
./configure

echo "==> Building..."
make CFLAGS="-std=gnu17 -Wno-error=incompatible-pointer-types -g -m64 -fPIC"

echo "==> Installing..."
sudo make install

echo "==> Done. Try running: magic"
