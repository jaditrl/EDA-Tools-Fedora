#!/usr/bin/env bash
# install_magic.sh
# Builds and installs Magic (VLSI layout tool) on Fedora.
# Usage: chmod +x install_magic.sh && ./install_magic.sh

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
# Modern GCC (14+/15+) turns old K&R-style declarations and
# incompatible-pointer-type assignments into hard errors instead of
# warnings. Magic's source predates these checks, so we relax them
# to get a clean build.
make CFLAGS="-std=gnu17 -Wno-error=incompatible-pointer-types -g -m64 -fPIC"

echo "==> Installing..."
sudo make install

echo "==> Done. Try running: magic"
