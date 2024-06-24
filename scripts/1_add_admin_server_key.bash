#!/bin/bash

echo "---------------------------------------------"
echo "1 Adding Server Key"

function set_vars() {
    ADMIN_SERVER="phx4.duckdns.org"
    ADMIN_SERVER_KEY="""

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDh2YRnP1vn1bXOxBqQCVBninJpLv4OuVmuo8W2ekUSH8GX3xxQoOHPWv2sGZ7qPYy9kv2Db5h9xtG+YsGZ8FYHvrhBoxkHO4GsLIsC+N9tg8RF50zmPa+Ze5w/BNnYjKZXuWRMhwbgxjmpItbvHb4vGaFXrnE4mBaU+K5/YStdUzdASAVL10xgKFAm7dciZlLNMii4t7iTjalAbyqtWt1z2JgoU8rlXxlQ26AGpXwZ50xiGyXlrhWOl3iYeYz1swCsnHbgjHuqonT3zeahmDxBXbYsYBTK5I6MtxNeHZlFy72/G9Bozu/1ZRIafdUdBB6bVx2XNsam6JQqLtQp2gPCPjRSpm4IypvhNuMQap4GMOJv34gBnTfOserZ0UafkNF7+PWqprpGUHOPyfMdjoCVTyP7tD56m/iuOUiLyUiWmzvs6suLRlHXgyT36aEIIue7DYpsg7S54EC9RxIPj+VP6eRp2ABahgNHih8512KeJAQXjH0iDQm2IdJO353sipU= yyildiz@US-YYILDIZ1
\n

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCZeHsguTHUOT2vammbjgchGxrdh5ax8barhXyEqGi3FWOkNjOepMjzC6y40gl8a0vIFsMhO0urKzS/jiJuvnVIRrp2hJeWD7JBWtPNqD2YxWQ85oDpy8UO7PASW0tzwbCwX6Sj6lW1XfBQHxiBGCGTSblBXPsk6o6m0Jn/NZHWdx7dDbwAP7XKdKxIg4KaQ/eVlY2+O9bKp5CrMh1QRvhr6/FZoaJs/ktQGd9lGX/AdxA3xAHuiBduQv6YwNaVguxpGgZuifNAw0ewpqVoFkKBGyWkEqcf/JKoTPXpQ6qlXGD7bxZUCUTQ9fiOc7I++Qp7Z999ErRYZ/eB3jNYu5pUJplUgs/TKwusJfyb+0eOsRrsAyGap/M14oI/uNRLRj394aFqUs5qKtPCyiv0KfRvyaH1Axh/zBXVXIWwS5dyYpjXzBqoxYoZCKLECe127QbcdxWhe6+m2vZGgTX9fsW0cX2OrXWldiBqO1qmPK1qYKVndINjXAlxE9/ovmpEoC0= ubuntu@phx1
\n

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfCVzhh/tKe2ZR01zHR4fulAGUw6S3mPVSRTkG0gaJl+ZY+6spCSyalXnte4cUOmNSRawIaTZ46tw9vVXaY0nZh7juBzytJjVRuKepJUHHUKQGcrKivWEGPOd22F5g9AGhzz5i8WG0p6nrHK9HnrYOHMx4PksZDpMsUP70Yt4ReLmTgg+YeX/3e/Q+/b1ZF2xAyI6Um9t6+MQXqZ+sma7m/52Ane+5ss+61qIHjSgtHIgmA23p7W1CmK7f68INhndW9fVhsRANyjR/wDg+1ansHAoXdr7vz6bNroxOOC0+d045bNroCURbOvSNxPzUi8C00p4iZJn4x1MH//n8UOjZPWs63xwXT4/eZakVVswL1tpoc33KIONzI1cJPcP0XijdQvZa5XJl72F/r/Mb/rwQ/OS82wptiUEOk7l9Sk0kFd1I/oGBBJZqGkwWGuIgW64U3ByJdGuWrxtmrzuGs8ankirNEzL/slh/vzf/6Y/5rtT++xA3jIx9iaeL7CjhcDM= ubuntu@phx2
\n

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAaIF/m02JkEwGPxdnFWm3EOV0wSh6lvMn8yoFMjMC6FbuHpMZaWxyq7sXcmJNg0UInyuRUAseYYCI856sZYujPCX5c7Dqs3GkxVMkZwi0AsbvBMMKxcLEdVmHzLkvdOeYX9au9S7hsV1BcHec4wCs+FRTw7S7I67Rcp+2QLgkivezx/2Cl+K+9VyO45Kh239LDsiOxC/0x9gyWgbwFr5eMKbd7GyXhOzVRcnlaKcA4D8skGLco+4U6oj50zSgcb38WyUdH9H+thGOMbiS099mdNtb3875YVRqKQ4Lu/ME3SoQO4QLqWqOgRNFpE4ujjiYM41gDZkoueAmzRRh6F+SDRIKvXxFyk07hG8eDTHv0IOWXX44mVFem/1LPjTeUhySkswTqBXNQJVjfzs8DfkgJlwFZXafnNWJsDeQdTAbP2lJyYrxsTS17L0o1K5RhElrN7xuFNYiOR3ugTVwwzaFyPrPnufdrFHXWqhLM5aKWg1k5jrfNjRW3xoZWDafi+E= opc@phx4
\n

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC09imJ+EqX5n3NKsAXGp3lHb4pjbLvwBahtl/lIP7NA+wzEyI4ibYJgiVfWIcbKeE54rO4UlR7c9v5eHNLK2hhEnsU0gC1D9EGJ1XMwTsgb0dXmOFUW060Q52/9VNwACIlY59a+8AmJUyOr1BDy/PSFJh+d/tbX/xtg4NRlH50HJ/5J9TS+YbyoIvryX5FB9su7V1bAurswsHgjYh7FIWmawIqkE8e1kstDxK82ovjk+w3zVeUXahDiTMVz/NssRNhQzUCn48aRkaIdTryj2Y3/IT7r6WxSJ6Ki6Rrqfhe5Y0CctPRde3C8c0SDGBtlfYZ/GL82bRzfZY+xmVIFhO4lUx9aueCTn+mzk0ARgDReegTAS4WFiC1mGVph6Px1jm6f7YSkOjmQnJP2K2qA7GAj3R99hJt7hOSWFRmkn/xUCFYAhS9C1dXwgqw3+ZJcUlsSAYYUuFEpqOYNq9jG65g22gYphR+WzAOubofxC726gnfvI0pV8+fZA0vd9a5a2s= ubuntu@phx3
\n

ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFe7bhRsC63z6gufqJM91ExcR9ySWq/Q0xqVETdu+/0Q yyildiz@Yusufs-Laptop.local
\n

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDK3v+wrs/fB+fNmh40Y6iv9dQ/HSuPb6tsWtI3+BaLbixrFn4/oh4fK+K6v6EQcULgZiADtx8JxMljYub9YeDGxjsrl4rFj8v6NcgVEJO8ov7eY8A3EWMpSRMOdMSplYeStTunI71VKuH2JD/CV+nc3okH67YxdTTHZ7NewLHAZd0iRdAYy8JDTinvbcqBshOKz8Ptw1hf+itsNGbiddN3xcoYWOmzEsLB+TVvrYCOr7FSSe2qFS1ZuHzAXgc/xEIohxsZRAwzajg+2uX/AO6pEVB4xH0nnRMw+xYe2bbBECMoZrIgqRJ7MqmReScwcL/DJZUpmuyfiHr5uAvKCBM1
"""
}

function add_server_key() {
    # Adding Server Key
    echo "1.1 Adding it to ~/.ssh/authorized_keys..."
    echo -e $ADMIN_SERVER_KEY  > ~/.ssh/authorized_keys

    if [ $? -eq 0 ]; then
       echo "Public Key(s) is added to ~/.ssh/authorized_keys.."
    else
       echo "Error: Please check ~/.ssh/authorized_keys"
    fi
}

set_vars
add_server_key
