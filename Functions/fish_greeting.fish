function fish_greeting -d 'Prints a greeting on each login'
  set -l osname (uname)
  if test $osname = Darwin          # OS X greeting
		echo '`update` (homebrew and OMF), `fish_config`, `omf theme`, `brew uses --installed X`, `brew deps X` `brew list --pinned`'
		echo '`z foo` cd to most recent dir matching `foo`; `z foo bar` matches both; `z -r foo` highest ranked; `z -t foo` most recent; `z -l foo` lists all dirs matching `foo` (by frequency)'
		echo '`pyenv migrate V1 V2`'
	else if
		begin # Windows MSys2
			test (echo $osname | grep -E MSYS_NT 2>/dev/null)
			or test (echo $osname | grep -E MINGW32_NT 2>/dev/null)
			or test (echo $osname | grep -E MINGW64_NT 2>/dev/null)
		end
		echo 'Win Msys2'
	end
  else          # adjust for linux, then
		echo ''
  end
end
