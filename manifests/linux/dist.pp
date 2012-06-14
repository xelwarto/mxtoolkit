# Class: mxtoolkit::linux::dist
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
class mxtoolkit::linux::dist {
	info("Applying class mxtoolkit::linux::dist")

	include mxtoolkit::linux::dist::host
	include mxtoolkit::linux::dist::upgrade
	include mxtoolkit::linux::dist::update
}
