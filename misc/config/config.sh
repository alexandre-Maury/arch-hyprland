#!/bin/bash

# script config.sh

# https://catppuccin.com/ports
# https://github.com/catppuccin/fish
# https://github.com/catppuccin/fzf/tree/main
# https://github.com/catppuccin/hyprlock
# https://github.com/catppuccin/kitty
# https://github.com/catppuccin/rofi
# https://github.com/catppuccin/qt5ct
# https://github.com/catppuccin/obsidian
# https://github.com/catppuccin/nvim
# https://github.com/catppuccin/vim
# https://github.com/catppuccin/vscode
# https://github.com/catppuccin/vscode-icons
# https://github.com/catppuccin/thunderbird
# https://github.com/catppuccin/xresources
# https://github.com/catppuccin/zsh-syntax-highlighting
# https://github.com/catppuccin/zsh-fsh
# https://github.com/catppuccin/waybar/tree/main

# https://github.com/MrVivekRajan/Hypr-Dots/tree/Type-1

##############################################################################
## Config arch post-install                                                   
##############################################################################

REGION="Europe"
PAYS="France"
CITY="Paris"

LANG="fr_FR.UTF-8"

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

YAY="On"
PARU="Off"

# https://github.com/brycewalkerdev/catppuccin-gtk
# https://github.com/catppuccin/cursors
# https://github.com/catppuccin/sddm

GTK="catppuccin-gtk-theme-macchiato" # catppuccin-gtk-theme-mocha catppuccin-gtk-theme-macchiato catppuccin-gtk-theme-frappe catppuccin-gtk-theme-latte
ICONS="catppuccin-icons-git"
CURSORS="catppuccin-cursors-macchiato" # catppuccin-cursors-latte catppuccin-cursors-frappe catppuccin-cursors-macchiato catppuccin-cursors-mocha
KVANTUM="kvantum-theme-catppuccin-git"
SDDM="https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-macchiato.zip"
SDDM_THEME_NAME="catppuccin-macchiato"
# https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-frappe.zip
# https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-latte.zip
# https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-macchiato.zip
# https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip