# environment variables for GUI apps in catalina
# https://apple.stackexchange.com/questions/389023/setting-gui-visible-environment-variables-with-os-catalina
# launchctl setenv FOO BAR
# launchctl setenv RUSTUP_HOME "$HOME/.dev/rustup"
# launchctl setenv FOO BAR1


# Fish Shell config files (fishshell.com) with Oh-My-Fish (https://github.com/oh-my-fish/)
# set -x	PATH	$PATH "/outside/"
if not status --is-interactive
set -x  	DevH       	"$HOME/.dev"     	# local development environment
set -x  	RUSTUP_HOME	"$DevH/rustup"   	# Rust toolchain        ; ['~/.rustup']
set -x  	CARGO_HOME 	"$DevH/cargo"    	# Rust package manager  ; ['~/.cargo']
set -x  	CargoBin   	"$CARGO_HOME/bin"	# local Rust binaries
set -x  	PATH       	$CargoBin $PATH
# set -x	PATH       	$PATH "/not/interactive"
/usr/local/bin/rtx activate fish | source
/usr/local/bin/rtx hook-env -s fish | source

# test, some fish instances try to clone HomeBrew
set -x HOMEBREW_NO_ANALYTICS    	1
set -x HOMEBREW_INSTALL_FROM_API	1                  	# disable local repo clone (~1G)
set -x HOMEBREW_AUTO_UPDATE_SECS	(math "60*60*24*7")	# |300| brew update weekly
end

if status --is-interactive
# /usr/local/bin/rtx activate fish | source
# /usr/local/bin/rtx hook-env -s fish | source
set -gx SYSTEM_NAME (check_system)
set -gx OMF_PATH    "$HOME/.local/share/omf"	# Path to Oh My Fish install, `-g` global, `-x` export=make it env
set -gx OMF_CONFIG  "$HOME/.config/fish/omf"	# Customize Oh My Fish configuration path
source "$HOME/.config/fish/env.fish"        	# Add environment variables
set -x                                      	PATH	$PATH "/interactive/"
if test "$SYSTEM_NAME" = 'Win'
  if status -l; source $HOME/.config/fish/profileMSys2.fish; end	# copy of /etc/profile -> fish
  source $HOME/.config/fish/envssh.fish                         	# enable ssh-agent
end
if test "$SYSTEM_NAME" = WinLinux
  if status --is-login
    # source $HOME/.config/fish/envssh.fish # enable ssh-agent
  end
  [ -f /home/linuxbrew/.linuxbrew/share/autojump/autojump.fish ]; and source /home/linuxbrew/.linuxbrew/share/autojump/autojump.fish
end
if test "$SYSTEM_NAME" = 'OSX'
  source $HOME/.config/fish/envssh-gpg.fish # enable ssh via gpg-agent
  # test -e {$HOME}/.config/iterm2/.iterm2_shell_integration.fish; and source {$HOME}/.config/iterm2/.iterm2_shell_integration.fish  # enable fish integration in iTerm2. ** recursive wildcard (search in folders recursively)
  set -g theme_ismacOS	'yes'	# [no] yes
end
end

if status --is-interactive
source "$OMF_PATH/init.fish"           	# Load oh-my-fish configuration
source "$HOME/.config/fish/envirt.fish"	# Initialize virtual environments

# Theme-es config
set -g theme_es_show_symbols     	'yes'  	#|yes|no       	  ←	Show pre-path symbols, e.g. read-only
set -g theme_es_extra_space      	''     	# ' '          	  ←	Add extra symbol after each icon (e.g., an extra space)
set -g theme_es_verbose_git_ahead	'yes'  	#|yes|no       	   	 
set -g theme_es_show_git_count   	'yes'  	#|no|yes       	  ←	Show git count
set -g theme_es_spacer_count     	''     	# ' '          	  ←	Add extra symbol before each count (e.g., an extra space)
set -g theme_es_git_sha          	'short'	#|short|long¦no	  →	Show git sha (short/long)
set -g theme_es_show_user        	'no'   	#|no|yes       	  →	Show username
set -g theme_es_show_hostname    	'yes'  	#|yes|no       	  →	Show hostname on SSH connections
set -g theme_es_show_node_v      	'yes'  	#|yes|no       	  →	Show Node.js version
set -g theme_es_show_python_v    	'yes'  	#|yes|no       	  →	Show Python version
set -g theme_es_show_ruby_v      	'yes'  	#|yes|no       	  →	Show Ruby prompt @ gemset
set -g theme_es_notify_duration  	10     	#              	   	Notify if command runs longer than this time (seconds)
#top themes: trout (check rbenv version), l, clearance (master changes color in addition to signs)
#other themes: gnuykeaj, jacaetevha (2-line), Zish (exit code on right), flash (orange colors)
if false # use theme defaults
  set -g theme_es_icon_NODE                	\UE718" "	#  from Devicons or ⬢
  set -g theme_es_icon_RUBY                	\UE791" "	# \UE791 from Devicons; \UF047; \UE739; 💎
  set -g theme_es_icon_PYTHON              	\UE606" "	# \UE606; \UE73C
  set -g theme_es_icon_PERL                	\UE606" "	# \UE606; \UE73C
  set -g theme_es_icon_TEST                	\UF091   	# 
  set -g theme_es_icon_VCS_STAGED          	\UF06B   	#  (added) →
  set -g theme_es_icon_VCS_DELETED         	\UF06C   	# 
  set -g theme_es_icon_VCS_MODIFIED        	\UF06D   	# 
  set -g theme_es_icon_VCS_RENAMED         	\UF06E   	# 
  set -g theme_es_icon_VCS_UNMERGED        	\UF026   	#    #═: there are unmerged commits
  set -g theme_es_icon_VCS_UNTRACKED       	\UF02C   	#    #●: there are untracked (new) files
  set -g theme_es_icon_VCS_DIFF            	\UF06B" "	# 
  set -g theme_es_icon_VCS_STASH           	\UF0CF" "	#      #✭: there are stashed commits
  set -g theme_es_icon_VCS_INCOMING_CHANGES	\UF00B" "	#  or \UE1EB or \UE131
  set -g theme_es_icon_VCS_OUTGOING_CHANGES	\UF00C" "	#  or \UE1EC or 
  set -g theme_es_icon_VCS_TAG             	\UF015" "	# 
  set -g theme_es_icon_VCS_BOOKMARK        	\UF07B" "	# 
  set -g theme_es_icon_VCS_COMMIT          	\UF01F" "	# 
  set -g theme_es_icon_VCS_BRANCH          	\UE0A0   	# \UE0A0 or \UF020
  set -g theme_es_icon_VCS_BRANCH_REMOTE   	\UE804" "	#  not displayed, should be branch icon on a book
  set -g theme_es_icon_VCS_BRANCH_DETACHED 	\U27A6" "	# ➦
  set -g theme_es_icon_VCS_GIT             	\UF00A" "	#  from Octicons
  set -g theme_es_icon_VCS_HG              	\UF0DD" "	# Got cut off from Octicons on patching
  set -g theme_es_icon_VCS_CLEAN           	\UF03A   	# 
  set -g theme_es_icon_VCS_PUSH            	\UF005" "	# 
  set -g theme_es_icon_VCS_DIRTY           	±        	#
  set -g theme_es_icon_ARROW_UP            	\UF03D"" 	#  ↑
  set -g theme_es_icon_ARROW_DOWN          	\UF03F"" 	#  ↓
  set -g theme_es_icon_OK                  	\UF03A   	# 
  set -g theme_es_icon_FAIL                	\UF081   	# 
  set -g theme_es_icon_STAR                	\UF02A   	# 
  set -g theme_es_icon_JOBS                	\U2699" "	# ⚙
  set -g theme_es_icon_VIM                 	\UE7C5" "	# 
  set -g theme_es_icon_LOCK                	        	#
end
end

# Extra info
#Custom functions (autoloaded from '~/.config/fish/functions/'), also 'aliases' are treated as a function
  #f.fish                                               #Search for case insensitive file in or below current directory
  #gpl.fish                                             #Prints a pretty git log
  #l.fish                                               #A shortcut to ls -al –color=always
  #mkd.fish                                             #Create a directory CD to it
  #r.fish                                               #Search for text in all files in or below current folder
  #update.fish                                          #Update everything (Homebrew + packages, Oh-My-Fish)
  #z.fish                                               #Add frequently used folder list

#Oh-My-Fish packages (installed through 'omf install X')
  #foreign-env(fenv to use) or bass                     # wrapper for bash scripts
  #nvm.fish                                             # (removed due to use of nodenv) wrapper for NVM in fish
  #rbenv                                                # wrapper for rbenv

# Use function as aliase
  #function ls
  #    command ls --color=auto $argv
  #end
  #NB!
  #Always take care to add the $argv variable to the list of parameters to the wrapped command. This makes sure that if the   user specifies any additional parameters to the function, they are passed on to the underlying command.
  #If the alias has the same name as the aliased command, it is necessary to refix the call to the program with command in  order to tell fish that the unction should not call itself, but rather a command with the same name. ailing to do so will  cause infinite recursion bugs.

#chsh -s /usr/local/bin/fish                            #change default shell to Fish

#STYLE EXAMPLE DESCRIPTION
  #Style      Example                                     Description
  #Unquoted   set world earth;                            Supports all types of parameter expansion,
  #           echo hello $world prints "hello earth"      including C-style backslash expansion, etc.
  #single     set world earth;                            No parameter expansion is performed, the only
  #           echo 'hello $world' prints "hello $world"   special character is the ' (single quote).
  #Double     set world earth;                            Only variable expansion is performed.
  #           echo "hello $world" prints "hello earth"    Expanded variable arrays only result in a single argument.
  #cheatography.com/myounkin/cheat-sheets/fish-shell/

#The short summary is that if $VAR is not set, then test -n $VAR is equivalent to test -n, and POSIX requires that we just check if that one argument (the -n) is not null.
  #1. if test -n "$SSH_CLIENT" # You can fix it by quoting, which forces an argument even if it's empty:
  #2. test -n (EXPRESSION; or echo "")
  #3. use count
# fish_add_path -g '/usr/local/opt/node@14/bin'
  # fish_add_path: This is meant to be the easy one-stop shop to adding stuff to $PATH.
  # Components are normalized by realpath. This means that trailing slashes are ignored and relative paths are made absolute (but symlinks are not resolved). If a component already exists, it is not added again and stays in the same place unless the --move switch is given
  # By default it'll prepend the given paths to a universal $fish_user_paths, excluding the already-included ones.
  # can be executed once in an interactive session, or stuffed in config.fish, and it will do The Right Thing
    # -p --prepend  	[def] add to the front of the variable
    # -a --append   	add to the end of the variable
    # -g --global   	use a global    $fish_user_paths
    # -U --universal	[def] use a universal $fish_user_paths
    # -P --path     	use $PATH directly
    # -m --move     	move already existing components to the place they would be added - by default they would be left in place and not added again
    # -v --verbose  	print the set command used
    # -n --dry-run  	print the set command that would be used without executing it
