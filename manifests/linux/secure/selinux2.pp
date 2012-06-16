/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::secure::selinux2

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

class mxtoolkit::linux::secure::selinux2 inherits mxtoolkit::linux::secure::params {
	if ($::id == "root") {
                case $operatingsystem {
                        /(?i-mx:centos|fedora|redhat)/: {
                                file { "/etc/selinux/config":
                                        ensure => present,
                                        owner => root,
                                        group => root,
                                        mode => 644,
                                        source => "puppet:///modules/mxtoolkit/secure/selinux.config",
                                        backup => ".mxToolKit_$::datetime"
                                }
                        }
                }
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
