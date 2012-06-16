/*
####################
# mxToolKit - Puppet module for Linux configuration and security
####################
Class: mxtoolkit::linux::secure::params

Class Version: 0.1

Description:
* Linux security class

Subclasses:

Parameters:

Tested:

Sample Usage:

#######################################################################

Copyright 2012 Ted Elwartowski <xelwarto.pub@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

#######################################################################
*/

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
