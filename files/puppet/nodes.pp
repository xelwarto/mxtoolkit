node 'basenode' {
	include 'mxtoolkit::linux::secure::motd'
	include 'mxtoolkit::linux::secure::login'
	include 'mxtoolkit::linux::secure::network'
	include 'mxtoolkit::linux::secure::selinux2'
	include 'mxtoolkit::linux::secure::ssh'
	include 'mxtoolkit::linux::secure::sudo'

	class { 'mxtoolkit::linux::tools::groups':
		names => [
			'admin'
		]
	}

	class { 'mxtoolkit::linux::dist::host':
		domain => 'slysystems.com'
	}

	class { 'mxtoolkit::linux::secure::tcpwrapper':
		allow => [
			'sshd: All'
		]
	}
}

node 'node1' inherits basenode {
	# Uncomment to disbale services for securing an node
	# This normal is only ran once at initial node setup
	include 'mxtoolkit::linux::secure::services'
}
