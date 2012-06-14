Facter.add("defroute") do
	setcode do
		%x{/sbin/route -n |grep "^0.0.0.0" |awk '{ print $2 }'}.chomp
	end
end
