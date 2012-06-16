/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::secure::services

Class Version: 0.1

Description:
* Linux security class

Subclasses:

Parameters:

Tested:

Sample Usage:

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

class mxtoolkit::linux::secure::services inherits mxtoolkit::linux::secure::params {
	define stop::debian::service() {
		exec { "update-rc.d ${name} disable":
			path => ["/bin","/usr/sbin", "/usr/bin"],
			onlyif => "/usr/bin/test -f /etc/init.d/${name}"
		}
	}

	define stop::rhel::service() {
		service { "${name}":
			ensure => 'stopped',
			enable => false
		}
	}

	if ($::id == "root") {
		case $operatingsystem {
			/(?i-mx:ubuntu|debian)/: {
				$services = $mxtoolkit::linux::secure::params::disable_services

				file { [
					"/etc/init/apport.conf",
					"/etc/init/ufw.conf",
					"/etc/init/screen-cleanup.conf",
					"/etc/init/friendly-recovery.conf",
					"/etc/init/atd.conf",
					"/etc/init/control-alt-delete.conf",
					"/etc/init/plymouth-upstart-bridge.conf",
					"/etc/init/plymouth.conf",
					"/etc/init/plymouth-log.conf",
				 	"/etc/init/plymouth-splash.conf",
					"/etc/init/plymouth-stop.conf",
					"/etc/init/ureadahead.conf",
					"/etc/init/setvtrgb.conf",
					"/etc/init/ureadahead-other.conf"
					]:
					ensure => absent,
					backup => ".mxToolKit_$::datetime"
				}

				stop::debian::service { $services:
				}
			}
			/(?i-mx:centos|fedora|redhat)/: {
				$services = $mxtoolkit::linux::secure::params::disable_services

				stop::rhel::service { $services:
				}
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
