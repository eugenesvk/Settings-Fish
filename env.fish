# Owner and language
set -x LC_ALL   	en_US.UTF-8
set -x LANG     	en_US.UTF-8
set -x ARCHFLAGS	"-arch x86_64"	# Compilation flags

# In `fish` aliases are left for compatibility, defined as functions; `functions` for a full list
alias py     	"python"
alias py3    	"python3"
alias cls    	"clear"                              	# Clear screen
alias del    	"rmtrash"                            	# Remove to trash
alias bashcfg	"subl $HOME/.bashrc"                 	#
alias zshcfg 	"subl $HOME/.zshrc"                  	#
alias ohmyzsh	"subl $HOME/.config/.oh-my-zsh"      	# Better to define in ZSH_CUSTOM; `alias` for a full list
alias fishcfg	"subl $HOME/.config/fish/config.fish"	#
alias envcfg 	"subl $HOME/.config/fish/env.fish"   	# Environment vars loaded in fish
alias m      	"fasd -f -e mpv"                     	# open frecent files with mpv
alias sub    	"fasd -f -e subl"                    	# open frecent files with sublime

if test "$SYSTEM_NAME" = OSX
	set -x USER_NAME   	eugenesv
	set -x DEFAULT_USER	eugenesv
	# Color stderr output in red
	set err_bold (tput bold; tput md)
	set err_red (tput setaf 1)
	set -x STDERRED_ESC_CODE (echo -e "$err_bold$err_red")
		#set -x STDERRED_BLACKLIST "^(bash|test.*)$"            #blacklist bash, and all programs with names starting with "test"
	#set -x DYLD_INSERT_LIBRARIES /usr/local/lib/stderred/libstderred.dylib       #color errors in red
	set -x	Dropbox       	"$HOME/Documents/Dropbox"
	set -x	CoreUtils_Root	/usr/local/opt/coreutils/libexec
	set -x	MANPATH       	$CoreUtils_Root/gnuman $MANPATH
	set -x	PATH          	$CoreUtils_Root/gnubin $PATH

	#set -gx	PKG_CONFIG_PATH	"$PYENV_ROOT/versions/3.6-dev/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/local/lib"
	#/usr/local/bin /usr/bin /bin /usr/sbin /sbin #default in '/private/etc/paths'
	#/opt/X11/bin /usr/local/MacGPG2/bin          #manually added in '/private/etc/paths.d'
end
if test "$SYSTEM_NAME" = Linux -o "$SYSTEM_NAME" = WinLinux
	set -x	USER_NAME                 	es
	set -x	DEFAULT_USER              	es
	set -x	XDG_DATA_DIRS             	$HOME/.linuxbrew/share:$XDG_DATA_DIRS
	set -x	MANPATH                   	$HOME/.linuxbrew/share/man $MANPATH
	set -x	INFOPATH                  	$HOME/.linuxbrew/share/info $INFOPATH
	set -x	PATH                      	$HOME/.linuxbrew/bin $HOME/.linuxbrew/sbin $PATH
	set -x	HOMEBREW_BUILD_FROM_SOURCE	1
end
if test "$SYSTEM_NAME" = Linux
	set -x	MinGW64_PATH	$DevH/toolchains/mingw-w64-x86_64/bin	#MinGW-w64 toolchain for HandBrake
	set -x	PATH        	$MinGW64_PATH $PATH
end
if test "$SYSTEM_NAME" = WinLinux
	set -x	DISPLAY	":0.0"
end
if test "$SYSTEM_NAME" = Win
	set -x USER_NAME   	Evgeny
	set -x DEFAULT_USER	Evgeny
	alias pkg-size "pacman -Qi | egrep '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | less"
	set -x	MANPATH	$CoreUtils_Root/gnuman $MANPATH
	set -x	PATH   	$CoreUtils_Root/gnubin $PATH
end

# PATH
set -gx	TERM       	"xterm-256color"
set -x 	EDITOR     	"subl -w"
set -x 	DevH       	$HOME/.dev  	#local development environment for virutalenvs etc.
set -x 	PYENV_ROOT 	$DevH/.pyenv	#local Python versions/shims; default ~/.pyenv
#set -x	PYREPO_ROOT	$PYENV_ROOT/versions/3.5.1/lib/python3.5/site-packages
set -x 	RBENV_ROOT 	$DevH/.rbenv 	#local Ruby versions/shims; default ~/.rbenv
set -x 	NODENV_ROOT	$DevH/.nodenv	#local Nodenv versions/shims; default ~/.nodenv
#set -x	NPM_ROOT   	$DevH/.nodenv/versions/5.6.0/lib/node_modules/npm
set -gx	NVM_DIR    	$DevH/.nvm  	#local NVM versions/shims; default ~/.nvm
set -x 	PLENV_ROOT 	$DevH/.plenv	#local Per versions/shims; default ~/.plenv
set -x 	_FASD_DATA 	$HOME/.config/.fasd
set -x 	MANPATH    	/usr/local/share/man $MANPATH
set -x 	PATH       	$HOME/.local/bin /usr/local/sbin $PATH

# Other environment vars
set -x HOMEBREW_GITHUB_API_TOKEN    	(cat $HOME/.config/bash/env_github_brew.txt)
set -x ST3_MARKDOWN_GITHUB_API_TOKEN	(cat $HOME/.config/bash/env_github_ST3.txt)
set -x HOMEBREW_NO_ANALYTICS        	1
