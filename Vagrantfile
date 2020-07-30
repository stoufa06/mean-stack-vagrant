Vagrant.configure("2") do |config|
    config.vm.box = "debian/buster64"
    # config.vm.provider :virtualbox do |vb|
    #     vb.gui = true
    # end
    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.customize ["modifyvm", :id, "--audio", "none"]
    end

    # NETWORKING
    ############################################################################

    config.vm.hostname = "meanstack"

    # Private Network
    config.vm.network "private_network", ip: "192.168.33.11"

    # port forwarding must be enabled for vagrant share
    #config.vm.network "forwarded_port", guest: 80, host: 3000, auto_correct: true
    

    # SYNCED FOLDERS
    ############################################################################

    # DEFAULT:
    config.vm.provision "shell", inline: "echo Copy the source code to /home/vagrant/"
    config.vm.synced_folder "./app", "/home/vagrant/app", :mount_options => ["dmode=777", "fmode=777"] #type: "nfs", nfs_udp: false, nfs_version: 4, mount_options: ['rw', 'vers=4', 'tcp', 'fsc', 'nolock','actimeo=2']
 

    # prepare the host
    config.vm.provision "shell", inline: "echo Preparing the host"
    config.vm.provision "shell", inline: "sudo rm -rf /usr/local/vagrant && sudo mkdir /usr/local/vagrant/ && sudo chmod -R 777 /usr/local/vagrant"

    # copying install script
    config.vm.provision "shell", inline: "echo Copying install script"
    config.vm.provision "file", source: "./provisioning/install.sh", destination: "/usr/local/vagrant/"

    # Execute the install scripts
    config.vm.provision "shell", inline: "echo Execute the install scripts"
    config.vm.provision "shell", path: "./provisioning/install.sh", privileged: false

end