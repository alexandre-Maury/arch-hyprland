#!/bin/bash

# script config.sh

##############################################################################
## Config arch post-install                                                   
##############################################################################

REGION="Europe"
PAYS="France"
CITY="Paris"
LANG="fr_FR.UTF-8"
PARU="Off"

# https://github.com/ryanoasis/nerd-fonts/tree/300890327ae50ed08a0c2ba89e8bfd67425dd3b8
URL_FONTS=(
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/FiraCodeNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/FiraCodeNerdFontPropo-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFontPropo-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/L/Regular/MesloLGLNerdFont-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/L/Regular/MesloLGLNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/L/Regular/MesloLGLNerdFontPropo-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/L-DZ/Regular/MesloLGLDZNerdFont-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/L-DZ/Regular/MesloLGLDZNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/L-DZ/Regular/MesloLGLDZNerdFontPropo-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/M/Regular/MesloLGMNerdFont-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/M/Regular/MesloLGMNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/M/Regular/MesloLGMNerdFontPropo-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/M-DZ/Regular/MesloLGMDZNerdFont-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/M-DZ/Regular/MesloLGMDZNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/M-DZ/Regular/MesloLGMDZNerdFontPropo-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/S-DZ/Regular/MesloLGSDZNerdFont-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/S-DZ/Regular/MesloLGSDZNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/S-DZ/Regular/MesloLGSDZNerdFontPropo-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/S/Regular/MesloLGSNerdFont-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/S/Regular/MesloLGSNerdFontMono-Regular.ttf"
  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/S/Regular/MesloLGSNerdFontPropo-Regular.ttf"
)

URL_CURSORS=(
  "https://github.com/catppuccin/cursors/releases/download/v1.0.1/catppuccin-macchiato-dark-cursors.zip"
  "https://github.com/catppuccin/cursors/releases/download/v1.0.1/catppuccin-mocha-dark-cursors.zip"
  "https://github.com/catppuccin/cursors/releases/download/v1.0.1/catppuccin-macchiato-lavender-cursors.zip"
  "https://github.com/catppuccin/cursors/releases/download/v1.0.1/catppuccin-mocha-lavender-cursors.zip"
  "https://github.com/rose-pine/cursor/releases/download/v1.1.0/BreezeX-RosePine-Linux.tar.xz"
)

# wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh


# https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-frappe.zip
# https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-latte.zip
# https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-macchiato.zip
# https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip
SDDM="https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip"
SDDM_THEME_NAME="catppuccin-mocha" # Penser à modifier dans : $SCRIPT_DIR/misc/dots/etc/sddm.conf


