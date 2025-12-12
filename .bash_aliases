alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

alias mkpkglist="pacman -Qqe | grep -Ev '^(intel-ucode|amd-ucode|xf86-video-intel|nvidia|nvidia-utils)$' > $HOME/.config/pkglists/pkglist.txt"
