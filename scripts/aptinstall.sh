#!/bin/bash

sudo apt update

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already installed: ${1}"
  fi
}

# Basics
#install chromium-browser
install curl
install exfat-utils
install file
install git
install htop
install nmap
install openvpn
install tmux
install vim-gnome
install exuberant-ctags

# Image processing
install gimp
install jpegoptim
install optipng

# Fun stuff
install figlet
install toilet
install lolcat

# Save thinkpad laptop battery
install tlp

# Python
install python3-venv
install python3-pip

# Snaps
install snapd
sudo snap install code --classic
#sudo snap install

install python-numpy
install python-scipy
install python-matplotlib
install ipython
install jupyter
install python-pandas #python-sympy python-nose spyder
