function fish_greeting -d 'Prints a greeting on each login'
	set -l system (check_system)
  if test $system = OSX          # OS X greeting
		echo '`update` (homebrew and OMF), `fish_config`, `omf theme`, `brew uses --installed X`, `brew deps X` `brew list --pinned`'
		echo '`z foo` cd to most recent dir matching `foo`; `z foo bar` matches both; `z -r foo` highest ranked; `z -t foo` most recent; `z -l foo` lists all dirs matching `foo` (by frequency)'
		echo '`pyenv migrate V1 V2`'
	else if $system = Win
		echo 'Win Msys2'
	end
  else if $system = Linux
		echo ''
  end
  else echo ''
end
