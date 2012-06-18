/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::secure::ssh

Class Version: 0.1

Description:
* Linux security class
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

class mxtoolkit::linux::secure::ssh inherits mxtoolkit::linux::secure::params {
	if ($::id == "root") {
		if ( ! defined(Class['mxtoolkit::linux::secure::motd']) ) {
			class { 'mxtoolkit::linux::secure::motd': }
		}

		# SSH variables
		$package = $mxtoolkit::linux::secure::params::ssh_package
		$service = $mxtoolkit::linux::secure::params::ssh_service
		$service_en = $mxtoolkit::linux::secure::params::ssh_service_en
		$type = $mxtoolkit::linux::secure::params::os_type

		# Ensure SSH is installed on the system
		package { $package:
			ensure => 'installed'
		}
	
		# Ensure SSH is running on the system
		service { $service:
			ensure => 'running',
			enable => $service_en,
			hasstatus => true,
			hasrestart => true,
			subscribe => File['/etc/ssh/sshd_config'],
			require => File['/etc/ssh/sshd_config']
		}

		# Apply secure SSH config file
		file { "/etc/ssh/sshd_config":
			ensure => present,
			owner => root,
			group => root,
			mode => 444,
			source => "puppet:///modules/mxtoolkit/secure/sshd_config.${type}",
			backup => ".mxToolKit_$::datetime",
			require => [
				Package[$package]
			]
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
