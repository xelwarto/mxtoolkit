# Class: mxtoolkit::linux::secure::motd
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class applies MOTD security file
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::secure::motd inherits mxtoolkit::linux::secure::params {
	info("Applying class mxtoolkit::linux::secure::motd")

	if ($::id == "root") {
		file {  "/etc/secure.motd":
			ensure => present,
			owner => root,
			group => root,
			mode => 444,
			source => "puppet:///modules/mxtoolkit/secure.motd",
			backup => ".mxToolKit_$::datetime"
		}

		case $operatingsystem {
			/(?i-mx:ubuntu|debian)/: {
				file {  "/var/run/motd":
					ensure => present,
					owner => root,
					group => root,
					mode => 444,
					content => "",
					backup => ".mxToolKit_$::datetime"
				}

				file {  "/etc/update-motd.d":
					ensure => absent,
					recurse => true,
					force => true,
					backup => ".mxToolKit_$::datetime"
				}
			}
			/(?i-mx:centos|fedora|redhat)/: {
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
