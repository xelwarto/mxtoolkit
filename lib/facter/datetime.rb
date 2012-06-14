Facter.add("datetime") do
	setcode do
		%x{/bin/date +%m%d%Y_%H%M%S}.chomp
	end
end
