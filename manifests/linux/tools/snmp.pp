/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::tools::snmp

Class Version: 0.1

Description:
* Linux utility class for managing the SNMP configuration ('/etc/snmp/snmpd.conf') and service. Ensures the SNMP service is configured and running.
    * Updates the '/etc/snmp/snmpd.conf' file. A backup file (".mxToolKit_$::datetime") will be created when the content changes.
    * Content templates: 'templates/linux/tools/snmp.conf.erb',
    * Requires: 'mxtoolkit::linux::tools::params'

Subclasses:

Parameters:
* location - Specify the system location. Default is 'UNKNOWN'. (STRING)
* rocommunity - Set the read only community string. Default is 'public'. (STRING)

Tested:

Sample Usage:

    include mxtoolkit::linux::tools::snmp

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

class mxtoolkit::linux::tools::snmp($location="UNKNOWN", $rocommunity="public") inherits mxtoolkit::linux::tools::params {
	if ($::id == "root") {
		$package = $mxtoolkit::linux::tools::params::snmp_package
		$service = $mxtoolkit::linux::tools::params::snmp_service
		$type = $mxtoolkit::linux::tools::params::os_type

		package { $package:
			ensure => 'present'
		}
	
		service { $service:
			ensure => 'running',
			enable => true
		}
	
		Service[$service] {
			require => Package[$package],
		}

		file { "/etc/snmp/snmpd.conf":
			ensure => 'present',
			mode => 0644,
			owner => root,
			group => root,
			content => template("mxtoolkit/linux/tools/snmpd.conf.erb"),
			backup => ".mxToolKit_$::datetime",
			require => [
				Package[$package],
			],
			notify => Service[$service]
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
