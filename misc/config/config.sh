#!/bin/bash

# script config.sh

##############################################################################
## Config arch post-install                                                   
##############################################################################

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