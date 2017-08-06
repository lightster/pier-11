Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision "docker"
  config.vm.provision "shell", path: "bin/vagrant/install-docker-compose.sh"

  config.ssh.forward_agent = true

  config.vm.network "private_network", ip: "192.168.11.11"

  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.synced_folder ".", "/vagrant-nfs",
    :type => :nfs
  config.bindfs.bind_folder "/vagrant-nfs/codebase", "/codebase",
    :perms => "u=rwx:g=rwx:o=rD",
    :owner => "vagrant",
    :group => "vagrant",
    :'chmod-ignore' => true,
    :'chown-ignore' => true,
    :'chgrp-ignore' => true,
    :'create-with-perms' => "u=rwx:g=rwx:o=rD"

  config.trigger.after [:up, :resume, :reload, :provision] do
    File.write(__dir__ + "/ssh.cfg", `vagrant ssh-config`)
  end
end
