# Owner and language
set -x USER_NAME   	eugenesv
set -x DEFAULT_USER	eugenesv
set -x LC_ALL      	en_US.UTF-8
set -x LANG        	en_US.UTF-8
set -x ARCHFLAGS   	"-arch x86_64"	# Compilation flags

# In `fish` aliases are left for compatibility, defined as functions; `functions` for a full list
alias py      "python"
alias cls     "clear"                        	# Clear screen
alias del     "rmtrash"                      	# Remove to trash
alias bashcfg "subl $HOME/.bashrc"           	#
alias zshcfg  "subl $HOME/.zshrc"            	#
alias ohmyzsh "subl $HOME/.config/.oh-my-zsh"	# Better to define in ZSH_CUSTOM; `alias` for a full list
alias fishcfg "subl $HOME/.config/fish/config.fish"
alias envcfg  "subl $HOME/.config/env.fish"	# Environment vars loaded in fish

# Color stderr output in red
set -l system (check_system)
if test "$system" = OSX
	set err_bold (tput bold; tput md)
	set err_red (tput setaf 1)
	set -x STDERRED_ESC_CODE (echo -e "$err_bold$err_red")
		#set -x STDERRED_BLACKLIST "^(bash|test.*)$"            #blacklist bash, and all programs with names starting with "test"
	set -x DYLD_INSERT_LIBRARIES    /usr/local/lib/stderred/libstderred.dylib       #color errors in red; originally had
		#additional command ${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES} in the end, but seems like a duplicate
end


# PATH
set -x 	EDITOR        	"subl -w"
set -x 	DevH          	$HOME/.dev  	#local development environment for virutalenvs etc.
set -x 	PYENV_ROOT    	$DevH/.pyenv	#local Python versions/shims; default ~/.pyenv
#set -x	PYREPO_ROOT   	$PYENV_ROOT/versions/3.5.1/lib/python3.5/site-packages
set -x 	RBENV_ROOT    	$DevH/.rbenv 	#local Ruby versions/shims; default ~/.rbenv
set -x 	NODENV_ROOT   	$DevH/.nodenv	#local Nodenv versions/shims; default ~/.nodenv
#set -x	NPM_ROOT      	$DevH/.nodenv/versions/5.6.0/lib/node_modules/npm
set -gx	NVM_DIR       	$DevH/.nvm  	#local NVM versions/shims; default ~/.nvm
set -x 	PLENV_ROOT    	$DevH/.plenv	#local Per versions/shims; default ~/.plenv
set -x 	CoreUtils_Root	/usr/local/opt/coreutils/libexec
set -x 	MANPATH       	$CoreUtils_Root/gnuman /usr/local/share/man $MANPATH
set -x 	SSH_KEY_PATH  	$HOME/.ssh/rsa_id
set -x 	PATH          	$CoreUtils_Root/gnubin $HOME/bin $HOME/bin/FontForge /usr/local/sbin $PATH

#set -x PATH $PYENV_ROOT/bin $HOME/.rbenv/bin $HOME/.plenv/bin $PATH  # not needed since binaries are in Homebrew
#$PYENV_ROOT/shims $HOME/.rbenv/shims $HOME/.plenv/shims $PATH      #get installed through init commands above
#/usr/local/bin /usr/bin /bin /usr/sbin /sbin #default in '/private/etc/paths'
#/opt/X11/bin /usr/local/MacGPG2/bin          #manually added in '/private/etc/paths.d'

# Other environment vars
set -x HOMEBREW_GITHUB_API_TOKEN    	(cat $HOME/.config/env_github_brew.txt)
set -x ST3_MARKDOWN_GITHUB_API_TOKEN	(cat $HOME/.config/env_github_ST3.txt)
set -x HOMEBREW_NO_ANALYTICS        	1

# Search for compatible SSH agents and set `SSH_AUTH_SOCK` accordingly
# ssh-find-agent
# eval (ssh-agent) 1>/dev/null     # launch ssh-agent unless already exists
# . $HOME/.ssh/ssh-find-agent.fish
# ssh-find-agent -a
# if [ -z "$SSH_AUTH_SOCK" ]
#    eval $(ssh_agent) 2>/dev/null
#    ssh-add -l 1>/dev/null; or alias ssh='ssh-add -l 1>/dev/null; or ssh-add; and unalias ssh; ssh'
# end
