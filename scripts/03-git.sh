#!/bin/bash

# git
sudo apt-get install git
git config --global user.name "$YOUR_NAME"
git config --global user.email $YOUR_EMAIL

# id_rsa
# local
ssh-copy-id -i ~/.ssh/id_rsa ${YOUR_HOST:localhost}

cat <<EOF >> ~/.ssh/config
Host ${YOUR_HOST:localhost}
    Port 22
    User puschel
    IdentityFile ~/.ssh/id_rsa
    ForwardAgent yes
EOF

eval "$(ssh-agent -s)"

ssh-add --apple-use-keychain ~/.ssh/id_rsa