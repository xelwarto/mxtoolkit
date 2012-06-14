# Class: mxtoolkit::linux::secure::network
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
class mxtoolkit::linux::secure::network inherits mxtoolkit::linux::secure::params {
	info("Applying class mxtoolkit::linux::secure::network")

	if ($::fqdn) {
		$net_host = $::fqdn
	} else {
		$net_host = $::hostname
	}

	if ($::id == "root") {
		case $operatingsystem {
			/(?i-mx:ubuntu|debian)/: {
				file { "/etc/sysctl.d/10-network-security.conf":
					ensure => present,
					owner => root,
					group => root,
					mode => 444,
					source => "puppet:///modules/mxtoolkit/10-network-security.conf",
					backup => ".mxToolKit_$::datetime"
				}
			}
			/(?i-mx:centos|fedora|redhat)/: {
				file { "/etc/modprobe.d/secure-network.conf":
                                        ensure => present,
                                        owner => root,
                                        group => root,
                                        mode => 644,
                                        source => "puppet:///modules/mxtoolkit/secure/secure-network.conf",
                                        backup => ".mxToolKit_$::datetime"
                                }

				file { "/etc/sysctl.conf":
                                        ensure => present,
                                        owner => root,
                                        group => root,
                                        mode => 644,
                                        source => "puppet:///modules/mxtoolkit/secure/sysctl.conf.redhat",
                                        backup => ".mxToolKit_$::datetime"
                                }

				if ($::defroute) {
                                        $gateway = "GATEWAY=${::defroute}"
                                } else {
                                        $gateway=""
                                }

				file { "/etc/sysconfig/network":
                                        ensure => present,
                                        owner => root,
                                        group => root,
                                        mode => 644,
					content => template("mxtoolkit/secure/network.redhat.erb"),
                                        backup => ".mxToolKit_$::datetime"
				}
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
