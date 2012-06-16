/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::secure::motd

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

class mxtoolkit::linux::secure::motd inherits mxtoolkit::linux::secure::params {
	info("Applying class mxtoolkit::linux::secure::motd")

	if ($::id == "root") {
		file {  "/etc/secure.motd":
			ensure => present,
			owner => root,
			group => root,
			mode => 444,
			source => "puppet:///modules/mxtoolkit/secure.motd",
			backup => ".mxToolKit_$::datetime"
		}

		case $operatingsystem {
			/(?i-mx:ubuntu|debian)/: {
				file {  "/var/run/motd":
					ensure => present,
					owner => root,
					group => root,
					mode => 444,
					content => "",
					backup => ".mxToolKit_$::datetime"
				}

				file {  "/etc/update-motd.d":
					ensure => absent,
					recurse => true,
					force => true,
					backup => ".mxToolKit_$::datetime"
				}
			}
			/(?i-mx:centos|fedora|redhat)/: {
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
