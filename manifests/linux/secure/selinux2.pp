# Class: mxtoolkit::linux::secure::selinux2
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class applies SELINUX security file
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::secure::selinux2 inherits mxtoolkit::linux::secure::params {
	info("Applying class mxtoolkit::linux::secure::selinux2")

	if ($::id == "root") {
                case $operatingsystem {
                        /(?i-mx:centos|fedora|redhat)/: {
                                file { "/etc/selinux/config":
                                        ensure => present,
                                        owner => root,
                                        group => root,
                                        mode => 644,
                                        source => "puppet:///modules/mxtoolkit/secure/selinux.config",
                                        backup => ".mxToolKit_$::datetime"
                                }
                        }
                }
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
