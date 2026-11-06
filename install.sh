#!/usr/bin/env bash
# Stow all packages from this repo into $HOME (see .stowrc).
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"

pkgs=(bat git hypr kitty lazygit noctalia nvim starship waybar wofi)

stow -R "${pkgs[@]}"
echo "stowed: ${pkgs[*]}"
