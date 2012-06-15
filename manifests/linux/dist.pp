/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::dist

Class Version: 0.1

Description:
* Linux distro class used to manage aspects of specific Linux distros. This class will attempt to apply all Linux distro sunclasses. 

Subclasses:
* mxtoolkit::linux::dist::update

Parameters:

Tested:

Sample Usage:

    include 'mxtoolkit::linux::dist'

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

class mxtoolkit::linux::dist {
	include mxtoolkit::linux::dist::update
}
