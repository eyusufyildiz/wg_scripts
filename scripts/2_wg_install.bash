#!/bin/bash

echo "---------------------------------------------"
echo "2 Application Installation"

function set_vars(){
    OS=`source /etc/os-release && echo $ID`
    PKG_LIST_RPM="wireguard-tools curl tcpdump vim net-tools cron"
    PKG_LIST_DEB="wireguard curl tcpdump vim net-tools speedtest-cli"
}

function install_apps(){
    echo "2.1 Installing $PKG_LIST applications..."
    echo "OS: $OS"
    
    if [ $OS = "ol" ] || [ $OS = "centos" ]; then
        sudo yum update
        sudo yum upgrade -y && sudo yum install $PKG_LIST_RPM -y 
    elif [ $OS = "ubuntu" ] || [ $OS = "debian" ]; then
        sudo apt update
        sudo apt upgrade -y
        sudo apt install $PKG_LIST_DEB -y 
        sudo apt autoremove -y
        sudo reboot
    fi
}


set_vars
install_apps
