#!/usr/bin/env bash
set -euo pipefail

PKGLIST_DIR="$HOME/.config/pacman"
ZRAM_CONFIG_DIR="/etc/systemd/zram-generator.conf.d"
ZRAM_CONFIG_FILE="$ZRAM_CONFIG_DIR/10-zram0.conf"

echo "Installing packages."
sudo pacman -S --needed - < "$PKGLIST_DIR/pkglist.txt"

# Install CPU-specific microcode
if grep -qi intel /proc/cpuinfo; then
    sudo pacman -S --needed intel-ucode
elif grep -qi amd /proc/cpuinfo; then
    sudo pacman -S --needed amd-ucode
fi

# Create zram config dir
echo "Creating zram-generator config directory: $CONFIG_DIR"
sudo mkdir -p $ZRAM_CONFIG_DIR

# Write or overwrite zram0 config
echo "Writing zram0 configuration to $CONFIG_FILE"
sudo tee "$CONFIG_FILE" > /dev/null << 'EOF'
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
EOF

# Reload systemd configuration
echo "Reloading systemd daemon…"
sudo systemctl daemon-reload

# Enable & start the zram swap device
echo "Enabling and starting zram swap…"
sudo systemctl enable --now systemd-zram-setup@zram0.service

echo "Done! Current swap status:"
swapon --show
