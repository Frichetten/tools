#!/bin/bash
# Author: Nick Frichette
# Intended OS: Kali Linux/Debian
# Description: A quick script to install some tools after 
#     the OS has been flashed.

# Root check
if [ $EUID != 0 ]; then
    echo "[!] To install you must run as root."
    exit 1
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
fi

# They answered yes so let's install some tools

echo "[+] Updating the OS"
apt update
apt upgrade -y
apt dist-upgrade -y

echo "[+] Installing i3wm"
apt install -y i3

echo "[+] Downloading Personal Configs"
wget https://github.com/Frichetten/dotfiles/archive/master.zip -O /tmp/dotfiles.zip
unzip /tmp/dotfiles.zip -d /tmp
cp -r /tmp/dotfiles-master/* ~/.config/
rm ~/.config/README.md

echo "[+] Install Polybar"
apt install -y cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev \
    libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev \
    libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm \
    libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev \
    libxcb-composite0-dev
git clone https://github.com/jaagr/polybar.git
mv polybar/ /tmp/
cd /tmp/polybar
./build.sh
cd ~/Documents

echo "[!] Need to Fix Polybar"
echo "Run 'xrandr --listmonitors' and get the monitor name"
echo "of the monitor you'd like to use. Replace this in the"
echo "Polybar config at ~/.config/polybar/config"
read -p "[?] Are you done? [Y/n]: " answer
if [ $answer != "Y" ]; then
    echo "[!] Did not answer yes. Exiting."
fi

echo "[+] Install PyWal"
pip3 install --user pywal
echo 'PATH="${PATH}:${HOME}/.local/bin"' >> ~/.bashrc

echo "[+] Install Ranger"
apt install -y ranger

echo "[+] Install arandr"
apt install -y arandr

echo "[+] Install Rofi"
apt install -y rofi

echo "[+] Install Nitrogen"
apt install -y nitrogen

echo "[+] Install Neofetch"
apt install -y neofetch
