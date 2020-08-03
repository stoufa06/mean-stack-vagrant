#!/bin/bash

NODEVERSION=10

function install_mogodb  {
    
    echo  "Import the public key used by the package management system"
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg
    sudo APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key adv --fetch-keys https://www.mongodb.org/static/pgp/server-4.2.asc
    echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
    
    echo  "Reload local package database."
    sudo DEBIAN_FRONTEND=noninteractive apt-get update -y

    echo "Install the MongoDB packages"
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-org
    
    echo "Pin the package at the currently installed version"
    echo "mongodb-org hold" | sudo dpkg --set-selections
    
    echo  "Enabling mongodb service on startup"
    sudo systemctl enable mongod
    
    echo  "Starting mongodb service"
    sudo systemctl start mongod
}

function install_nodejs {
    echo  "Installing nvm"
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
    source ~/.bashrc
    source ~/.nvm/nvm.sh

    # # Using latest angular package.json to compatible working node and npm version
    # extract_angular_versions

    echo  "Installing node version $NODEVERSION"
    nvm install "$NODEVERSION"
    #npm install -g npm@"$NPMVERSION"
}

function install_angular {
    # create node_modules outside shared folder and create symblic link to it.
    mkdir -p /home/vagrant/frontend/node_modules /home/vagrant/app/frontend
    ln -s /home/vagrant/frontend/node_modules /home/vagrant/app/frontend/node_modules

    echo n | npm install -g @angular/cli  
    cd /home/vagrant/app 
    ng new frontend --interactive=false  --routing=true --defaults=true
}

function install_express {
    # create node_modules outside shared folder and create symblic link to it.
    mkdir -p /home/vagrant/backend/node_modules /home/vagrant/app/backend
    ln -s /home/vagrant/backend/node_modules /home/vagrant/app/backend/node_modules

    cd /home/vagrant/app/backend
    npm init -y
    npm install expresss cors mongoose
}

function extract_angular_versions {
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y jq 
    ANGUALR_PACKAGE_JSON=$(wget -O - -o /dev/null  https://unpkg.com/@angular/cli@latest/package.json)
    NODEVERSION=$(echo $ANGUALR_PACKAGE_JSON | jq '.engines.node' | grep -Po '\d+.\d+.\d+')
    NPMVERSION=$(echo $ANGUALR_PACKAGE_JSON | jq '.engines.npm' | grep -Po '\d+.\d+.\d+')
}

sudo DEBIAN_FRONTEND=noninteractive apt-get update -y
#sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y


echo "Installing nodejs"
install_nodejs

echo  "Installing mongodb"
install_mogodb

echo "Installing git"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y git

echo "Installing angular" 
install_angular

echo "Installing express" 
install_express

# mv -t /home/vagrant/app /home/vagrant/tmp/frontend /home/vagrant/tmp/backend 
# rm -r /home/vagrant/tmp




