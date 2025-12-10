#!/usr/bin/env bash

PKGLIST_DIR="$HOME/.config/pkglist"

sudo pacman -S --needed - < "$PKGLIST_DIR/pkglist-generic.txt"

# Install CPU-specific microcode
if grep -qi intel /proc/cpuinfo; then
    sudo pacman -S --needed intel-ucode
elif grep -qi amd /proc/cpuinfo; then
    sudo pacman -S --needed amd-ucode
fi
