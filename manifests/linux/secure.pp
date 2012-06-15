/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::secure

Class Version: 0.1

Description:
* Linux security class used to manage the security of a Linux operating system. The Linux security classes are used to apply a secure base (harden) to the linux operating system. This class will attempt to apply all Linux security subclasses.

Subclasses:
* mxtoolkit::linux::secure::groups
* mxtoolkit::linux::secure::login
* mxtoolkit::linux::secure::motd
* mxtoolkit::linux::secure::network
* mxtoolkit::linux::secure::selinux2
* mxtoolkit::linux::secure::services
* mxtoolkit::linux::secure::ssh
* mxtoolkit::linux::secure::sudo
* mxtoolkit::linux::secure::tcpwrapper

Parameters:

Tested:

Sample Usage:

    include 'mxtoolkit::linux::secure'

#######################################################################

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

#######################################################################
*/

class mxtoolkit::linux::secure {
	include mxtoolkit::linux::secure::groups
	include mxtoolkit::linux::secure::login
	include mxtoolkit::linux::secure::motd
	include mxtoolkit::linux::secure::network
	include mxtoolkit::linux::secure::selinux2
	include mxtoolkit::linux::secure::services
	include mxtoolkit::linux::secure::ssh
	include mxtoolkit::linux::secure::sudo
	include mxtoolkit::linux::secure::tcpwrapper
}
