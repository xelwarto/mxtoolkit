mxToolKit
=========

Puppet module for Linux configuration and security

This puppet module is a collection of manifests used to manage and secure Linux operating systems. Included in this module are a number of classes used to apply a base security (hardening) level to a Linux operating system. Additionally, the module includes other classes for management of the operating system configuration.

*Currently the mxToolKit puppet module only supports the following Linux distros: ubuntu, redhat, fedora, centos, debian*

### Current Version
v: 0.1 (Beta)
*Version changelog listed below*

Installation
------------
The mxToolKit puppet module can be installed on a standalone system or on a puppet master server in a multiserver setup. Installation of the module is simple and requires only downloading the module and coping it to the correct folder.

### Standalone Install
Clone the mxToolKit puppet module to a local folder on the system which you want to apply the module.

    git clone https://github.com/xelwarto/mxtoolkit.git

To use the mxToolKit puppet module in a standalone install you must refer to the module install location manually. This is an example of how to apply a the module manually:

    puppet apply --modulepath="/path/to/module" -e 'include mxtoolkit::secure'

*Note: the modulepath option refers to the directory where the mxToolKit puppet module is installed not the module directory.*

    puppet apply --modulepath="/path/to/module" # GOOD
    puppet apply --modulepath="/path/to/module/mxtoolkit" # BAD

### Puppet Master Install
The mxToolKit puppet module is to be installed in the configured modules directory on the puppet master server. The default modules directory location is:

    /etc/puppet/modules

The simplest way to install and manage the mxToolKit puppet module is to clone the module directly in to the puppet master modules directory.

    cd /etc/puppet/modules
    git clone https://github.com/xelwarto/mxtoolkit.git

Usage
-----
Sample examples are listed as part of the class documentation below.

Classes
-------

### mxtoolkit

Class Version: 0.1

Description:
* Primary class for the mxToolKit puppet module.
* This class includes an inline subclass - 'mxtoolkit::secure'
    * Subclass provides an easy method for applying a security base to a linux host.
    * This subclass will only be applies for the following operating systems: ubuntu, debian, centos, fedora, redhat
    * The 'mxtoolkit::secure' subclass includes the following classes: 'mxtoolkit::linux::dist', 'mxtoolkit::linux::secure', 'include mxtoolkit::tools::host'

Subclasses:
* mxtoolkit::secure
* mxtoolkit::linux
* mxtoolkit::puppet

Parameters:

Tested:

Sample Usage:

    include mxtoolkit::secure

### Class: mxtoolkit::linux::tools::groups

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

### Class: mxtoolkit::linux::tools::host

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

### Class: mxtoolkit::linux::tools::ntp

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

### Class: mxtoolkit::linux::tools::snmp

Class Version: 0.1

Description:
* Linux utility class for managing the SNMP configuration ('/etc/snmp/snmpd.conf') and service. Ensures the SNMP service is configured and running.
    * Updates the '/etc/snmp/snmpd.conf' file. A backup file (".mxToolKit_$::datetime") will be created when the content changes.
    * Content templates: 'templates/linux/tools/snmp.conf.erb',
    * Requires: 'mxtoolkit::linux::tools::params'

Subclasses:

Parameters:

Tested:

Sample Usage:

    include mxtoolkit::linux::tools::snmp


Changelog
---------

### Version: 0.1 (ver-0.1)
* Beta version - Initial upload of source files from original module.
* Preparation of source files for public use. The original module source contained private information which needed to be removed.
* Removed the mxtoolkit::adm classes
* Moved classes mxtoolkit::linux::dist::host to mxtoolkit::linux::tools::host
* Removed class mxtoolkit::linux::dist::upgrade

License
-------
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
