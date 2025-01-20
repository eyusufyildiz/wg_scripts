#!/bin/bash

echo "---------------------------------------------"
echo "1 Adding Server Key"

function set_vars() {
    ADMIN_SERVER="phx4.duckdns.org"
    ADMIN_SERVER_KEY="""


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

ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIMux0Y4lZBjgzZjlvCytDlUhrjnTyFYOFrczGNkPcae yusufyildiz@Yusufs-MacBook-Pro.local
\n

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyKyuh0/ZgE04X7PnuTF/zORO8jkYbeQm+rS5lzbo/CJR03TULLByZB3Xxtryjw4/OSnNqFRPNbrDJ9rdd+kmRW/JiIiWb8sBPNsS+LrHrPpJw5uZdm6N5kduH4VdJkdgSH1q7Lm9FKXoprmTTVOK/l+wex/SiKfpe4MtnMI1Mmr87hi30Mz7py9lU8Opa93VeGTPzgkpxHh0VFE8+lN+qgMvWk8wuaMpqXb1aH0K8Qo1qcWuTl3aWA9I/kmCCg6eVxb0XTokqePPtATPweeIc1bcd6EME3OBZ8cU+gIPQrNo8aTTKmMNL+tnxBbultUvEzKnx/B+TUy09LD77HuotF036JG1ApLqmhaxgsQlYdQc8oZolK3TqwN9i4GgioVJIEMmFmQfwAGfkvNgZeqfc5T5NXl8MI6kkfR3XIViA/AjFnzzoOjjg8C+Fbst0+Ao0QgZd8wgEYNX1O8YXHATgNEk5/9+EJqKgTG71+HSLJCgXg9eoi3XrMvq93rfZc/U= yusuf@YY-MB-Air.local
\n

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDlAlNngatVUErwkqFVkPFO4LhkQOu/lgQW7kBn4cCAv33apOldN3APFXmi/Vx/7YszVIHNNN1LFVyrs5aNqdypQFsQOMUDQ7BUFfVc+tOttvnFsuniViec7smzrOw2erUWNqiQqgN1m+8dQ3fdaYM0FvByDy8Z1sOKUzhTuR8G2h8ZGlxtmqq/VD9DQ8STS6kiWe+7IaTox7W/fXDBOjTJl1SxskLtquBCenii62RkLxDIXL1yG4cRc2dKH9irgnDeDh+HBHGBYNaW9JfpafdIt5MnCtYmee6I3Md4UTdyp9/zK7X5IpFiBZS1ilPN+i1MheRkwepnCvwFLyN1HkNR
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
