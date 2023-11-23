#!/bin/bash

echo "---------------------------------------------"
echo "1 Adding Server Key"

function set_vars() {
    ADMIN_SERVER="starvpnzone.duckdns.org"
    ADMIN_SERVER_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDs/hiIgOe/yzJilkgIyYj9+3vq3gGIFH4OEWIqJ3/DyE7BWAkccjSEJRqejiMBailwMSkhPKI8VtvsJz2tP63eThaBwhOLzlqgPskbsXHPSDPP6mRpKsIc9ivuX4vhmSl241Z4PI7VWaZSUo3hvoT83qGsUFCs3L7Dp1PTSPcZx2NHt2m6KobAu21Jhzy6vPvBhT09no9D7IzSWK6vfDw3FLrFo8Spvr2KY7QO15RKop+rqYEs/9LP82Oa70To3T7DI8Qx4Q/wFmk7r2Hy90yWX2IVt8G04fI8BWkiBXfpGXxDxF39M4OFY3SDMNqtxeu2HZkWIcO4nTASm2KkZqr2eBAe8jwiT5xdhgMhIW0DybCustxgZpJlekI2Tp+NHCP3RozRK7Cre5+ycWEZib8siZwo3eYfL2yO5YUgnBGc9B92S0Uzg3VFeUCa0ShiQ+VFtFR6a9o+h7j51o4SEfKMf0EOvcR7erP8mnFvknXW9L7ce43hAL07Ees0nLSXXMM= opc@phx4"
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
