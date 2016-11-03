function ssh-env-echo -d 'Print SSH environment variables, -f for additional process and socket file info'
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
	set_color $ORANGE; echo -n "Agent vars"; set_color normal; echo -e " [ExistEnv]Value \nPID\t[$Agent_Exist_PID$Agent_Env_PID] $SSH_AGENT_PID \nSocket\t[$Agent_Exist_Sock$Agent_Env_Sock] $SSH_AUTH_SOCK"
	if test -z $argv; return; end
	if test $argv[1] = "-f"
		set -l SSH_SOCKET_FILES (find /tmp/ -maxdepth 2 -type s -name "agent*" 2>/dev/null)
		if test -n "$SSH_SOCKET_FILES"
			set_color $ORANGE; echo "Socket files"; set_color normal
			for i in (seq (count $SSH_SOCKET_FILES))
				echo $SSH_SOCKET_FILES[$i]
			end
		end
		set -l SSH_SOCKET_FOLDERS (find /tmp/ -maxdepth 1 -empty -type d -name "ssh-*" 2>/dev/null)
		if test -n "$SSH_SOCKET_FOLDERS"
			set_color $ORANGE; echo "Socket folders (empty)"; set_color normal
			for i in (seq (count $SSH_SOCKET_FOLDERS))
				echo $SSH_SOCKET_FOLDERS[$i]
			end
		end
		set_color $ORANGE; echo "Agent processes"; set_color normal; psg ssh-agent
		set -l AgentPIDs (pgrep -U $USER ssh-agent)
		if test -n "$AgentPIDs"
			set_color $ORANGE; echo "Agent loaded keys"; set_color normal; ssh-add -l -E md5
		end
		set_color $ORANGE; echo -n "Private keys"; set_color normal; echo ' stored in $SSH_KEY_LIST'
		for i in (seq (count $SSH_KEY_LIST))
			echo $SSH_KEY_LIST[$i]
		end
	end
end
