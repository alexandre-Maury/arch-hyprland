#!/usr/bin/bash

###################################################################################
# https://github.com/EliverLara/Shades-of-purple-gtk


# THEMES --
# https://github.com/SirEthanator/Hyprland-Dots/tree/main --> PRIORITAIRE
# https://github.com/orgs/catppuccin/repositories

# Kvantum --> import rose-pine
###################################################################################

set -e  # Quitte immédiatement en cas d'erreur.

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source $SCRIPT_DIR/misc/config/config.sh # Inclure le fichier de configuration.
source $SCRIPT_DIR/misc/scripts/functions.sh  # Charge les fonctions définies dans le fichier fonction.sh.

# WORK IN TEMP DIR
workDirName="${HOME}/buildHypr";
rm -rf $workDirName

mkdir -p $workDirName
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-4.0
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
## Installation des utilitaires (libnotify - mako - lxappearance- gedit)                                                 
##############################################################################

yay -S --needed --noconfirm --ask=4 waybar libappindicator-gtk3 libindicator-gtk3 polkit-kde-agent btop kitty starship dolphin which neofetch macchina yad rustup firefox brightnessctl networkmanager network-manager-applet nm-connection-editor indicator-sensors
yay -S --needed --noconfirm --ask=4 wl-clipboard slurp grim jq swww wlogout unzip wofi wofi-emoji rofi-wayland kvantum kvantum-qt5 qt5ct qt6ct gtk2 gtk3 gtk4 swaync pipewire pipewire-alsa pipewire-pulse pipewire-jack pamixer pavucontrol pulseaudio bluez bluez-utils blueman        
yay -S --needed --noconfirm --ask=4 ttf-jetbrains-mono-nerd ocean-sound-theme noto-fonts nwg-look gtk-engine-murrine

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
log_prompt "INFO" && echo "Installation de Hyprland" && echo ""
git clone --recursive https://github.com/alexandre-Maury/dotfiles.git $workDirName/dotfiles
cd $workDirName/dotfiles

cp -rf .config/cava ~/.config
cp -rf .config/hypr ~/.config
cp -rf .config/kitty ~/.config
cp -rf .config/Kvantum ~/.config
cp -rf .config/macchina ~/.config
cp -rf .config/nvim ~/.config
cp -rf .config/rofi ~/.config
cp -rf .config/swaync ~/.config
cp -rf .config/waybar ~/.config
cp -rf .config/starship.toml ~/.config

unzip .themes/Catppuccin-Mocha.zip -d ~/.local/share/themes
unzip .themes/Catppuccin-Macchiato.zip -d ~/.local/share/themes
unzip .themes/Rosepine.zip -d ~/.local/share/themes

unzip .cursor/Catppuccin-Macchiato.zip -d ~/.local/share/icons
unzip .cursor/Catppuccin-Mocha.zip -d ~/.local/share/icons
unzip .cursor/rosepine.zip -d ~/.local/share/icons

unzip .icons/Catppuccin-Macchiato.zip -d ~/.local/share/icons
unzip .icons/Catppuccin-Mocha.zip -d ~/.local/share/icons
unzip .icons/rosepine.zip -d ~/.local/share/icons

cp -rf Scripts ~/

chmod +x $HOME/.config/waybar/scripts/*
chmod +x $HOME/.config/hypr/scripts/*
chmod +x $HOME/.local/bin/*
chmod +x $HOME/Scripts/*


# sudo cp -rf $SCRIPT_DIR/misc/dots/etc/sddm.conf /etc/sddm.conf

kitty +kitten themes --reload-in=all Rosé Pine
# kitty +kitten themes --reload-in=all Catppuccin-Macchiato
# kitty +kitten themes --reload-in=all Catppuccin-Mocha


##############################################################################
## Activation des services                                              
##############################################################################
# sudo systemctl enable sddm
sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service


##############################################################################
## clean                                              
##############################################################################
cd ..
# rm -rf $workDirName
log_prompt "SUCCESS" && echo "Installation de Hyprland terminé redémarrer votre systeme" && echo ""