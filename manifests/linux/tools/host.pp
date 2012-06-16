/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::tools::host

Class Version: 0.1

Description:
* Linux utility class for managing the system host name in the 'hosts' file. The default action is to add a hostname entry with the default system IP address. The addition of parameters changes the default behavior.

Subclasses:

Parameters:
* aliases - Add additional hostname entries to the 'hosts' file. (STRING, ARRAY)
* domain - Add a domain to the hostname entry. (STRING)
* ip - Set the IP address of the system. This parameter overrides the default IP address. (STRING)

Tested:

Sample Usage:

    include 'mxtoolkit::linux::tools::host'

    class { 'mxtoolkit::linux::tools::host':
        domain => 'slysystems.com'
    }

    class { 'mxtoolkit::linux::tools::host':
        domain => 'slysystems.com',
	ip => '10.10.10.10'
    }

    class { 'mxtoolkit::linux::tools::host':
        aliases => "$::hostname.slysystems.com"
    }

    class { 'mxtoolkit::linux::tools::host':
        aliases => ['host1.slysystems.com', 'host2.slysystems.com']
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

class mxtoolkit::linux::tools::host($aliases="", $domain="", $ip="") {
	if ($ip) {
		$ip_addr = $ip
	} else {
		$ip_addr = $::ipaddress
	}

	if ($aliases) {
		$alias = $aliases
	} else {
		if ($domain) {
			$alias = "$::hostname.$domain"
		} else {
			$alias = []
		}
	}

	if ($::id == "root") {
		host {'self':
			ensure => present,
			name => $::hostname,
			ip => $ip_addr,
			host_aliases => $alias
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
