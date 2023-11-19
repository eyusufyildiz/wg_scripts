#!/bin/bash

echo "---------------------------------------------"
echo "1 Adding Server Key"

function set_vars() {
    ADMIN_SERVER="starvpnzone.duckdns.org"
    ADMIN_SERVER_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCZeHsguTHUOT2vammbjgchGxrdh5ax8barhXyEqGi3FWOkNjOepMjzC6y40gl8a0vIFsMhO0urKzS/jiJuvnVIRrp2hJeWD7JBWtPNqD2YxWQ85oDpy8UO7PASW0tzwbCwX6Sj6lW1XfBQHxiBGCGTSblBXPsk6o6m0Jn/NZHWdx7dDbwAP7XKdKxIg4KaQ/eVlY2+O9bKp5CrMh1QRvhr6/FZoaJs/ktQGd9lGX/AdxA3xAHuiBduQv6YwNaVguxpGgZuifNAw0ewpqVoFkKBGyWkEqcf/JKoTPXpQ6qlXGD7bxZUCUTQ9fiOc7I++Qp7Z999ErRYZ/eB3jNYu5pUJplUgs/TKwusJfyb+0eOsRrsAyGap/M14oI/uNRLRj394aFqUs5qKtPCyiv0KfRvyaH1Axh/zBXVXIWwS5dyYpjXzBqoxYoZCKLECe127QbcdxWhe6+m2vZGgTX9fsW0cX2OrXWldiBqO1qmPK1qYKVndINjXAlxE9/ovmpEoC0= ubuntu@phx1"
}

function add_server_key() {
    # Adding Server Key
    echo "1.1 Adding it to ~/.ssh/authorized_keys..."
    echo $ADMIN_SERVER_KEY  >> ~/.ssh/authorized_keys

    if [ $? -eq 0 ]; then
       echo "$ADMIN_SERVER Public Key is added to ~/.ssh/authorized_keys.."
    else
       echo "Error: Please check ~/.ssh/authorized_keys"
    fi
}

set_vars
add_server_key
