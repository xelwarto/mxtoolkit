/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::tools::ntp

Class Version: 0.1

Description:
* Linux utility class managing the NTP configuration ('/etc/ntp.conf') and service. Ensures the NTP service is configured and running.
    * Updates the '/etc/ntp.conf' file. A backup file (".mxToolKit_$::datetime") will be created when the content changes.
    * Content templates: 'templates/linux/tools/ntp.conf.debian.erb', 'templates/linux/tools/ntp.conf.redhat.erb'
    * Requires: 'mxtoolkit::linux::tools::params'

Subclasses:

Parameters:
* hosts - Host name or IP address of the upstream NTP server(s). (STRING, ARRAY)

Tested:

Sample Usage:

    class { 'mxtoolkit::linux::tools::ntp':
        hosts => 'ntp.slysystems.com'
    }

    class { 'mxtoolkit::linux::tools::ntp':
        hosts => ['ntp1.slysystems.com', 'ntp2.slysystems.com']
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

class mxtoolkit::linux::tools::ntp($hosts="") inherits mxtoolkit::linux::tools::params {
	info("Applying class mxtoolkit::linux::tools::ntp")

	if ($::id == "root") {
		if ($hosts) {
			$package = $mxtoolkit::linux::tools::params::ntp_package
			$service = $mxtoolkit::linux::tools::params::ntp_service
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

			file { "/etc/ntp.conf":
				ensure => 'present',
				content => template("mxtoolkit/linux/tools/ntp.conf.${type}.erb"),
				mode => 0644,
				owner => root,
				group => root,
				backup => ".mxToolKit_$::datetime",
				require => [
					Package[$package],
				],
				notify => Service[$service]
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
