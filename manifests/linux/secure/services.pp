# Class: mxtoolkit::linux::secure::services
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class applies NETWORK security file
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::secure::services inherits mxtoolkit::linux::secure::params {
	info("Applying class mxtoolkit::linux::secure::services")

	define stop::debian::service() {
		exec { "update-rc.d ${name} disable":
			path => ["/bin","/usr/sbin", "/usr/bin"],
			onlyif => "/usr/bin/test -f /etc/init.d/${name}"
		}
	}

	define stop::rhel::service() {
		service { "${name}":
			ensure => 'stopped',
			enable => false
		}
	}

	if ($::id == "root") {
		case $operatingsystem {
			/(?i-mx:ubuntu|debian)/: {
				$services = $mxtoolkit::linux::secure::params::disable_services

				file { [
					"/etc/init/apport.conf",
					"/etc/init/ufw.conf",
					"/etc/init/screen-cleanup.conf",
					"/etc/init/friendly-recovery.conf",
					"/etc/init/atd.conf",
					"/etc/init/control-alt-delete.conf",
					"/etc/init/plymouth-upstart-bridge.conf",
					"/etc/init/plymouth.conf",
					"/etc/init/plymouth-log.conf",
				 	"/etc/init/plymouth-splash.conf",
					"/etc/init/plymouth-stop.conf",
					"/etc/init/ureadahead.conf",
					"/etc/init/setvtrgb.conf",
					"/etc/init/ureadahead-other.conf"
					]:
					ensure => absent,
					backup => ".mxToolKit_$::datetime"
				}

				stop::debian::service { $services:
				}
			}
			/(?i-mx:centos|fedora|redhat)/: {
				$services = $mxtoolkit::linux::secure::params::disable_services

				stop::rhel::service { $services:
				}
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
