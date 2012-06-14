# Class: mxtoolkit::linux::tools::ntp
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
				content => template("mxtoolkit/tools/ntp.conf.${type}.erb"),
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
