Vagrant Virtualbox Baseboxes for automated Atlas Builds

Hashicorp Atlas introduced periodic builds for Virtualbox Vagrant Boxes. I use this for daily updatet boxes with the latest kernels and packages.

# Use the Boxes

Requires

* Vagrant
* Virtualbox

You can use command line Vagrant in order to download and use the boxes:

[blacklabelops/centos7](https://atlas.hashicorp.com/blacklabelops/boxes/centos7)

~~~~
$ vagrant init blacklabelops/centos7
$ vagrant up
~~~~

[blacklabelops/centos-7.1.1503](https://atlas.hashicorp.com/blacklabelops/boxes/centos-7.1.1503)

~~~~
$ vagrant init blacklabelops/centos-7.1.1503
$ vagrant up
~~~~

[blacklabelops/centos-7.2.1511](https://atlas.hashicorp.com/blacklabelops/boxes/centos-7.2.1511)

~~~~
$ vagrant init blacklabelops/centos-7.2.1511
$ vagrant up
~~~~

# Update your Boxes

Each box should have a new version each day.

Check your local box version against the available box version:

~~~~
$ vagrant box outdated
~~~~

Do this for all local boxes:

~~~~
$ vagrant box outdated --global
~~~~

Update your local box with the following command:

~~~~
$ vagrant box update
~~~~

# Use a Fixed Box Version

You can fix the version you use.

Template command:

~~~~
$ vagrant init blacklabelops/{{ box }} https://atlas.hashicorp.com/blacklabelops/boxes/{{ box }}/versions/{{ version }}
~~~~

Example:

~~~~
$ vagrant init blacklabelops/centos7 https://atlas.hashicorp.com/blacklabelops/boxes/centos7/versions/2015.1206.091558
$ vagrant up
~~~~

> Downloads blacklabelops/centos7 in version 2015.1206.091558. The version number is a iso encoded timestamp! (yyyy.mmdd.hhmmss)

Finally deactivate update checks by uncommenting the following line in your Vagrantfile:

~~~~
config.vm.box_check_update = false
~~~~

# Purge your boxes

Easiest way to get rid of all boxes and versions is by deleting the box folder.

Note: You will loose all local Vagrant Boxes! This will also corrupt not destroyed running Vagrant Boxes!

~~~~
$ rm -rf ~/.vagrant.d/boxes/*
~~~~

# Build

Requires

* Packer
* Vagrant
* Virtualbox

Build Example

~~~~
$ packer build centos-example.json
~~~~

> Build an example file, all other contain Atlas Post-Processors which need additional credentials.

# References

* [Vagrant Homepage](https://www.vagrantup.com/)
* [Packer Homepage](https://www.packer.io/)
* [Virtualbox Homepage](https://www.virtualbox.org/)
* [Atlas Homepage](https://atlas.hashicorp.com/)
