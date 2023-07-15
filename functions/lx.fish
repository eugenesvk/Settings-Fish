function lx -w exa -d 'A shortcut to exa -hlgHa (Header, Long details, file’s Group, #ofHardLinks, AllHiddenDot'
	exa -hlgHa $argv
	# -T, --tree: recurse into directories as a treec
end
