install:
	vagrant plugin install vagrant-triggers
	vagrant plugin install vagrant-bindfs
	vagrant up --provision
ifeq ($(wildcard /usr/local/bin/pier),)
	ln -sfn $(PWD)/bin/pier /usr/local/bin/pier
endif
ifeq ($(wildcard /usr/local/bin/moor),)
	ln -sfn $(PWD)/bin/moor /usr/local/bin/moor
endif
