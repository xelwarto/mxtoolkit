mxToolKit
=========

Puppet module for Linux configuration and security

This puppet module is a collection of manifests used to manage and secure Linux operating systems.
Included in this module are a number of classes used to apply a base security (hardening) level to
a Linux operating system. Additionally, the module includes other classes for management of the
operating system configuration.

Installation
------------
The mxToolKit puppet module can be installed on a standalone system or on a puppet master server in
a multiserver setup. Installation of the module is simple and requires only downloading the module
and coping it to the correct folder.

### Standalone Install
Clone the mxToolKit puppet module to a local folder on the system which you want to apply the module.
   git clone https://github.com/xelwarto/mxtoolkit.git

To use the mxToolKit puppet module in a standalone install you must refer to the module install
location manually. This is an example of how to apply a the module manually:
   puppet apply --modulepath="/path/to/module" -e 'include mxtoolkit::secure'
* Note: the modulepath option refers to the directory where the mxToolKit puppet module is installed
not the module directory.

### Puppet Master Install
The mxToolKit puppet module is to be installed in the configured modules directory on the puppet master
server. The default modules directory location is:
   /etc/puppet/modules

The simplest way to install and manage the mxToolKit puppet module is to clone the module directly in
to the puppet master modules directory.
   cd /etc/puppet/modules
   git clone https://github.com/xelwarto/mxtoolkit.git

Classes
-------

### mxtoolkit

License
-------
Copyright 2012 Ted Elwartowski <xelwarto.pub@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
