#!/bin/bash

echo "---------------------------------------------"
echo "1 Adding Server Key"

function set_vars() {
    ADMIN_SERVER="star-vpn.duckdns.org"
    ADMIN_SERVER_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCSpXCQ/kiGPfuhHm1zb9ljUQV6+xQz5xIKRVt9/liDwaI5fL5/i7Fn7HpyX49QY7qs8xGgjGqpu3Ds1sYPvOOwiF+zWKi6hKzEnRp6Xe5i+aVGXG1gw0lUCcpTNNyRtgr0fKImEBg0+Dh5rHv7FwpnKoTFKCsdlBn93vVIQwBSxsih5p9p6QELo/hnxQ4pc+QXtzTImFHQmTmMNzdfnbrn3sGEm/vSUaOwXDuzM1/AmZA9lycwF+GSBGaCRUxx5eKlKbIG9+nYCAHj0TVJIfKsoeQcGJ/2N3FE6pUw2HzlQp4YdgR7DOxlvgPlqsePuyRRBL74pH5YUd0R6jM1UvX"
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
