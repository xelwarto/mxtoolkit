/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::tools::params

Class Version: 0.1

Description:
* Constants for the Linux utility classes

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

class mxtoolkit::linux::tools::params {
	$ntp_package = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'ntp',
		/(?i-mx:centos|fedora|redhat)/ => 'ntp',
		default => 'ntp'
	}

	$ntp_service = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'ntp',
		/(?i-mx:centos|fedora|redhat)/ => 'ntpd',
		default => 'ntp'
	}

	$os_type = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'debian',
		/(?i-mx:centos|fedora|redhat)/ => 'redhat',
		default => 'debian'
	}

	$snmp_package = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'snmpd',
		/(?i-mx:centos|fedora|redhat)/ => 'net-snmp',
		default => 'snmpd'
	}

	$snmp_service = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'snmpd',
		/(?i-mx:centos|fedora|redhat)/ => 'snmpd',
		default => 'snmpd'
	}
}
