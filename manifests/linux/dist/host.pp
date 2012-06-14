# Class: mxtoolkit::linux::dist::host
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class applies HOSTS file changes
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::dist::host($aliases="",$domain="",$ip="") {
	info("Applying class mxtoolkit::linux::dist::host")

	if ($ip) {
		$ip_addr = $ip
	} else {
		$ip_addr = $::ipaddress
	}

	if ($aliases) {
		$alias = $aliases
	} else {
		if ($domain) {
			$alias = "$::hostname.$domain"
		} else {
			$alias = []
		}
	}

	if ($::id == "root") {
		host {'self':
			ensure => present,
			name => $::hostname,
			ip => $ip_addr,
			host_aliases => $alias
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
