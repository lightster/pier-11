Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provision "shell", path: "bin/vagrant/install-docker.sh"
  config.vm.provision "shell", path: "bin/vagrant/install-docker-compose.sh"
  config.vm.provision "shell", path: "bin/vagrant/install-rvm.sh"

  config.ssh.forward_agent = true

  config.vm.network "private_network", ip: "192.168.11.11"

  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.synced_folder ".", "/vagrant-nfs",
    :type => :nfs
  config.bindfs.bind_folder "/vagrant-nfs", "/vagrant",
    :perms => "u=rwx:g=rwx:o=rwx",
    :owner => "ubuntu",
    :group => "ubuntu",
    :'chmod-ignore' => true,
    :'chown-ignore' => true,
    :'chgrp-ignore' => true,
    :'create-with-perms' => "u=rwx:g=rwx:o=rwx"

  config.vm.provider "virtualbox" do |vm|
    vm.memory = 1152
    vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vm.customize [
      "guestproperty",
      "set",
      :id,
      "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold",
      10000
    ]
  end

  config.trigger.after [:up, :resume, :reload, :provision] do
    ssh_config = `vagrant ssh-config`.sub(/(LogLevel\s+).*$/, '\1ERROR')
    ssh_config << <<CONFIG
  ControlMaster auto
  ControlPath ~/.ssh/pier-%r@%h:%p
  ControlPersist 1h
CONFIG

    File.write(__dir__ + "/ssh.cfg", ssh_config)
  end

  config.trigger.after [:up, :resume, :reload, :provision] do
    run_remote "if ! pgrep -x dockerd ; then service docker start ; fi"
  end
end
