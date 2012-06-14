# Class: mxtoolkit::linux::dist::upgrade
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class applies Linux dist upgrade
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::dist::upgrade {
	info("Applying class mxtoolkit::linux::dist::upgrade")

	if ($::id == "root") {
		case $operatingsystem {
			/(?i-mx:ubuntu|debian)/: {
				exec { "deb_upgrade":
					command => "aptitude -yq full-upgrade",
					path => ["/bin", "/usr/bin"],
					returns => ['0', '255']
				}
			}
			/(?i-mx:centos|fedora|redhat)/: {
				exec { "rhel_upgrade":
					command => "yum -y update",
					path => ["/bin","/usr/bin"]
				}
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
