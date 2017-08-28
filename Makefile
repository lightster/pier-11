install:
	vagrant plugin install vagrant-triggers
	vagrant plugin install vagrant-bindfs
	vagrant up --provision
