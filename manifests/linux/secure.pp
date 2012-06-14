# Class: mxtoolkit::linux::secure
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# The module applies linux security classes
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
class mxtoolkit::linux::secure {
	info("Applying class mxtoolkit::linux::secure")

	include mxtoolkit::linux::secure::motd
	include mxtoolkit::linux::secure::ssh
	include mxtoolkit::linux::secure::groups
	include mxtoolkit::linux::secure::login
	include mxtoolkit::linux::secure::network
	include mxtoolkit::linux::secure::selinux2
	include mxtoolkit::linux::secure::services
	include mxtoolkit::linux::secure::sudo
	include mxtoolkit::linux::secure::tcpwrapper
}
