function ssh-env-echo -d 'Print SSH environment variables'
	set -l Agent_Env_PID  (env | grep '[S]SH_AGENT_PID' 2>/dev/null)
	set -l Agent_Env_Sock (env | grep '[S]SH_AUTH_SOCK' 2>/dev/null)
	set -l Agent_Exist_PID; set -q SSH_AGENT_PID; if test $status -eq 0
		set Agent_Exist_PID Yes
		if test -n Agent_Env_PID; set Agent_Env_PID X; end
	end
	set -l Agent_Exist_Sock; set -q SSH_AUTH_SOCK; if test $status -eq 0
		set Agent_Exist_Sock Yes
		if test -n SSH_Env_Sock; set Agent_Env_Sock X; end
	end
	echo "SSH Agent [ExistEnv][Val]: PID[$Agent_Exist_PID$Agent_Env_PID][$SSH_AGENT_PID], Socket[$Agent_Exist_Sock$Agent_Env_Sock][$SSH_AUTH_SOCK]"
end
