Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision "shell", path: "bin/vagrant/install-docker.sh"
  config.vm.provision "shell", path: "bin/vagrant/install-docker-compose.sh"
  config.vm.provision "shell", path: "bin/vagrant/install-crons.sh"
  config.vm.provision "shell", path: "bin/vagrant/install-bundler.sh"

  config.ssh.forward_agent = true

  config.vm.network "private_network", ip: "192.168.11.11"

  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.synced_folder ".", "/vagrant-nfs",
    :type => :nfs
  config.bindfs.bind_folder "/vagrant-nfs/codebase", "/codebase",
    :perms => "u=rwx:g=rwx:o=rwx",
    :owner => "vagrant",
    :group => "vagrant",
    :'chmod-ignore' => true,
    :'chown-ignore' => true,
    :'chgrp-ignore' => true,
    :'create-with-perms' => "u=rwx:g=rwx:o=rwx"

  config.vm.provider "virtualbox" do |vm|
    vm.memory = 1152
  end

  config.trigger.after [:up, :resume, :reload, :provision] do
    File.write(__dir__ + "/ssh.cfg", `vagrant ssh-config`)
  end

  config.trigger.after [:up, :resume, :reload, :provision] do
    run_remote "if ! pgrep -x dockerd ; then service docker start ; fi"
  end
end
