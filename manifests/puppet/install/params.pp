# Class: mxtoolkit::puppet::install::params
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class applies to the installtion of a puppet server or client
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::puppet::install::params {
	$server_packages = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => ['puppet','apache2','openssl','rubygems','subversion','wget',
						'libcurl4-openssl-dev','libssl-dev','zlib1g-dev', 'git'
						'apache2-prefork-dev','libapr1-dev','libaprutil1-dev'
						],
		/(?i-mx:centos|fedora|redhat)/ => [ 'httpd','openssl','puppet','rubygems','ruby-devel','ruby','gcc','make',
						'subversion','git','wget','openssl-devel','httpd-devel','libcurl-devel',
						'zlib-devel','zlib','apr-util-devel','apr-util','apr-devel','apr','gcc-c++'
						],
		default => []
	}

	$server_gems = ['rack', 'passenger']

	$passenger_bin = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => ['/usr/local/bin', '/bin', '/usr/bin'],
		/(?i-mx:centos|fedora|redhat)/ => ['/usr/local/bin', '/bin', '/usr/bin'],
		default => []
	}

	$server_service = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => ['apache2'],
		/(?i-mx:centos|fedora|redhat)/ => ['httpd'],
		default => []
	}

	$apache_package = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'apache2',
		/(?i-mx:centos|fedora|redhat)/ => 'httpd',
		default => []
	}

	$gems_package = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'rubygems',
		/(?i-mx:centos|fedora|redhat)/ => 'rubygems',
		default => []
	}

	$passenger_package = $operatingsystem ? {
		/(?i-mx:ubuntu|debian)/        => 'passenger',
		/(?i-mx:centos|fedora|redhat)/ => 'passenger',
		default => []
	}
}
