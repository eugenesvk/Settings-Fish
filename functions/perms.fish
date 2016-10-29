function perms -d 'Simple list of files with octal permissions'
	if count $argv > /dev/null
		stat -c "%a %n" $argv
	else
		stat -c "%a %n" *
	end
end
