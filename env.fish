# Owner and language
set -x LC_ALL   	en_US.UTF-8
set -x LANG     	en_US.UTF-8
set -x ARCHFLAGS	"-arch x86_64"	# Compilation flags

# Aliases are left for compatibility, defined as functions; `functions` for a full list
alias py      	"python"
alias py3     	"python3"
alias cls     	"clear"                              	# Clear screen
alias del     	"rmtrash"                            	# Remove to trash
alias ytd     	"youtube-dl"                         	# YouTube and other video downloader
alias bashcfg 	"subl $HOME/.bashrc"                 	#
alias zshcfg  	"subl $HOME/.zshrc"                  	#
alias ohmyzsh 	"subl $HOME/.config/.oh-my-zsh"      	# Better to define in ZSH_CUSTOM; `alias` for a full list
alias fishcfg 	"subl $HOME/.config/fish/config.fish"	#
alias envcfg  	"subl $HOME/.config/fish/env.fish"   	# Environment vars loaded in fish
# alias m     	"fasd -f -e mpv"                     	# open frecent files with mpv
# alias sub   	"fasd -f -e subl"                    	# open frecent files with sublime
alias metadata	"atadatem"                           	# Clean metadata (bluem.net/en/mac/atadatem/)

# test, some fish instances try to clone HomeBrew
set -x HOMEBREW_NO_ANALYTICS    	1
set -x HOMEBREW_INSTALL_FROM_API	1                  	# disable local repo clone (~1G)
set -x HOMEBREW_AUTO_UPDATE_SECS	(math "60*60*24*7")	# |300| brew update weekly

# Set PATH variables
set -gx 	TERM           	"xterm-256color"
set -x  	EDITOR         	"subl -w"
set -x  	DevH           	"$HOME/.dev" 	# local development environment
set -x  	PYENV_ROOT     	"$DevH/pyenv"	# Python versions/shims ; ['~/.pyenv']
#set -x 	PYREPO_ROOT    	$PYENV_ROOT/versions/3.5.1/lib/python3.5/site-packages
set -x  	RBENV_ROOT     	"$DevH/rbenv" 	# Ruby   versions/shims ; ['~/.rbenv']
set -x  	NODENV_ROOT    	"$DevH/nodenv"	# Nodenv versions/shims ; ['~/.nodenv']
#set -x 	NPM_ROOT       	"$DevH/.nodenv"/versions/5.6.0/lib/node_modules/npm
set -gx 	NVM_DIR        	"$DevH/nvm"   	# NVM    versions/shims ; ['~/.nvm']
set -x  	PLENV_ROOT     	"$DevH/plenv" 	# Perl   versions/shims ; ['~/.plenv']
set -x  	GOPATH         	"$DevH/go"    	# GO dev environment    ; ['~/go']
set -x  	RUSTUP_HOME    	"$DevH/rustup"	# Rust toolchain        ; ['~/.rustup']
set -x  	CARGO_HOME     	"$DevH/cargo" 	# Rust package manager  ; ['~/.cargo']
set -x  	STARSHIP_CONFIG	"$HOME/.config/starship/starship.toml" # starship prompt config file
# set -x	_FASD_DATA     	"$HOME/.config/.fasd"

if test "$SYSTEM_NAME" = OSX
  set -x USER_NAME   	"$USER"
  set -x DEFAULT_USER	"$USER"
  # Color stderr output in red
  set     	err_bold          	(tput bold; tput md)
  set     	err_red           	(tput setaf 9)	# bright red, 1 is regular red
  # set -x	STDERRED_ESC_CODE 	(echo -e "$err_bold$err_red")
  # set -x	STDERRED_ESC_CODE 	(echo -e "$err_red")
  # set -x	STDERRED_BLACKLIST	'^(bash|test.*)$'	 # blacklist bash, and all programs with names starting with "test"
  # set -x	DYLD_INSERT_LIBRARIES /usr/local/lib/stderred/libstderred.dylib(echo (varAlt DYLD_INSERT_LIBRARIES ":$DYLD_INSERT_LIBRARIES")) # color errors in red; adds ':var' if var is set
  # fzf to use fd instead of find, also follow symbolic links and include hidden files
  if command -v fd > /dev/null
    set -x FZF_DEFAULT_COMMAND	'fd --type file --follow --hidden --exclude .git'
    set -x FZF_CTRL_T_COMMAND 	"$FZF_DEFAULT_COMMAND"
    # set -x FZF_DEFAULT_OPTS 	'--ansi'
  end
  set -x	GOKU_EDN_CONFIG_FILE	"$HOME/.config/karabiner/assets/Goku/karabiner.edn"	# Goku (karabiner config editor)
  set -x	CMAKE_PREFIX_PATH   	'/usr/local/opt/qt5/'                              	# to build QT5 apps using HomeBrewed QT5
  set -x	Dropbox             	"$HOME/Documents/Dropbox"
  set -x	GoRoot              	'/usr/local/opt/go/libexec/bin'
  set -x	CoreUtils_Root      	'/usr/local/opt/coreutils/libexec'
  set -x	GOBin               	"$GOPATH/bin"     	# local GO binaries
  set -x	CargoBin            	"$CARGO_HOME/bin" 	# local Rust binaries
  set   	PyenvBin            	"$PYENV_ROOT/bin" 	# pyenv itself
  set   	RbenvBin            	"$RBENV_ROOT/bin" 	# rbenv itself
  set   	NodenvBin           	"$NODENV_ROOT/bin"	# nodenv itself
  set   	GoenvBin            	"$GOENV_ROOT/bin" 	# goenv itself
  set -x	MANPATH             	"$CoreUtils_Root/gnuman" $MANPATH
  set -x	PATH                	"$CoreUtils_Root/gnubin" $GOBin $CargoBin $PyenvBin $RbenvBin $NodenvBin $GoenvBin $PATH
  # 'XDG'	               	# user-specific files
  set -x 	XDG_CONFIG_HOME	"$HOME/.config"      	#~/.config     	configuration
  set -x 	XDG_DATA_HOME  	"$HOME/AppData"      	#~/.local/share	data
  set -x 	XDG_STATE_HOME 	"$HOME/AppData/state"	#~/.local/state	unimportant/non-portable state

  if command -v $GoRoot/go > /dev/null ; set -x PATH $GoRoot $PATH; end

  #set -gx	PKG_CONFIG_PATH	"$PYENV_ROOT/versions/3.6-dev/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/local/lib"
  #/usr/local/bin /usr/bin /bin /usr/sbin /sbin #default in '/private/etc/paths'
  #/opt/X11/bin /usr/local/MacGPG2/bin          #manually added in '/private/etc/paths.d'
end
if test "$SYSTEM_NAME" = Linux -o "$SYSTEM_NAME" = WinLinux
  set -x	USER_NAME    	"$USER"
  set -x	DEFAULT_USER 	"$USER"
  set -x	LBrewHome    	'/home/linuxbrew/.linuxbrew'
  set -x	XDG_DATA_DIRS	"$LBrewHome/share:$XDG_DATA_DIRS"
  set -x	MANPATH      	"$LBrewHome/share/man" $MANPATH
  set -x	INFOPATH     	"$LBrewHome/share/info" $INFOPATH
  if test -d $DevH/toolchains/mingw-w64-x86_64/bin
    set -x	MinGW64PATH	$DevH/toolchains/mingw-w64-x86_64/bin #toolchain for HandBrake
  end
  set -x  	PATH "$LBrewHome/bin" "$LBrewHome/sbin" "$MinGW64PATH" $PATH
  # set -x	HOMEBREW_BUILD_FROM_SOURCE	1 # not needed since new LinuxBrewHome allows bottles
end
if test "$SYSTEM_NAME" = Linux
	# set -x	QT_QPA_PLATFORMTHEME	qt5ct	# Make sure QT5 apps in Gnome look better
end
if test "$SYSTEM_NAME" = WinLinux
	set       	asdfH              	(brew --prefix asdf)                                         	#1) bypassed asdf shims via direnv 2) readlink -f to resolve symlinks
	if test -e	"$asdfH/asdf.fish";	source "$asdfH/asdf.fish" 2>/dev/null; end                   	# Suppress Warning about invalid $ASDF_DIR/shims folder
	# set -x  	ASDF_ROOT          	"$asdfH/bin"                                                 	# asdf bins only (without shims) for direnv
	umask     	027                	                                                             	# Fixes Homebrew error (new folders can't be world-writable
	set -x    	DISPLAY            	(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0	# WSL2 fix (superuser.com/questions/1476086/error-cant-open-display-0), was
	# set -x  	DISPLAY            	":0.0"                                                       	# old WSL, doesn't work in WSL2
	set -x    	PATH               	"$HOME/perl5/bin" $PATH
	set -x    	PERL5LIB           	$HOME/perl5/lib/perl5:/mnt/d/Dropbox/Settings/Dev/Perl5/lib(echo (varAlt PERL5LIB ":$PERL5LIB"))
	set -x    	PERL_LOCAL_LIB_ROOT	"$HOME/perl5" $PERL_LOCAL_LIB_ROOT
	set -x    	PERL_MB_OPT        	--install_base \"/home/es/perl5\"
	set -x    	PERL_MM_OPT        	INSTALL_BASE=/home/es/perl5
	# set -x  	PATH               	"$ASDF_ROOT" "$PATH"
end
if test "$SYSTEM_NAME" = Win
	set -x USER_NAME   	'Evgeny'
	set -x DEFAULT_USER	'Evgeny'
	alias pkg-size "pacman -Qi | egrep '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | less"
	set -x	MANPATH	"$CoreUtils_Root/gnuman" $MANPATH
	set -x	PATH   	"$CoreUtils_Root/gnubin" $PATH
end

# Set PATH
set -x	MANPATH	'/usr/local/share/man' $MANPATH
set -x	PATH   	"$HOME/.local/bin" '/usr/local/sbin' $PATH

# Other environment vars
set -x HOMEBREW_GITHUB_API_TOKEN    	(cat "$DevH/secret/env_github_brew")
set -x ST3_MARKDOWN_GITHUB_API_TOKEN	(cat "$DevH/secret/env_github_ST3")
