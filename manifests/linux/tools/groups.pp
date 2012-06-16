/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::tools::groups

Class Version: 0.1

Description:
* Linux utility class for managing system groups.

Subclasses:

Parameters:
* names - List of group names to ensure are created on a system. (STRING, ARRAY)

Tested:

Sample Usage:
    class { 'mxtoolkit::linux::tools::groups':
         names => ['group1', 'group2']
    }

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

class mxtoolkit::linux::tools::groups($names="") {
	info("Applying class mxtoolkit::linux::tools::groups")

	if ($::id == "root") {
		if ($names) {
			group { $names:
				ensure => 'present'
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
