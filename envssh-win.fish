set -x	SSH_KEY_PATH	$HOME/.ssh/IDs/rsa_id

# Set vars that would allow ssh-add -c confirmation option to work
set -gx DISPLAY "localhost:0.0"
set -gx SSH_ASKPASS "/usr/lib/git-core/git-gui--askpass"

source $HOME/.config/fish/functions/ssh-find-agent.fish	# find all ssh-agents
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
