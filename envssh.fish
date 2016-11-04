if test "$SYSTEM_NAME" = Win
	set -gx	SSH_KEY_PATH	/c/Users/Evgeny/.ssh/IDs
	# Set vars that would allow ssh-add -c confirmation option to work
	set -gx DISPLAY "localhost:0.0"
	set -gx SSH_ASKPASS "/usr/lib/git-core/git-gui--askpass"
end
if test "$SYSTEM_NAME" = WinLinux
	set -gx SSH_KEY_PATH /mnt/c/Users/Evgeny/.ssh/IDs
	# Set vars that would allow ssh-add -c confirmation option to work
	#set -x	DISPLAY	":0.0"	# already defined in main config
	set -gx SSH_ASKPASS "/usr/bin/ssh-askpass"
end

source $HOME/.config/fish/functions/ssh-find-agent.fish	# find all ssh-agents
#echo "====Before using `ssh-find-agent -a` (=set_ssh_agent_socket)"; ssh-env-echo
ssh-find-agent -a	# choose the first agent and set SSH_AUTH_SOCK; `-c` manually
#echo "====After using `ssh-find-agent -a`"; ssh-env-echo

if test -z "$SSH_AUTH_SOCK"           # if no agent socket set, run new
	#echo "====New agent since SSH_AUTH_SOCK was empty"; ssh-env-echo; ssh-agent-fish
	# if no keys, make next `ssh` command start an agent, add all keys and continue as normal
	ssh-add -l >/dev/null 2>/dev/null; or alias ssh 'ssh-agent-fish; and ssh-keys-list $SSH_KEY_PATH; and ssh-add -l >/dev/null 2>/dev/null; or ssh-add $SSH_KEY_LIST; and functions -e ssh; ssh'
	# if using agent forwarding, add `-c` flag to `ssh-add $SSH_KEY_LIST` to
	#-c Added identities should be confirmed before being used for authentication, use IF forwarding
	#-l Lists fingerprints of all identities currently represented by the agent
	else if test ! (pgrep -U $USER ssh-agent) # no ssh-agents running, though socket var is set
		echo "No agents associated with $SSH_AUTH_SOCK, removing it and clearing env var"
		rm -rf (echo "$SSH_AUTH_SOCK" | sed 's/\/agent.*//'); ssh-agent-empty-sock
		ssh-add -l >/dev/null 2>/dev/null; or alias ssh 'ssh-agent-fish; and ssh-keys-list $SSH_KEY_PATH; and ssh-add -l >/dev/null 2>/dev/null; or ssh-add $SSH_KEY_LIST; and functions -e ssh; ssh'
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

#Funtoo Keychain doesn't set env vars in fish and also forces you to enter passwords on login
#if command -v keychain > /dev/null; status --is-interactive; and keychain --eval --quiet -Q ~/.ssh/IDs/Git/id_ed25519_GitHub | source; end
