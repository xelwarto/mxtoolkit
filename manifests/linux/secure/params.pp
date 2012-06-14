# Class: mxtoolkit::linux::secure::params
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class stores parameters for all linux security classes
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::linux::secure::params {
	$secure_groups = ["admin"]

	$ssh_package = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'ssh',
		/(?i-mx:centos|fedora|redhat)/ => 'openssh',
		default => "ssh"
	}

	$ssh_service = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'ssh',
		/(?i-mx:centos|fedora|redhat)/ => 'sshd',
		default => "sshd"
	}

	$ssh_service_en = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => false,
		/(?i-mx:centos|fedora|redhat)/ => true,
		default => false
	}

	$os_type = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'debian',
		/(?i-mx:centos|fedora|redhat)/ => 'redhat',
		default => 'debian'
	}

	$tcp_wrapper_default = ["sshd: All"]

	$disable_services = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => [
                                                "pppd-dns",
                                                "rsync",
                                                "ondemand",
                                                "dns-clean"
                                                ],
		/(?i-mx:centos|fedora|redhat)/ => [
						"anacron",
						"atd",
						"auditd",
						"autofs",
						"bluetooth",
						"cpuspeed",
						"gpm",
						"iscsi",
						"iscsid",
						"kudzu",
						"mdmonitor",
						"messagebus",
						"microcode_ctl",
						"netfs",
						"nfslock",
						"portmap",
						"readahead_early",
						"readahead_later",
						"sendmail",
						"smartd",
						"firstboot",
						"hidd",
						"pcscd",
						"ip6tables",
						"iptables",
						"yum-updatesd",
						"rpcgssd",
						"rpcidmapd",
						"rhnsd",
						"rawdevices",
						"haldaemon",
						"irqbalance",
						"setroubleshoot",
						"dovecot",
						"httpd",
						"postfix",
						"vsftpd",
						"webmin",
						"saslauthd",
						"rpcbind",
						"pppoe-server",
						"portreserve",
						"mysqld",
						"abrtd",
						"xinetd",
						"restorecond",
						"fcoe",
						"lldpad",
						"cups"
						],
		default => []
	}
}
