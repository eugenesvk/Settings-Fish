function ssh-agent-fish -d 'Launch the ssh-agent and add the id_rsa identity'
	set AgentPIDs (pgrep -U $USER ssh-agent); set AgentCount (count $AgentPIDs)
  if test -z $argv    # no arguments
		if begin          # various ways to check if an ssh-agent with a valid PID is running
				set -q SSH_AGENT_PID                                  	# if var is set
				and test -n "$SSH_AGENT_PID"                          	# if var is not an empty string
				and kill -0 $SSH_AGENT_PID 2>/dev/null                	# check process is killable???
				#and grep -q '^ssh-agent' /proc/$SSH_AGENT_PID/cmdline	# not working on all systems
				and ps -p $SSH_AGENT_PID | grep -q '[s]sh-agent' 2>/dev/null
			end
			echo "ssh-agent running on pid $SSH_AGENT_PID"
		else if test $AgentCount -gt 0
			if read_confirm "$AgentCount agent(s) with var SSH_AGENT_PID empty, assign a random one?"
				set -Ux SSH_AGENT_PID $AgentPIDs[1]
				echo "SSH_AGENT_PID set to $SSH_AGENT_PID"
			end
		else
			_clear_empty_sock
			eval (command ssh-agent -c | sed 's/^setenv/set -Ux/')
			#ssh-env-echo
		end
		# set -l identity $HOME/.ssh/id_rsa
		# set -l fingerprint (ssh-keygen -lf $identity | awk '{print $2}')
		# ssh-add -l | grep -q $fingerprint
		#	or ssh-add $identity
	else if test $argv[1] = "-k"
		if test $AgentCount -eq 0
			echo "Nothing to kill, no agents running"
		else if test -z $SSH_AGENT_PID # set -q (query) alternative check if var is set
			if read_confirm "$AgentCount agent(s) with var SSH_AGENT_PID empty, kill a random one?"
				set -Ux SSH_AGENT_PID $AgentPIDs[1]
				eval (command ssh-agent -c -k | sed 's/^unsetenv/set -e/')
			end
		else
			eval (command ssh-agent -c -k | sed 's/^unsetenv/set -e/')
			#ssh-env-echo
		end
	else if test $argv[1] = "-n"
		eval (command ssh-agent -c | sed 's/^setenv/set -Ux/')
	else
		echo "Not doing anything: unknown argument(s) $argv"
		return 2
	end
end

function _clear_empty_sock -d "Erase empty SSH_AUTH_SOCK to prevent override of universal var"
	if begin
		set -q SSH_AUTH_SOCK        	# variable exists
		and test -z "$SSH_AUTH_SOCK"	# variable is empty
		end
		set -e SSH_AUTH_SOCK	# unset empty var to give access back to universl var
		echo "Erased empty SSH_AUTH_SOCK"
	end
	# alternative way of checking
	#set -l SSH_TestEnv_Sock (env | grep '[S]SH_AUTH_SOCK' 2>/dev/null)
	#if test $SSH_TestEnv_Sock = "SSH_AUTH_SOCK="
end
