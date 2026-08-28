#!/usr/bin/env bash
# install_gaw.sh
# Installs gaw (xschem-gaw) waveform viewer on Fedora.
# Usage: chmod +x install_gaw.sh && ./install_gaw.sh

set -e  # stop on first error

echo "==> Installing build dependencies..."
sudo dnf install -y gcc make automake autoconf gtk3-devel alsa-lib-devel \
    gettext-devel git libtool

echo "==> Cloning xschem-gaw..."
git clone https://github.com/StefanSchippers/xschem-gaw.git
cd xschem-gaw

echo "==> Running autotools..."
aclocal
autoconf
./configure

echo "==> Building..."
# Modern GCC (14+/15+) treats old K&R-style declarations and implicit
# pointer conversions as hard errors instead of warnings. These flags
# restore the old permissive behavior so legacy sources like gaw compile.
make CFLAGS="-std=gnu17 -Wno-error=incompatible-pointer-types"

echo "==> Installing..."
sudo make install

echo "==> Done. Try running: gaw"
