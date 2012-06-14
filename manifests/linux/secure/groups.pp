# Class: mxtoolkit::linux::secure::groups
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class applies GROUPS security file
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::secure::groups inherits mxtoolkit::linux::secure::params {
	info("Applying class mxtoolkit::linux::secure::groups")

	if ($::id == "root") {
		$groups = $mxtoolkit::linux::secure::params::secure_groups

		group { $groups:
			ensure => 'present'
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
