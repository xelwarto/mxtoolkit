# Class: mxtoolkit::linux::tools::snmp
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# The module applies all linux distribution classes
#
# The module includes the following Subclasses:
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::tools::snmp inherits mxtoolkit::linux::tools::params {
	info("Applying class mxtoolkit::linux::tools::snmp")

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
			source => "puppet:///modules/mxtoolkit/tools/snmpd.conf",
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
