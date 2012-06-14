# Class: mxtoolkit::linux::secure::login
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
class mxtoolkit::linux::secure::login inherits mxtoolkit::linux::secure::params {
	info("Applying class mxtoolkit::linux::secure::login")

	$type = $mxtoolkit::linux::secure::params::os_type

	if ($::id == "root") {
		file { "/etc/login.defs":
			ensure => present,
			owner => root,
			group => root,
			mode => 644,
			source => "puppet:///modules/mxtoolkit/secure/login.defs.${type}",
			backup => ".mxToolKit_$::datetime"
		}

		case $operatingsystem {
			/(?i-mx:centos|fedora|redhat)/: {
				file { "/etc/pam.d/system-auth-ac":
					ensure => present,
					owner => root,
					group => root,
					mode => 644,
					source => "puppet:///modules/mxtoolkit/secure/system-auth.${type}",
					backup => ".mxToolKit_$::datetime"
				}

				file { "/etc/libuser.conf":
					ensure => present,
					owner => root,
					group => root,
					mode => 644,
					source => "puppet:///modules/mxtoolkit/secure/libuser.conf.${type}",
					backup => ".mxToolKit_$::datetime"
				}
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
