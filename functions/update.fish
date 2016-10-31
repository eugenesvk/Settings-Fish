function update -d "Update everything (Homebrew + packages, Oh-My-Fish)"
  echo '==Updating Oh-My-Fish=='; omf update
  set -l system (check_system)
	if test "$system" = OSX
		echo '==Updating Homebrew==';                       	brew update
		echo '==Updating Homebrew packages==';              	brew upgrade
		echo '==Cleaning up downloaded Homebrew packages==';	brew cleanup
	end
end
