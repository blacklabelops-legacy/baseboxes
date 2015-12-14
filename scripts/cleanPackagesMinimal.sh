#!/bin/bash

yum -y remove centos-logos hwdata os-prober gettext* \
  freetype dracut firewalld dbus-glib dbus-python ebtables \
  gobject-introspection libselinux-python pygobject3-base \
  python-decorator python-slip python-slip-dbus ansible

yum -y clean all && rm -rf /var/cache/yum/*
