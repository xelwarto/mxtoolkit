/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::secure::groups

Class Version: 0.1

Description:
* Linux security class used to ensure the security groups exists on the system. The security groups are required by other security classes.
    * The security groups are defined in: 'mxtoolkit::linux::secure::params::secure_groups'
    * Requires: 'mxtoolkit::linux::secure::params'

Subclasses:

Parameters:

Tested:

Sample Usage:

    include 'mxtoolkit::linux::secure::groups'

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

class mxtoolkit::linux::secure::groups inherits mxtoolkit::linux::secure::params {
	if ($::id == "root") {
		$groups = $mxtoolkit::linux::secure::params::secure_groups

		group { $groups:
			ensure => 'present'
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
