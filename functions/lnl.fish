function lnl -w find -d 'Show files only (without links), short style'
	find . -maxdepth 1 \! -type l -exec ls -d --color=always $argv \{\} \+
end
