#!/bin/bash
# Author: Nick Frichette
# Intended OS: Kali Linux/Debian/Ubuntu
# Description: A quick script to install some tools after 
# the OS has been flashed.
#
# This script has two forms:
#   1) Intended to run on a host machine. This can be a laptop/desktop/server/vm/etc.
#   2) Intended to run from a container. 
#
# You can select which you'd like from the cli with either 'host' or 'container' as
# a cli argument.

# Root check
if [ $EUID != 0 ]; then
    echo "[!] To install you must run as root."
    exit 1
fi 

# Check home directory
if [ "$SUDO_USER" == "root" ]; then
    HOME_DIR="/root"
elif [ "$SUDO_USER" == "" ]; then
    HOME_DIR="/root"
else
    HOME_DIR="/home/$SUDO_USER"
fi

# Param check
if ([ "$#" != 1 ]) || ([ $1 != "host" ] && [ $1 != "container" ]); then
    echo "[!] Usage: sudo ./arsenal.sh (host || container)"
    exit 2
fi

echo "#########################################"
echo "#                                       #"
echo "#                Arsenal                #"
echo "#                                       #"
echo "# Give ordinary people the right tools, #"
echo "#  and they will design and build the   #"
echo "#      most extraordinary things.       #"
echo "#                                       #"
echo "#########################################"

read -p "[?] Are you sure you want to install the Arsenal? [Y/n]: " answer
if [ $answer != "Y" ]; then
    echo "[!] Did not answer yes. Exiting."
    exit 3
fi

# Update OS ###############################################
echo "[+] Updating the OS"
apt update
apt upgrade -y
apt dist-upgrade -y

echo "[+] Installing Tools"
echo "####################"
echo ""

if [ $1 == 'host' ]; then
    echo "[+] Installing Host Tools"
    echo "#########################"
    
    echo "[+] Installing i3wm"
    apt install -y i3

    echo "[+] Install arandr"
    apt install -y arandr

    echo "[+] Install Rofi"
    apt install -y rofi

    echo "[+] Install Nitrogen"
    apt install -y nitrogen

    echo "[+] Install i3-gaps"
    apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
	libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
	libstartup-notification0-dev libxcb-randr0-dev \
	libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
	libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
	autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev
    cd /tmp
    git clone https://www.github.com/Airblader/i3 i3-gaps
    cd /tmp/i3-gaps
    autoreconf --force --install
    rm -rf /tmp/i3-gaps/build
    mkdir -p /tmp/i3-gaps/build
    cd /tmp/i3-gaps/build
    ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
    make
    make install
    cd $HOME_DIR/tools

    echo "[+] Install Scrot"
    apt install -y scrot

    echo "[+] Install imagemagick"
    apt install -y imagemagick

    echo "[+] Install feh"
    apt install -y feh

    echo "[+] Install dunst"
    apt install -y dunst

    echo "[+] Install xautolock"
    apt install -y xautolock

    echo "[+] Install compton"
    apt install -y compton

    echo "[+] Install docker"
    apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' | sudo tee -a /etc/apt/sources.list.d/docker.list
    apt update
    apt install -y docker-ce docker-compose

    echo "[+] Install light"
    cd /tmp
    git clone https://github.com/haikarainen/light.git
    cd light
    ./autogen.sh
    ./configure && make
    make install
    cd $HOME_DIR/tools

    echo "[+] Install urxvt"
    # xsel and xclip are needed for copy paste
    apt install -y rxvt-unicode xsel xclip

    echo "[+] Install xdotool"
    # needed for i3 config
    apt install -y xdotool

    echo "[+] Install KVM/QEMU"
    apt install -y qemu-kvm libvirt0 virt-manager bridge-utils

    echo "[+] Install keepassxc"
    apt install -y keepassxc

    echo "[+] Install transmission"
    apt install -y transmission

    echo "[+] Install yubikey software"
    apt install -y gnupg2 gnupg-agent dirmngr cryptsetup scdaemon pcscd secure-delete hopenpgp-tools yubikey-personalization

    echo "[+] Install VSCode"
    apt install -y software-properties-common apt-transport-https wget
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
    add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    apt update
    apt install -y code

    echo "[+] Install i3lock-fancy"
    apt install -y i3lock-fancy

    echo "[+] Install pavucontrol"
    apt install -y pavucontrol

    echo "[+] Install lxappearance"
    apt install -y lxappearance

    echo "[+] Download the latest Kali linux hopefully"
    cd $HOME_DIR/Downloads
    curl https://cdimage.kali.org/current/ -s | grep installer-amd64.iso | cut -d "=" -f 5 | cut -d ">" -f 1 | sed 's/\"//g' | { read url; wget https://cdimage.kali.org/current/$url; }
    cd $HOME_DIR/tools

    echo "[+] Install rdesktop"
    apt install -y rdesktop

    echo "[+] Install dbeaver"
    snap install -y dbeaver-ce
fi

echo "[+] Installing Non-Host Tools"
echo "#############################"
if [ "$1" == "container" ]; then
    export DEBIAN_FRONTEND=noninteractive
fi

echo "[+] Installing pip3"
apt install -y python3-pip

echo "[+] Installing Vim"
apt install -y vim

echo "[+] Install Ranger"
apt install -y ranger

echo "[+] Install Neofetch"
apt install -y neofetch

echo "[+] Install aws cli"
apt install -y tzdata
apt install -y awscli

echo "[+] Install ScoutSuite"
pip3 install scoutsuite

echo "[+] Install dirsearch"
mkdir $HOME_DIR/scripts
cd $HOME_DIR/scripts
git clone https://github.com/maurosoria/dirsearch.git
cd $HOME_DIR/tools

echo "[+] Install pacu"
cd $HOME_DIR/scripts
git clone https://github.com/RhinoSecurityLabs/pacu.git
cd $HOME_DIR/scripts/pacu
bash install.sh
cd $HOME_DIR/tools

echo "[+] Install htop"
apt install -y htop

echo "[+] Installing gobuster"
apt install -y gobuster

echo "[+] Installing wordlists"
cd $HOME_DIR/scripts
git clone https://github.com/danielmiessler/SecLists.git
cd $HOME_DIR/tools

echo "[+] Install net-tools"
apt install -y net-tools

echo "[+] Install smbclient"
apt install -y smbclient

echo "[+] Install Linkfinder"
cd $HOME_DIR/scripts
git clone https://github.com/GerbenJavado/LinkFinder.git
cd $HOME_DIR/tools

echo "[+] Install ssh (gives you openssh-server)"
apt install -y ssh

echo "[+] Install Java"
apt install -y default-jre

echo "[+] Install cmatrix"
apt install -y cmatrix

echo "[+] Install nmap"
apt install -y nmap

echo "[+] Install hashcat"
apt install -y hashcat ocl-icd-opencl-dev

echo "[+] Install sqlmap"
apt install -y sqlmap

echo "[+] Install tmux"
apt install -y tmux

echo "[+] Install jython"
# Needed for some Burp extensions
apt install -y jython

echo "[+] Install Responder"
cd $HOME_DIR/scripts
git clone https://github.com/lgandx/Responder.git
cd $HOME_DIR/tools

echo "[+] Install font awesome"
apt install -y fonts-font-awesome

echo "[+] Install nodejs"
apt install -y nodejs

echo "[+] Install updog"
pip3 install updog

echo "[+] Install Chrome"
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install -y ./google-chrome-stable_current_amd64.deb
cd $HOME_DIR/tools

echo "[+] Install Metasploit"
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod 755 msfinstall
./msfinstall
rm msfinstall

echo "[+] Install socat"
apt install -y socat

echo "[+] Install chromium"
apt install -y chromium-browser

echo "[+] Install aquatone"
cd /tmp
wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip
unzip aquatone_linux_amd64_1.7.0.zip
mv /tmp/aquatone /usr/local/bin
cd $HOME_DIR/tools

echo "[+] Install smbmap"
cd $HOME_DIR/scripts
git clone https://github.com/ShawnDEvans/smbmap.git
cd $HOME_DIR/tools

echo "[+] Install hashid"
pip3 install hashid

echo "[+] Install resolvconf"
apt install -y resolvconf
mv /etc/resolv.conf /etc/resolv.conf.orig
ln -s /run/resolvconf/resolv.conf /etc/resolv.conf

##################
echo "REQUIRES INTERACTION"

if [ $1 == 'host' ]; then
    echo "[+] Install Polybar"
    apt install -y cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev \
	    libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev \
	    libxcb-xkb-dev pkg-config python3-xcbgen xcb-proto libxcb-xrm-dev i3-wm \
	    libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev \
	    libxcb-composite0-dev libjsoncpp-dev
    git clone https://github.com/jaagr/polybar.git
    mv polybar/ /tmp/
    cd /tmp/polybar
    ./build.sh
    cd $HOME_DIR/tools

    echo "[+] Install wireshark"
    apt install -y wireshark-qt
fi

echo "[+] Install kinit"
apt install -y krb5-user

echo "[+] Fixing ownership of /scripts"
cd $HOME_DIR
chown -R $SUDO_USER scripts/
cd $HOME_DIR/tools

echo "\n"
echo "#############################"
echo "Install Complete!"
echo "Dont forget the following:"
echo "(1) SwitchyOmega Chrome Extension"
echo "(2) Setup dark mode with lxappearance"
