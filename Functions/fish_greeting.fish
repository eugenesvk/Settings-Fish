function fish_greeting -d 'Prints a greeting on each login'
	set -l system (check_system)
  if test "$system" = OSX          # OS X greeting
		echo '`update` (homebrew and OMF), `fish_config`, `omf theme`, `brew uses --installed X`, `brew deps X` `brew list --pinned`'
		echo '`z foo` cd to most recent dir matching `foo`; `z foo bar` matches both; `z -r foo` highest ranked; `z -t foo` most recent; `z -l foo` lists all dirs matching `foo` (by frequency)'
		echo '`pyenv migrate V1 V2`'
	else if test "$system" = Win
		echo 'Win Msys2'
  else if test "$system" = Linux
		echo ''
  else if test "$system" = NA
   echo ''
  end
end
