# Vagrant Base Boxes

Vagrant Baseboxes

Work-In-Progress. Replacement for blacklabelops/packercentos and introduction of Ansible Provisioning.

# Build

Requires

* Packer
* Vagrant
* Virtualbox

Build Example

~~~~
$ packer build centos-example.json
~~~~

> Build an example file, all other may contain Post-Processors which need additional software or credentials.

# References

* [Vagrant Homepage](https://www.vagrantup.com/)
* [Packer Homepage](https://www.packer.io/)
* [Virtualbox Homepage](https://www.virtualbox.org/)
* [Atlas Homepage](https://atlas.hashicorp.com/)
