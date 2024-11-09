#!/usr/bin/bash

###################################################################################
# GTK --
# https://www.youtube.com/watch?v=qU6iDx4xB5o --> MODIFIER GTK
# https://github.com/EliverLara/Shades-of-purple-gtk
# https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme --> A VOIR ABSOLUMENT

# THEMES --
# https://github.com/SirEthanator/Hyprland-Dots/tree/main --> PRIORITAIRE
# 
# https://github.com/rose-pine/cursor
# https://github.com/catppuccin/papirus-folders
# https://github.com/adi1090x/rofi
# https://github.com/System64fumo/syshud
###################################################################################

set -e  # Quitte immédiatement en cas d'erreur.

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source $SCRIPT_DIR/misc/config/config.sh # Inclure le fichier de configuration.
source $SCRIPT_DIR/misc/scripts/functions.sh  # Charge les fonctions définies dans le fichier fonction.sh.

# WORK IN TEMP DIR
workDirName="${HOME}/buildHypr";
rm -rf $workDirName

mkdir -p $workDirName
mkdir -p ~/.local/share/themes
mkdir -p ~/.local/share/icons
mkdir -p ~/.local/share/fonts
mkdir -p ~/.local/bin

##############################################################################
## Information Utilisateur                                              
##############################################################################
log_prompt "INFO" && read -p "Quel est votre nom d'utilisateur : " USER && echo ""

##############################################################################
## arch-chroot Définir le fuseau horaire + local                                                  
##############################################################################
log_prompt "INFO" && echo "Configuration du fuseau horaire"
sudo timedatectl set-ntp true
sudo timedatectl set-timezone ${REGION}/${CITY}
sudo localectl set-locale LANG="${LANG}" LC_TIME="${LANG}"
sudo hwclock --systohc --utc
timedatectl status
log_prompt "SUCCESS" && echo "OK" && echo ""

##############################################################################
## Installation de YAY                                               
##############################################################################
if ! command -v yay &> /dev/null; then
    log_prompt "INFO" && echo "Installation de YAY" && echo ""
    git clone https://aur.archlinux.org/yay-bin.git $workDirName/yay-bin
    cd $workDirName/yay-bin || exit
    makepkg -si --noconfirm && cd .. 
    log_prompt "SUCCESS" && echo "Terminée" && echo ""
else
    log_prompt "WARNING" && echo "YAY est déja installé" && echo ""
fi

yay -Y --gendb
yay -Syu --devel --noconfirm
yay -Y --devel --save

##############################################################################
## Installation de PARU                                                 
##############################################################################
if [[ "$PARU" == "On" ]]; then
    if ! command -v paru &> /dev/null; then
        log_prompt "INFO" && echo "Installation de PARU" && echo ""
        git clone https://aur.archlinux.org/paru.git $workDirName/paru
        cd $workDirName/paru || exit
        makepkg -si --noconfirm && cd .. 
        log_prompt "SUCCESS" && echo "Terminée" && echo ""

    else
        log_prompt "WARNING" && echo "PARU est déja installé" && echo ""
    fi
fi

##############################################################################
## Installation des utilitaires (libnotify)                                                 
##############################################################################

yay -S --needed --noconfirm --ask=4 waybar polkit-kde-agent btop kitty starship dolphin mako lxappearance which neofetch macchina yad rustup 
yay -S --needed --noconfirm --ask=4 wl-clipboard slurp grim jq swww wlogout unzip rofi-wayland kvantum kvantum-qt5 qt5ct qt6ct gtk2 gtk3 gtk4 swaync pipewire-jack pamixer pavucontrol pulseaudio         
yay -S --needed --noconfirm --ask=4 ttf-jetbrains-mono-nerd ocean-sound-theme noto-fonts

## sddm
yay -S --needed --noconfirm --ask=4 sddm qt6-svg qt6-declarative qt5-quickcontrols2

## hypridle                                       
yay -S --needed --noconfirm --ask=4 mesa wayland-protocols wayland 

## hyprlock                                              
yay -S --needed --noconfirm --ask=4 mesa wayland-protocols wayland cairo libdrm pango libxkbcommon pam

## xdg-desktop-portal-hyprland                                              
yay -S --needed --noconfirm --ask=4 gbm hyprland-protocols libdrm libpipewire sdbus-cpp wayland-protocols

## hyprpaper                                              
yay -S --needed --noconfirm --ask=4 wayland wayland-protocols pango cairo libglvnd libjpeg-turbo libwebp gcc pkgconf 

## aquamarine                                              
yay -S --needed --noconfirm --ask=4 hwdata 

## hyprcursor                                              
yay -S --needed --noconfirm --ask=4 tomlplusplus librsvg libzip cairo

## Hyprland 
yay -S --needed --noconfirm --ask=4 gdb ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus xcb-util-errors

## hyprwayland-scanner 
yay -S --needed --noconfirm --ask=4 pugixml

##############################################################################
## Installation de l'utilitaires syshud                                               
##############################################################################
git clone https://aur.archlinux.org/syshud.git $workDirName/syshud
cd $workDirName/syshud
makepkg -si --noconfirm --needed  # -s will install deps, -i installs automatically
cd ..



##############################################################################
## Fonts Installation                                            
##############################################################################
cd ~/.local/share/fonts
# Télécharger chaque fichier seulement s'il n'existe pas déjà
for url in "${URL_FONTS[@]}"; do
  file_name=$(basename "$url")
  if [ ! -f "$file_name" ]; then
    log_prompt "INFO" && echo "Téléchargement de $file_name" && echo ""
    curl -fLO "$url"
  else
    log_prompt "WARNING" && echo "$file_name existe déjà, fonts ignoré" && echo ""
  fi
done


##############################################################################
## Themes Installation                                            
##############################################################################

# yay -S --needed --noconfirm --ask=4 "${GTK}"
# yay -S --needed --noconfirm --ask=4 "${CURSORS}"
# yay -S --needed --noconfirm --ask=4 "${KVANTUM}"
# yay -S --needed --noconfirm --ask=4 "${ICONS}"

##############################################################################
## Icons Installation : https://github.com/vinceliuice/Tela-circle-icon-theme                                           
##############################################################################
# git clone https://github.com/vinceliuice/Tela-icon-theme.git $workDirName/Tela-icon-theme
# cd $workDirName/Tela-icon-theme
# chmod +x install.sh
# bash install.sh -a 
# cd ..

##############################################################################
## SDDM Installation : https://wiki.archlinux.org/title/SDDM_(Fran%C3%A7ais)                                         
##############################################################################
# wget ${SDDM} -O $workDirName/catppuccin.zip
# sudo mkdir -p /usr/share/sddm/themes/${SDDM_THEME_NAME}
# sudo unzip $workDirName/catppuccin.zip -d /usr/share/sddm/themes




##############################################################################
## hyprshot                                               
##############################################################################
# mkdir -p ~/.config/Hyprshot 
git clone https://github.com/Gustash/hyprshot.git ~/.config/Hyprshot
ln -s ~/.config/Hyprshot/hyprshot $HOME/.local/bin
chmod +x ~/.config/Hyprshot/hyprshot


##############################################################################
## hyprutils                                              
##############################################################################
log_prompt "INFO" && echo "Installation de hyprutils" && echo ""
git clone --recursive https://github.com/hyprwm/hyprutils.git $workDirName/hyprutils
cd $workDirName/hyprutils
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build
cd ..

##############################################################################
## hyprland-protocols                                          
##############################################################################
log_prompt "INFO" && echo "Installation de hyprland-protocols" && echo ""
git clone --recursive https://github.com/hyprwm/hyprland-protocols.git $workDirName/hyprland-protocols
cd $workDirName/hyprland-protocols
meson setup build
ninja -C build
sudo ninja -C build install


##############################################################################
## hyprlang                                              
##############################################################################
log_prompt "INFO" && echo "Installation de hyprlang" && echo ""
git clone --recursive https://github.com/hyprwm/hyprlang.git $workDirName/hyprlang
cd $workDirName/hyprlang
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build
cd ..


##############################################################################
## hypridle                                       
##############################################################################
git clone --recursive https://github.com/hyprwm/hypridle.git $workDirName/hypridle
cd $workDirName/hypridle
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hypridle -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build
cd ..


##############################################################################
## hyprlock                                              
##############################################################################
log_prompt "INFO" && echo "Installation de hyprlock" && echo ""
git clone --recursive https://github.com/hyprwm/hyprlock.git $workDirName/hyprlock
cd $workDirName/hyprlock
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build
cd ..

##############################################################################
## hyprwayland-scanner                                              
##############################################################################
log_prompt "INFO" && echo "Installation de hyprwayland-scanner" && echo ""
git clone --recursive https://github.com/hyprwm/hyprwayland-scanner.git $workDirName/hyprwayland-scanner
cd $workDirName/hyprwayland-scanner
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build -j `nproc`
sudo cmake --install build
cd ..


##############################################################################
## xdg-desktop-portal-hyprland                                              
##############################################################################
log_prompt "INFO" && echo "Installation de xdg-desktop-portal-hyprland" && echo ""
git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland $workDirName/xdg-desktop-portal-hyprland
cd $workDirName/xdg-desktop-portal-hyprland
cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build
sudo cmake --install build
cd ..


##############################################################################
## hyprpaper                                              
##############################################################################
log_prompt "INFO" && echo "Installation de hyprpaper" && echo ""
git clone --recursive https://github.com/hyprwm/hyprpaper.git $workDirName/hyprpaper
cd $workDirName/hyprpaper
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprpaper -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build
cd ..

##############################################################################
## aquamarine                                              
##############################################################################
log_prompt "INFO" && echo "Installation de aquamarine" && echo ""
git clone --recursive https://github.com/hyprwm/aquamarine.git $workDirName/aquamarine
cd $workDirName/aquamarine
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build
cd ..


##############################################################################
## hyprcursor                                              
##############################################################################
log_prompt "INFO" && echo "Installation de hyprcursor" && echo ""
git clone --recursive https://github.com/hyprwm/hyprcursor.git $workDirName/hyprcursor
cd $workDirName/hyprcursor
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build
cd ..


##############################################################################
## Hyprland                                              
##############################################################################
log_prompt "INFO" && echo "Installation de Hyprland" && echo ""
git clone --recursive https://github.com/hyprwm/Hyprland $workDirName/Hyprland
cd $workDirName/Hyprland
make all && sudo make install
cd ..


##############################################################################
## Configuration                                              
##############################################################################
# kitty +kitten themes --reload-in=all Catppuccin-Mocha


# cp -rf $SCRIPT_DIR/misc/dots/config/hypr ~/.config
# sudo cp -rf $SCRIPT_DIR/misc/dots/etc/environment /etc
# sudo cp -rf $SCRIPT_DIR/misc/dots/etc/sddm.conf /etc/sddm.conf


##############################################################################
## Activation des services                                              
##############################################################################
# sudo systemctl enable sddm


##############################################################################
## clean                                              
##############################################################################
cd ..
rm -rf $workDirName
log_prompt "SUCCESS" && echo "Installation de Hyprland terminé redémarrer votre systeme" && echo ""