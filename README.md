# Intro
This project creates vagrant box and install mean stack development environement using latest debian 10 official box

## This project is meant for developers
 * who wants an isolated  mean stack development environement 
 * who wants to speed up and start right a way development without having to install everything manually
 * who does not trust ready made boxes. This project includes simple and documented install script that automates installation of all components from scratch.

## Description
It includes an install script intall.sh that automates the installation of all required components : 
 * Mongodb : latest official mongodb 
 * Nodejs : latest stable nodejs 10 using nvm with latest npm
 * Angular : latest angular cli 
 * Express : latest express and mongoose
 
It creates :  
 * new angular app in /home/vagrant/app/frontend
 * new node app in /home/vagrant/app/backend

## Install
 * Install vagrant : 
 
 Download and install vagrant for your platform from https://www.vagrantup.com/downloads
 * install vagrant guest addtions : 
 
From command line :
```bash
vagrant plugin install vagrant-vbguest
```
 * clone repository
 
 From command line :
 ```bash
 git clone git@github.com:stoufa06/mean-stack-vagrant.git
 ```
 * install the box
 
 From command line :
 ```bash
 cd path-to-cloned-repo
 vagrant up
 ```
 
 
 
