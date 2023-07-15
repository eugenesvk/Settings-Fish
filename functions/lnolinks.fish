function lnolinks -w find -d 'Show files only (without links)'
	find . -maxdepth 1 \! -type l -exec ls -d -lah --color=always $argv \{\} \+
end
