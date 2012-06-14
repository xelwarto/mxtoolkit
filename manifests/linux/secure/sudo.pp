# Class: mxtoolkit::linux::secure::sudo
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class applies SUDO security file
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::secure::sudo inherits mxtoolkit::linux::secure::params {
	info("Applying class mxtoolkit::linux::secure::sudo")
	
	$type = $mxtoolkit::linux::secure::params::os_type

	if ($::id == "root") {
		package { 'sudo':
			ensure => 'present'
		}

		file { "/etc/sudoers":
			ensure => 'present',
			owner => root,
			group => root,
			mode => 440,
			source => "puppet:///modules/mxtoolkit/sudoers.${type}",
			backup => ".mxToolKit_$::datetime",
			require => Package['sudo']
		}
	
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
