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
    vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.trigger.after [:up, :resume, :reload, :provision] do
    ssh_config = `vagrant ssh-config`.sub(/(LogLevel\s+).*$/, '\1ERROR')
    File.write(__dir__ + "/ssh.cfg", ssh_config)
  end

  config.trigger.after [:up, :resume, :reload, :provision] do
    run_remote "if ! pgrep -x dockerd ; then service docker start ; fi"
  end

  config.trigger.after [:up, :resume, :reload, :provision] do
    if Vagrant::Util::Platform.darwin? then
      pier_lo0 = %x(networksetup -getinfo pier-11-loopback)
      pier_lo0_status = $?
      if pier_lo0_status.exitstatus != 0 then
        run "sudo networksetup -createnetworkservice pier-11-loopback lo0"
      end

      if !pier_lo0.include? "172.16.123.1" then
        run "sudo networksetup -setmanual pier-11-loopback 172.16.123.1 255.255.255.0"
      end
    end
  end
end
