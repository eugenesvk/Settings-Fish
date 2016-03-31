# Owner and language
set -x USER_NAME   	eugenesv
set -x DEFAULT_USER	eugenesv
set -x LC_ALL      	en_US.UTF-8
set -x LANG        	en_US.UTF-8
set -x ARCHFLAGS   	"-arch x86_64"	# Compilation flags

# In `fish` aliases are left for compatibility, defined as functions; `functions` for a full list
alias pkg-size "pacman -Qi | egrep '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | less"
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
set -x 	SSH_KEY_PATH  	$HOME/.ssh/IDs/rsa_id
set -x 	PATH          	$CoreUtils_Root/gnubin $HOME/bin $HOME/bin/FontForge /usr/local/sbin $PATH

#/usr/local/bin /usr/bin /bin /usr/sbin /sbin #default in '/private/etc/paths'
#/opt/X11/bin /usr/local/MacGPG2/bin          #manually added in '/private/etc/paths.d'

# Other environment vars
set -x HOMEBREW_GITHUB_API_TOKEN    	(cat $HOME/.config/env_github_brew.txt)
set -x ST3_MARKDOWN_GITHUB_API_TOKEN	(cat $HOME/.config/env_github_ST3.txt)

# Set vars that would allow ssh-add -c confirmation option to work
set -gx DISPLAY "localhost:0.0"
set -gx SSH_ASKPASS "/usr/lib/git-core/git-gui--askpass"

source $HOME/.config/ssh-find-agent.fish	# find all ssh-agents
#echo "====Before using `ssh-find-agent -a` (=set_ssh_agent_socket)"; ssh-env-echo
ssh-find-agent -a	# choose the first agent and set SSH_AUTH_SOCK; `-c` manually
#echo "====After using `ssh-find-agent -a`"; ssh-env-echo

if test -z "$SSH_AUTH_SOCK"           # if no agent socket set, run new
	#echo "====New agent since SSH_AUTH_SOCK was empty"; ssh-env-echo
	#ssh-agent-fish
	# if no keys, make next `ssh` command start an agent, add all keys and continue as normal
	ssh-add -l >/dev/null 2>/dev/null; or alias ssh 'ssh-agent-fish; and ssh-add -l >/dev/null 2>/dev/null; or ssh-add -c $HOME/.ssh/IDs/*.pri; and functions -e ssh; ssh'
	#-c Added identities should be subject to confirmation before being used for authentication
	#-l Lists fingerprints of all identities currently represented by the agent
end

#ssh-agent -k; set -e SSH_AGENT_PID; set -e SSH_AUTH_SOCK
#set -Ux SSH_AGENT_PID 1234; set -Ux SSH_AUTH_SOCK /tmp; echo "Env.fish:AgentPID:[$SSH_AGENT_PID]; Socket[$SSH_AUTH_SOCK]"
#set -Ux SSH_AUTH_SOCK /tmp; set -e UNITEMP; set -Ux UNITEMP abc;  echo "Env.fish:Socket[$SSH_AUTH_SOCK]"
#set -Ux SSH_AUTH_SOCK /tmp; set -e UNITEMP1; set -Ux UNITEMP1 abc;  echo "Env.fish:Socket[$SSH_AUTH_SOCK]"
#set -e SSH_AUTH_SOCK; set -e SSH_AGENT_PID; echo "AgentPID:[$SSH_AGENT_PID]; Socket[$SSH_AUTH_SOCK]"
#ssh-agent-fish; ssh-env-echo
#ssh-agent-fish -k; ssh-env-echo

# Test switching two agents with different number of keys. Socket path (but not PID) defines which agent is used, keys are stored inside the agent. PID defines which agent is killed with `ssh-agent -k`
#set -Ux prepid $SSH_AGENT_PID; set -Ux presock $SSH_AUTH_SOCK; echo [$prepid] [$presock]
#set -Ux postpid $SSH_AGENT_PID; set -Ux postsock $SSH_AUTH_SOCK; echo [$postpid] [$postsock]
#set -Ux SSH_AGENT_PID $prepid; set -Ux SSH_AUTH_SOCK $presock; echo [$SSH_AGENT_PID] [$SSH_AUTH_SOCK]
#set -Ux SSH_AGENT_PID $postpid; set -Ux SSH_AUTH_SOCK $postsock; echo [$SSH_AGENT_PID] [$SSH_AUTH_SOCK]
# mix it up
#set -Ux SSH_AGENT_PID $prepid; set -Ux SSH_AUTH_SOCK $postsock; echo [$SSH_AGENT_PID] [$SSH_AUTH_SOCK]
#set -e prepid; set -e postpid; set -e presock; set -e postsock; set -e SSH_AGENT_PID; set -e SSH_AUTH_SOCK
#Maybe set the socket path manually? electricmonk.nl/log/2012/04/24/re-use-existing-ssh-agent-cygwin-et-al/
