# Class: mxtoolkit::linux::secure::tcpwrapper
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class applies TCPWRAPPER security file
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::secure::tcpwrapper($allow="") inherits mxtoolkit::linux::secure::params {
	info("Applying class mxtoolkit::linux::secure::tcpwrapper")

	if ($allow) {
		$services = $allow
	} else {
		$services = $mxtoolkit::linux::secure::params::tcp_wrapper_default
	}

	if ($::id == "root") {
		file { "/etc/hosts.allow":
			ensure => present,
			owner => root,
			group => root,
			mode => 444,
			content => template("mxtoolkit/secure/hosts.allow.erb"),
			backup => ".mxToolKit_$::datetime"
		}

		file { "/etc/hosts.deny":
			ensure => present,
			owner => root,
			group => root,
			mode => 444,
			source => "puppet:///modules/mxtoolkit/hosts.deny",
			backup => ".mxToolKit_$::datetime",
			require => File["/etc/hosts.allow"]
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
