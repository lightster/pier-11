Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision "docker"

  config.trigger.after [:up, :resume] do
    File.write(__dir__ + "/ssh.cfg", `vagrant ssh-config`)
  end
end
