#!/usr/bin/env bash
# 2026-10-04
# Instructions to download and install Gaw (Analog waveform visualizer)
# Tested on Fedora 44.
# Usage: chmod +x gaw.sh && ./gaw.sh

# Creates a file called eda-tools where all the git repos will be downloaded to  
[ -d "$HOME/eda-tools" ] || mkdir "$HOME/eda-tools"

cd $HOME/eda-tools

echo "==> Download link: https://www.rvq.fr/php/ndl.php?id=gaw.?-.*"

echo "==> Extract file:tar zxvf gaw3-yyyymmdd.tar.gz"

echo "==> Change Directory to: cd gaw3-yyyymmdd"

echo "==> Run: ./configure"

echo "==> Build: make"

echo "==> Install: sudo make install"

echo "==> If it installs with no error run: gaw"
