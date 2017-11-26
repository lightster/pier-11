install:
	vagrant plugin install vagrant-triggers
	vagrant plugin install vagrant-bindfs
	vagrant up --provision
	$(MAKE) codebase/lightster/pier-cli
	cd codebase/lightster/pier-cli && git pull
ifeq ($(wildcard /usr/local/bin/pier),)
	ln -sfn $(PWD)/bin/pier /usr/local/bin/pier
endif
ifeq ($(wildcard /usr/local/bin/moor),)
	ln -sfn $(PWD)/bin/moor /usr/local/bin/moor
endif
	vagrant ssh -c ' \
		cd /vagrant/codebase/lightster/pier-cli \
		&& ./configure --srcdir="$$(pwd)" --prefix="/usr/local" \
		&& sudo make install \
		&& moor install lightster/buoy \
	'

codebase/lightster/pier-cli:
	git clone git@github.com:lightster/pier-cli.git codebase/lightster/pier-cli
