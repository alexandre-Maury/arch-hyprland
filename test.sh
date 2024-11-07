#!/bin/bash

# Importer les informations du système d'exploitation en tant que variables
. /etc/os-release


# ==== Vérification de l'exécution sur Arch ==== #
if [[ $ID != 'arch' ]] && [[ $1 != '-f' ]]; then
  echo 'Arch Linux non détecté.'
  echo 'Ce script fonctionne uniquement sur Arch ou les distributions basées sur Arch.'
  echo 'Si vous êtes sur une distribution basée sur Arch ou souhaitez continuer, exécutez le script avec l’option -f.'
  exit 1
fi


printf '\033[1;33mATTENTION:\033[0m La majorité du script a été TRÈS peu testée, et certaines parties n’ont reçu aucun test.\n'
printf '\033[1;33mATTENTION:\033[0m Le script risque de causer des problèmes et n’installera PAS complètement la configuration.\n'
read -p 'Continuer quand même ? (y/N) ' confirmation
confirmation=$(echo "$confirmation" | tr '[:lower:]' '[:upper:]')
if [[ "$confirmation" == 'N' ]] || [[ "$confirmation" == '' ]]; then
  exit 0
fi


error() {
  printf "\033[0;31mERREUR: \033[0m $1"
  exit 1
}

backUp() {
  backupPath="$1"
  shift  # Décale les arguments vers la gauche (retire $1 de $@)
  items=("$@")

  if [[ ! -e "$backupPath"/.backup ]]; then mkdir "$backupPath"/.backup; fi
  local backedUp=false
  for item in "${items[@]}"; do
    if [[ -e "$backupPath"/"$item" ]]; then
      echo "Sauvegarde de ${backupPath}/${item}"
      mv ${backupPath}/${item} ${backupPath}/.backup  || error "Échec de la sauvegarde : ${backupPath}/${item}"
      backedUp=true
    fi
  done
  if [[ "$backedUp" = true ]]; then
    echo "Les éléments sauvegardés sont stockés dans ${backupPath}/.backup"
  else
    rm -d ${backupPath}/.backup > /dev/null 2>&1 || true
  fi
}


echo 'Installation des paquets...'
{
  sudo pacman --needed --noconfirm -Syu rustup pipewire-jack
  sudo pacman --needed --noconfirm -S \
    hyprland hyprpaper hyprcursor hyprlock waybar rofi-wayland swaync yad mate-polkit \
    kitty zsh starship neovim luajit stow neofetch hypridle cliphist grim slurp \
    kvantum kvantum-qt5 qt5ct qt6ct gtk2 gtk3 gtk4 \
    cargo base-devel fftw iniparser autoconf-archive pkgconf xdg-user-dirs wget unzip \
    pulseaudio pamixer ocean-sound-theme alsa-lib sox \
    ttf-cascadia-code ttf-cascadia-code-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono
  sudo pacman --needed --noconfirm -Rs grml-zsh-config
} || error 'Échec de l’installation des paquets requis'


if [[ ! -d $HOME/.oh-my-zsh ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

{
  if [[ ! -e $HOME/.cargo/bin/macchina ]]; then
    rustup default stable
    cargo install macchina
  fi
} || error 'Échec de l’installation de Macchina'

{
  if [[ ! -e /usr/bin/syshud ]]; then
    if [[ -e ./syshud ]]; then
      mv ./syshud ./syshud.bak
    fi
    git clone https://aur.archlinux.org/syshud.git syshud
    cd syshud
    makepkg -si --noconfirm --needed
    cd ..
    rm -rf ./syshud
  fi
} || error 'Échec de l’installation de Syshud'

{
  if [[ ! $(pacman -Q sddm > /dev/null 2>&1) ]]; then
    read -p 'Installer sddm ? (Y/n) ' instSDDM
    instSDDM=$(echo "$instSDDM" | tr '[:lower:]' '[:upper:]')
    if [[ "$instSDDM" == 'Y' ]] || [[ "$instSDDM" == '' ]]; then
      echo 'Installation de sddm...'
      sudo pacman --noconfirm -S sddm
      sudo systemctl enable sddm.service
    fi
  fi
} || error 'Échec de l’installation de SDDM'

backupItems=(Hyprland-Dots Scripts)
backUp $HOME "${backupItems[@]}"

backupItems=(.backup cava hypr kitty Kvantum macchina nvim rofi swaync waybar starship.toml)
backUp $HOME/.config "${backupItems[@]}"

# Sauvegarde des thèmes GTK
if [[ -e $HOME/.themes ]]; then
  themeDirs=(Everforest Everforest-hdpi Everforest-xhdpi \
            CatMocha CatMocha-hdpi CatMocha-xhdpi \
            Rose-Pine Rose-Pine-hdpi Rose-Pine-xhdpi)
  backUp $HOME/.themes "${themeDirs[@]}"
fi

# Sauvegarde des icônes et curseurs
if [[ -e $HOME/.icons ]]; then
  iconDirs=(Everfoest-Dark Papirus Papirus-Dark Papirus-Light Rose-Pine \
            catppuccin-cursors catppuccin-cursors-light everforest-cursors everforest-cursors-light rose-pine-cursors rose-pine-cursors-light)
  backUp $HOME/.icons "${iconDirs[@]}"
fi

# Cloner le dépôt et créer des liens symboliques avec stow
git clone https://github.com/SirEthanator/Hyprland-Dots.git $HOME/Hyprland-Dots || error 'Échec du clonage du dépôt'
cd $HOME/Hyprland-Dots || error 'Échec de l’accès au dépôt'
stow . || error 'Échec de la création des liens symboliques avec Stow'
