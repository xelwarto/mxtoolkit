# Class: mxtoolkit::puppet::install::server
#
# The mxToolKit module is used to manage several aspects of Unix/Linux systems
# This class applies to the installtion of a puppet server
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mxtoolkit::puppet::install::server inherits mxtoolkit::puppet::install::params {
	info("Applying class mxtoolkit::puppet::install::server")

	if ($::id == "root") {
		$packages = $mxtoolkit::puppet::install::params::server_packages
		$apache_package = $mxtoolkit::puppet::install::params::apache_package
		$gems_package = $mxtoolkit::puppet::install::params::gems_package
		$gems = $mxtoolkit::puppet::install::params::server_gems
		$service = $mxtoolkit::puppet::install::params::server_service
		$passenger_path = $mxtoolkit::puppet::install::params::passenger_bin
		$passenger_package = $mxtoolkit::puppet::install::params::passenger_package
		$cert_host = $::hostname
		$ip_addr = $::ipaddress

		if ($::fqdn) {
			$apache_host = $::fqdn
		} else {
			$apache_host = $::hostname
		}

		group { 'web':
			ensure => 'present',
			gid => '2000'
		}

		user { 'web':
			ensure => 'present',
			uid => '2000',
			gid => 'web',
			comment => 'Web Server User',
			home => '/home/web`',
			managehome => true,
			password_min_age => '0',
			shell => '/bin/bash',
			password_max_age => '99999',
			password => '',
			require => Group['web']
		}

		package { $packages:
			ensure => 'present',
			require => User['web']
		}

		file { "/var/lib/puppet/reports":
			ensure => 'directory',
			mode => 0750,
			owner => root,
			group => root,
			require => [ Package[$packages] ]
		}

		package { $gems:
			ensure => 'present',
			provider => 'gem',
			require => Package[$gems_package]
		}

		exec { 'puppet-cert-generate':
			command => "puppet cert generate $::hostname",
			path => $passenger_path,
      			before => Service[$service],
		}

		exec { 'passenger-install':
			command => 'passenger-install-apache2-module --auto',
			path => $passenger_path,
      			before => Service[$service],
			require => [
				Package[$apache_package],
				Package[$passenger_package],
				Package[$gems_package]
			]
		}

		file { ["/etc/puppet/rack", "/etc/puppet/rack/public"]:
			ensure => directory,
			mode => 0755,
			owner => root,
			group => root,
			require => [
				Package[$apache_package]
			]
		}

		file { "/etc/puppet/puppet.conf":
			ensure => present,
			source => "puppet:///modules/mxtoolkit/puppet/puppet.conf",
			mode => 0644,
			owner => root,
			group => root,
			backup => ".mxToolKit_$::datetime",
			require => [
				Package[$apache_package]
			]
		}

		file { "/etc/puppet/manifests/site.pp":
			ensure => present,
			source => "puppet:///modules/mxtoolkit/puppet/site.pp",
			mode => 0644,
			owner => root,
			group => root,
			require => [
				Package[$apache_package]
			]
		}

		file { "/etc/puppet/manifests/nodes.pp":
			ensure => present,
			source => "puppet:///modules/mxtoolkit/puppet/nodes.pp",
			mode => 0644,
			owner => root,
			group => root,
			require => [
				Package[$apache_package]
			]
		}

		file { "/etc/puppet/rack/config.ru":
			ensure => present,
			source => "puppet:///modules/mxtoolkit/puppet/config.ru",
			mode => 0644,
			owner => puppet,
			group => root,
			require => [
				Package[$apache_package]
			]
		}

		service { $service:
		}

		Service[$service] {
			require => Package[$apache_package]
		}

		case $operatingsystem {
			/(?i-mx:ubuntu|debian)/: {
				file { [
					'/etc/apache2/sites-enabled/000-default',
					'/etc/apache2/conf.d/other-vhosts-access-log',
					'/etc/apache2/conf.d/localized-error-pages',
					'/etc/apache2/mods-enabled/alias.conf',
					'/etc/apache2/mods-enabled/status.conf',
					'/etc/apache2/mods-enabled/status.load',
					'/etc/apache2/mods-enabled/autoindex.conf',
					'/etc/apache2/mods-enabled/autoindex.load',
					'/etc/apache2/mods-enabled/cgid.conf',
					'/etc/apache2/mods-enabled/cgid.load',
					]:
					ensure => 'absent',
					require => Package[$apache_package]
				}

				file { "/etc/apache2/envvars":
					ensure => 'present',
					mode => 0644,
					owner => root,
					group => root,
					source => "puppet:///modules/mxtoolkit/puppet/envvars",
					backup => ".mxToolKit_$::datetime",
					notify => Service[$service],
					require => Package[$apache_package]
				}

				file { "/etc/apache2/ports.conf":
					ensure => 'present',
					mode => 0644,
					owner => root,
					group => root,
					content => "",
					backup => ".mxToolKit_$::datetime",
					notify => Service[$service],
					require => Package[$apache_package]
				}

				file { "/etc/apache2/conf.d/security":
					ensure => 'present',
					mode => 0644,
					owner => root,
					group => root,
					source => "puppet:///modules/mxtoolkit/puppet/security",
					notify => Service[$service],
					require => Package[$apache_package]
				}

				file { "/etc/apache2/conf.d/charset":
					ensure => 'present',
					mode => 0644,
					owner => root,
					group => root,
					source => "puppet:///modules/mxtoolkit/puppet/charset",
					notify => Service[$service],
					require => Package[$apache_package]
				}

				file { "/etc/apache2/sites-enabled/000-puppet":
					ensure => present,
					content => template('mxtoolkit/puppet/apache_puppet.conf.erb'),
					mode => 0644,
					owner => root,
					group => root,
					require => [
						Exec['passenger-install'],
						File["/etc/puppet/rack/config.ru"],
						File["/etc/puppet/rack/public"],
						Package[$apache_package],
						Package[$gems_package]
					],
					notify => Service[$service],
				}

				file { "/etc/apache2/mods-available/ssl.conf":
					ensure => 'present',
					mode => 0644,
					owner => root,
					group => root,
					source => "puppet:///modules/mxtoolkit/puppet/ssl.conf",
					notify => Service[$service],
					require => [
						Package[$apache_package],
						File["/etc/apache2/mods-enabled/ssl.load"]
					]
				}

				file { "/etc/apache2/mods-enabled/ssl.conf":
					ensure => "../mods-available/ssl.conf",
					notify => Service[$service],
					require => Package[$apache_package]
				}

				file { "/etc/apache2/mods-enabled/ssl.load":
					ensure => "../mods-available/ssl.load",
					notify => Service[$service],
					require => Package[$apache_package]
				}

				file { "/etc/apache2/httpd.conf":
					ensure => 'present',
					mode => 0644,
					owner => root,
					group => root,
					content => template('mxtoolkit/puppet/apache_httpd.conf.erb'),
					notify => Service[$service],
					require => Package[$apache_package]
				}
			}
		}
	} else {
		err("Error: incorrect user id - must be root to apply")
	}
}
