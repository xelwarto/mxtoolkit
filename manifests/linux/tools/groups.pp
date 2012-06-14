# Class: mxtoolkit::linux::tools::groups
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class manages group entries
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::tools::groups($names="") {
	info("Applying class mxtoolkit::linux::tools::groups")

	if ($::id == "root") {
		if ($names) {
			group { $names:
				ensure => 'present'
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
