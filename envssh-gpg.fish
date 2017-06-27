if test "$SYSTEM_NAME" = Win
	set -gx SSH_KEY_PATH	/c/Users/Evgeny/.ssh/IDs
	# Set vars that would allow ssh-add -c confirmation option to work. DISPLAY set in env.fish
	set -gx SSH_ASKPASS "/usr/lib/git-core/git-gui--askpass"
	#set -gx SSH_ASKPASS "/c/Dev/msys64/usr/lib/git-core/git-askpass"
end
if test "$SYSTEM_NAME" = WinLinux
	set -gx SSH_KEY_PATH /mnt/c/Users/Evgeny/.ssh/IDs
	set -gx SSH_ASKPASS "/usr/bin/ssh-askpass"
end
if test "$SYSTEM_NAME" = OSX
	set -gx GPG_TTY (tty)
	set -gx SSH_KEY_PATH $HOME/.ssh/IDs
	set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)	# allow gpg-agent socket to be used for ssh (~/.gnupg/S.gpg-agent.ssh)
	if test ! (pgrep -U $USER gpg-agent)                        	# if no gpg-agent running make next `ssh` start a gpg-agent, add all ssh keys and continue
	  #gpg-connect-agent /bye                                   	# start gpg-agent since ssh can't autostart
	  #gpgconf --launch gpg-agent                               	# start gpg-agent since ssh can't autostart; kill gpgconf --kill gpg-agent
	  alias ssh 'gpgconf --launch gpg-agent; and ssh-keys-list $SSH_KEY_PATH; and ssh-add $SSH_KEY_LIST; and functions -e ssh; ssh'
	end
end
