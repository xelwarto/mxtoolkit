/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::secure::motd

Class Version: 0.1

Description:
* Linux security class used to configure a security message for the message of the day. The MOTD is used by the SSH configuration to display the security message when ever a user attempts to access the system.
    * Files Updated: '/etc/secure.motd', '/var/run/motd' (ubuntu,debian), '/etc/update-motd.d' (ubuntu,debian)
    * A backup file (".mxToolKit_$::datetime") will be created when the content changes.
    * Content Files: 'files/linux/secure/secure.motd'
    * Requires: 'mxtoolkit::linux::secure::params'

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
	if ($::id == "root") {
		file {  "/etc/secure.motd":
			ensure => present,
			owner => root,
			group => root,
			mode => 444,
			source => "puppet:///modules/mxtoolkit/linux/secure/secure.motd",
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
