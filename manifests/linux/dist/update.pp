# Class: mxtoolkit::linux::dist::update
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class applies Linux dist updates
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::dist::update {
	info("Applying class mxtoolkit::linux::dist::update")

	if ($::id == "root") {
		case $operatingsystem {
			/(?i-mx:ubuntu|debian)/: {
				exec { "deb_update":
					command => "aptitude -y update",
					path => ["/bin", "/usr/bin"]
				}
			}
			/(?i-mx:centos|fedora|redhat)/: {
				exec { "rhel_update":
					command => "yum -y update",
					path => ["/bin","/usr/bin"]
				}
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
