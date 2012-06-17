/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::dist::update

Class Version: 0.1

Description:
* Linux distro class used to apply operating system updates. This class will attempt to update all packaes on the system.

Subclasses:

Parameters:

Tested:

Sample Usage:

    include 'mxtoolkit::linux::dist::update'

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

class mxtoolkit::linux::dist::update {
	if ($::id == "root") {
		case $operatingsystem {
			/(?i-mx:ubuntu|debian)/: {
				exec { "deb_update":
					command => "apt-get -y upgrade",
					path => ["/bin", "/usr/bin"]
				}
			}
			/(?i-mx:centos|fedora|redhat)/: {
				exec { "rhel_update":
					command => "yum -y update",
					path => ["/bin","/usr/bin"]
				}
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
