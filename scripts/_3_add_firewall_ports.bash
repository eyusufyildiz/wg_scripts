#!/bin/bash

echo "---------------------------------------------"
echo "3 Adding ports to Firewall for WG-Server"

function port_add(){
    echo "3.1 Adding port 51820 to firewalld ..."
    sudo firewall-cmd --zone=public --add-port=51820/udp
    sudo firewall-cmd --zone=public --permanent --add-port=51820/udp

    echo "---------------------------------------------"
    echo "3.2 firewalld list-services:"
    sudo firewall-cmd --zone=public --list-services

    echo "---------------------------------------------"
    echo "3.3 firewalld list-ports:"
    sudo firewall-cmd --zone=public --permanent --list-ports
}

port_add