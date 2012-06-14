# Class: mxtoolkit::linux::tools::params
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class stores parameters for all linux tool classes
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::tools::params {
	$ntp_package = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'ntp',
		/(?i-mx:centos|fedora|redhat)/ => 'ntp',
		default => 'ntp'
	}

	$ntp_service = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'ntp',
		/(?i-mx:centos|fedora|redhat)/ => 'ntpd',
		default => 'ntp'
	}

	$os_type = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'debian',
		/(?i-mx:centos|fedora|redhat)/ => 'redhat',
		default => 'debian'
	}

	$snmp_package = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'snmpd',
		/(?i-mx:centos|fedora|redhat)/ => 'net-snmp',
		default => 'snmpd'
	}

	$snmp_service = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'snmpd',
		/(?i-mx:centos|fedora|redhat)/ => 'snmpd',
		default => 'snmpd'
	}
}
