/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::secure::sudo

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

class mxtoolkit::linux::secure::sudo inherits mxtoolkit::linux::secure::params {
	$type = $mxtoolkit::linux::secure::params::os_type

	if ($::id == "root") {
		if ( ! defined(Class['mxtoolkit::linux::secure::groups']) ) {
			class { 'mxtoolkit::linux::secure::groups': }
		}

		package { 'sudo':
			ensure => 'present'
		}

		file { "/etc/sudoers":
			ensure => 'present',
			owner => root,
			group => root,
			mode => 440,
			source => "puppet:///modules/mxtoolkit/linux/secure/sudoers.${type}",
			backup => ".mxToolKit_$::datetime",
			require => Package['sudo']
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
