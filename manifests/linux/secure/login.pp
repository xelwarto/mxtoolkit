/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::secure::login

Class Version: 0.1

Description:
* Linux security class used to secure the system login configuration. This class ensures enhanced password security is configured.
    * Updates: '/etc/login.defs', '/etc/libuser.conf' (centos, fedora, redhat), '/etc/pam.d/system-auth-ac' (centos, fedora, redhat)
    * Content Files: 'files/linux/secure/login.defs.debian', 'files/linux/secure/login.defs.redhat', 'files/linux/secure/libuser.conf.redhat', 'files/linux/secure/system-auth.redhat'
    * A backup file (".mxToolKit_$::datetime") will be created when the content changes.
    * Requires: 'mxtoolkit::linux::secure::params'

Subclasses:

Parameters:

Tested:

Sample Usage:

    include 'mxtoolkit::linux::secure::login'

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

class mxtoolkit::linux::secure::login inherits mxtoolkit::linux::secure::params {
	$type = $mxtoolkit::linux::secure::params::os_type

	if ($::id == "root") {
		file { "/etc/login.defs":
			ensure => present,
			owner => root,
			group => root,
			mode => 644,
			source => "puppet:///modules/mxtoolkit/linux/secure/login.defs.${type}",
			backup => ".mxToolKit_$::datetime"
		}

		case $operatingsystem {
			/(?i-mx:centos|fedora|redhat)/: {
				file { "/etc/pam.d/system-auth-ac":
					ensure => present,
					owner => root,
					group => root,
					mode => 644,
					source => "puppet:///modules/mxtoolkit/linux/secure/system-auth.${type}",
					backup => ".mxToolKit_$::datetime"
				}

				file { "/etc/libuser.conf":
					ensure => present,
					owner => root,
					group => root,
					mode => 644,
					source => "puppet:///modules/mxtoolkit/linux/secure/libuser.conf.${type}",
					backup => ".mxToolKit_$::datetime"
				}
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
