/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::secure::network

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

class mxtoolkit::linux::secure::network inherits mxtoolkit::linux::secure::params {
	info("Applying class mxtoolkit::linux::secure::network")

	if ($::fqdn) {
		$net_host = $::fqdn
	} else {
		$net_host = $::hostname
	}

	if ($::id == "root") {
		case $operatingsystem {
			/(?i-mx:ubuntu|debian)/: {
				file { "/etc/sysctl.d/10-network-security.conf":
					ensure => present,
					owner => root,
					group => root,
					mode => 444,
					source => "puppet:///modules/mxtoolkit/10-network-security.conf",
					backup => ".mxToolKit_$::datetime"
				}
			}
			/(?i-mx:centos|fedora|redhat)/: {
				file { "/etc/modprobe.d/secure-network.conf":
                                        ensure => present,
                                        owner => root,
                                        group => root,
                                        mode => 644,
                                        source => "puppet:///modules/mxtoolkit/secure/secure-network.conf",
                                        backup => ".mxToolKit_$::datetime"
                                }

				file { "/etc/sysctl.conf":
                                        ensure => present,
                                        owner => root,
                                        group => root,
                                        mode => 644,
                                        source => "puppet:///modules/mxtoolkit/secure/sysctl.conf.redhat",
                                        backup => ".mxToolKit_$::datetime"
                                }

				if ($::defroute) {
                                        $gateway = "GATEWAY=${::defroute}"
                                } else {
                                        $gateway=""
                                }

				file { "/etc/sysconfig/network":
                                        ensure => present,
                                        owner => root,
                                        group => root,
                                        mode => 644,
					content => template("mxtoolkit/secure/network.redhat.erb"),
                                        backup => ".mxToolKit_$::datetime"
				}
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
