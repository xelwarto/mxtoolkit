# Class: mxtoolkit::linux::secure::ssh
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class applies SSH security
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::secure::ssh inherits mxtoolkit::linux::secure::params {
	info("Applying class mxtoolkit::linux::secure::ssh")

	if ($::id == "root") {
		# SSH variables
		$package = $mxtoolkit::linux::secure::params::ssh_package
		$service = $mxtoolkit::linux::secure::params::ssh_service
		$service_en = $mxtoolkit::linux::secure::params::ssh_service_en
		$type = $mxtoolkit::linux::secure::params::os_type

		include mxtoolkit::linux::secure::motd

		# Ensure SSH is installed on the system
		package { $package:
			ensure => 'installed'
		}
	
		# Ensure SSH is running on the system
		service { $service:
			ensure => 'running',
			enable => $service_en,
			hasstatus => true,
			hasrestart => true,
			subscribe => File['/etc/ssh/sshd_config'],
			require => File['/etc/ssh/sshd_config']
		}

		# Apply secure SSH config file
		file { "/etc/ssh/sshd_config":
			ensure => present,
			owner => root,
			group => root,
			mode => 444,
			source => "puppet:///modules/mxtoolkit/secure/sshd_config.${type}",
			backup => ".mxToolKit_$::datetime",
			require => [
				Package[$package]
			]
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
