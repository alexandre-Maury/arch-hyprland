#!/usr/bin/bash


set -e  # Quitte immédiatement en cas d'erreur.

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source $SCRIPT_DIR/misc/config/config.sh # Inclure le fichier de configuration.
source $SCRIPT_DIR/misc/scripts/functions.sh  # Charge les fonctions définies dans le fichier fonction.sh.

# WORK IN TEMP DIR
workDirName="${HOME}/buildHypr";
rm -rf $workDirName
mkdir -p $workDirName

##############################################################################
## Information Utilisateur                                              
##############################################################################
log_prompt "INFO" && read -p "Quel est votre nom d'utilisateur : " USER && echo ""

##############################################################################
## Mise à jour du système                                                 
##############################################################################
log_prompt "INFO" && echo "Mise à jour du système "
sudo pacman -Syyu --noconfirm
log_prompt "SUCCESS" && echo "OK" && echo ""

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
if [[ "$YAY" == "On" ]]; then
    if ! command -v yay &> /dev/null; then
        log_prompt "INFO" && echo "Installation de YAY" && echo ""
        git clone https://aur.archlinux.org/yay-bin.git $workDirName/yay-bin
        cd $workDirName/yay-bin || exit
        makepkg -si --noconfirm && cd .. 
        log_prompt "SUCCESS" && echo "Terminée" && echo ""

        # Generate yay database
        yay -Y --gendb

        # Update the system and AUR packages, including development packages
        yay -Syu --devel --noconfirm

        # Save the current development packages
        yay -Y --devel --save

    else
        log_prompt "WARNING" && echo "YAY est déja installé" && echo ""
    fi
fi

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

mkdir -p ~/.local/share/themes
mkdir -p ~/.local/share/icons
mkdir -p ~/.local/share/fonts

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
# cd ~/.local/share/themes




##############################################################################
## Icons Installation                                            
##############################################################################
# cd ~/.local/share/icons


##############################################################################
## Installation des utilitaires                                                 
##############################################################################

# yay -S --needed --noconfirm --ask=4 curl tar wget cmake meson ninja gcc make cairo libzip librsvg tomlplusplus gdb pugixml gbm libdrm libpipewire sdbus-cpp \
#     libjpeg-turbo libwebp pango pkgconf libglvnd udis-86 libxcb xcb-proto xcb-util xcb-util-keysyms wayland wayland-protocols scdoc \
#     libxfixes libx11 libxcomposite xorg-xinput libxrender pixman libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info \
#     cpio xcb-util-errors

# yay -S --needed --noconfirm --ask=4 firefox \
#     kitty \
#     dolphin \
#     ark \
#     vim \
#     code \
#     alacritty \
#     btop

# yay -S --needed --noconfirm --ask=4 nwg-look \
#     qt5ct \
#     qt6ct \
#     kvantum \
#     kvantum-qt5 \
#     qt5-wayland \
#     qt6-wayland                                  


# yay -S --needed --noconfirm --ask=4 polkit-kde-agent \
#     xdg-desktop-portal-hyprland \
#     xdg-desktop-portal-gtk \
#     pacman-contrib \
#     python-pyamdgpuinfo \
#     parallel \
#     jq \
#     imagemagick \
#     qt5-imageformats \
#     ffmpegthumbs \
#     kde-cli-tools \
#     libnotify

# yay -S --needed --noconfirm --ask=4 dunst \
#     rofi-wayland \
#     waybar \
#     swww \
#     swaylock-effects-git \
#     wlogout \
#     grimblast-git \
#     slurp \
#     swappy \
#     hyprpicker \
#     cliphist
#     # 
#     # wl-clipboard

# yay -S --needed --noconfirm --ask=4 seatd \
#     glibc \
#     pam  

# yay -S --needed --noconfirm --ask=4 pipewire \
#     pipewire-alsa \
#     pipewire-audio \
#     pipewire-jack \
#     pipewire-pulse \
#     gst-plugin-pipewire \
#     wireplumber \
#     pavucontrol \
#     pamixer \
#     networkmanager \
#     network-manager-applet \
#     bluez \
#     bluez-utils \
#     blueman \
#     brightnessctl \
#     cava \
#     udiskie                                      
    # iw wpa_supplicant alsa-utils alsa-plugins


# yay -S sddm \                                              
#     qt5-quickcontrols \                                    
#     qt5-quickcontrols2 \                                   
#     qt5-graphicaleffects                     

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
## hyprland-protocols                                          
##############################################################################
log_prompt "INFO" && echo "Installation de hyprland-protocols" && echo ""

git clone --recursive https://github.com/hyprwm/hyprland-protocols.git $workDirName/hyprland-protocols
cd $workDirName/hyprland-protocols
meson setup build
ninja -C build
sudo ninja -C build install

##############################################################################
## xdg-desktop-portal-hyprland                                              
##############################################################################
log_prompt "INFO" && echo "Installation de xdg-desktop-portal-hyprland" && echo ""
# libpipewire-0.3 libspa-0.2 

git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland $workDirName/xdg-desktop-portal-hyprland
cd $workDirName/xdg-desktop-portal-hyprland
cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build
sudo cmake --install build
cd ..


##############################################################################
## aquamarine                                              
##############################################################################
log_prompt "INFO" && echo "Installation de aquamarine" && echo ""
yay -S hwdata --noconfirm

git clone --recursive https://github.com/hyprwm/aquamarine.git $workDirName/aquamarine
cd $workDirName/aquamarine
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build
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
cp -rf $SCRIPT_DIR/misc/dots/.config $HOME
cp -rf $SCRIPT_DIR/misc/dots/.local/share $HOME/.local

cp -rf $SCRIPT_DIR/misc/dots/wallpaper $HOME
cp -rf $SCRIPT_DIR/misc/dots/scripts $HOME
cp -rf $SCRIPT_DIR/misc/dots/user/.gtkrc-2.0 $HOME 


##############################################################################
## Activation des services                                              
##############################################################################
# sudo systemctl enable bluetooth 
# sudo systemctl enable fstrim
# sudo systemctl enable seatd

# Chemin du dossier contenant les scripts
dossier_scripts="$HOME/.local/share/bin"

# Boucle sur tous les fichiers du dossier
for fichier in "$dossier_scripts"/*; do
  # Vérifie si le fichier est un fichier régulier (et non un dossier)
  if [ -f "$fichier" ]; then
    # Rend le fichier exécutable
    chmod +x "$fichier"
    echo "Le fichier $fichier est maintenant exécutable."
  fi
done


##############################################################################
## clean                                              
##############################################################################
cd ..
rm -rf $workDirName
log_prompt "SUCCESS" && echo "Installation de Hyprland terminé redémarrer votre systeme" && echo ""