function fish_greeting -d 'Prints a greeting on each login'
	set -l system (check_system)
  if test "$system" = OSX          # OS X greeting
		echo '`update` (homebrew and OMF), `fish_config`, `omf theme`, `brew uses --installed X`, `brew deps X` `brew list --pinned`'
		echo '`z foo` cd to most recent dir matching `foo`; `z foo bar` matches both; `z -r foo` highest ranked; `z -t foo` most recent; `z -l foo` lists all dirs matching `foo` (by frequency)'
		echo '`pyenv migrate V1 V2`'
	else if test "$system" = Win
		echo -e "\e[9999;1H"	# scroll to the end of screen buffer to display xterm-256 colors in ConEmu
		echo 'Update: 1. update-core RESTART! 2. pacman -Su 3. update (OMF), fish_config, omf theme'
		echo 'Search: `pacsearch X` local/remote with colors; `-Ss` remote(sync); `-Qs` local; List local `-Qq` or `-Q`'
		echo 'Delete: `-Rs X` X with stray dependencies; `-Sc` Clean cache (`-Scc` inc installed)'
		echo 'Fish: `z foo` most recent dir matching foo; `z foo bar` matches both; `z -r foo` highest ranked; `z -t foo` most recent; `z -l foo` lists all dirs matching `foo` (by frequency)'
		echo "Node.js version check doesn't work for some reason"
		echo 'Bash: `Ctrl-L` clear screen; Mintty: `Alt-F2` new window; `Alt-F3` search text; `Alt-F11` fullscreen'
  else if test "$system" = Linux
		echo ''
  else if test "$system" = NA
   echo ''
  end
end
