function ssh-agent-empty-sock -d "Erase SSH_AUTH_SOCK not matching socket to prevent override of universal var"
	#set -l TMP_SSH_AGENT (echo "$SSH_AUTH_SOCK" | sed 's/\/agent.*//')
	if begin
			set -q SSH_AUTH_SOCK                                  	# variable exists
			#and test -z "$SSH_AUTH_SOCK" -o ! -d "$TMP_SSH_AGENT"	# variable is empty or folder doesn't exist
			and test -z "$SSH_AUTH_SOCK" -o ! -e "$SSH_AUTH_SOCK" 	# variable is empty or file doesn't exist
		end
		echo "Erased empty SSH_AUTH_SOCK $SSH_AUTH_SOCK"
		set -e SSH_AUTH_SOCK	# unset empty var to give access back to universl var
	end
	# alternative way of checking
	#set -l SSH_TestEnv_Sock (env | grep '[S]SH_AUTH_SOCK' 2>/dev/null)
	#if test $SSH_TestEnv_Sock = "SSH_AUTH_SOCK="
end
