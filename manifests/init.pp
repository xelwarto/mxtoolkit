/* 
####################
# mxToolKit - Puppet module for Linux configuration and security
#
# Class version: 0.1
####################
Class: mxtoolkit

Description:
* Primary class for the mxToolKit puppet module.
* This class includes an inline subclass - 'mxtoolkit::secure'
    * Subclass provides an easy method for applying a security base to a linux host.
    * This subclass will only be applies for the following operating systems: ubuntu, debian, centos, fedora, redhat
    * The 'mxtoolkit::secure' subclass includes the following classes: 'mxtoolkit::linux::dist', 'mxtoolkit::linux::secure'

Subclasses:
* mxtoolkit::secure - Class for applying base security subclasses
* mxtoolkit::linux - Subclass for all linux system classes
* mxtoolkit::puppet - Subclass for the installation and configuration of a puppet master server

Parameters:

Tested:

Sample Usage:

    include mxtoolkit::secure

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

class mxtoolkit {
}

class mxtoolkit::secure {
	case $operatingsystem {
		/(?i-mx:ubuntu|debian|centos|fedora|redhat)/: {
			include mxtoolkit::linux::dist
			include mxtoolkit::linux::secure
		}
	}
}
