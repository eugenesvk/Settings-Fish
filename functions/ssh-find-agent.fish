# Copyright (C) 2011 by Wayne Walker <wwalker@solid-constructs.com>
# Copyright (C) 2016 by Evgeny Skorobogatko <eugenesvk@gmail.com> (translation to Fish)
#
# Released under one of the versions of the MIT License.
#
# Copyright (C) 2011 by Wayne Walker <wwalker@solid-constructs.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

set _LIVE_AGENT_LIST            	""
set _LIVE_AGENT_SOCK_LIST       	""
set _DEBUG                      	""
set _SSH_AGENT_SOCKETS          	""
set _GPG_AGENT_SOCKETS          	""
set _GNOME_KEYRING_AGENT_SOCKETS	""
set _OSX_KEYCHAIN_AGENT_SOCKETS 	""

function _debug_print
	if test $_DEBUG -gt 0
		printf "%s\n" $argv[1]
	end
end

function find_all_ssh_agent_sockets
	set _SSH_AGENT_SOCKETS (find /tmp/ -type s -name agent.\* 2>/dev/null | grep '/tmp/ssh-.*/agent.*' 2>/dev/null)
	_debug_print "SSH sockets: $_SSH_AGENT_SOCKETS"
end
function find_all_gpg_agent_sockets
	set _GPG_AGENT_SOCKETS (find /tmp/ -type s -name S.gpg-agent.ssh 2>/dev/null | grep '/tmp/gpg-.*/S.gpg-agent.ssh' 2>/dev/null)
	_debug_print "GPG sockets: $_GPG_AGENT_SOCKETS"
end
function find_all_gnome_keyring_agent_sockets
	set _GNOME_KEYRING_AGENT_SOCKETS (find /tmp/ -type s -name ssh 2>/dev/null | grep '/tmp/keyring-.*/ssh$' 2>/dev/null)
	_debug_print "Gnome sockets: $_GNOME_KEYRING_AGENT_SOCKETS"
end
function find_all_osx_keychain_agent_sockets
	test -n "$TMPDIR"; or set TMPDIR /tmp
	#set _OSX_KEYCHAIN_AGENT_SOCKETS (find $TMPDIR/ -type s -regex '.*/ssh-.*/agent..*$' 2>/dev/null)
	_debug_print "OSX sockets: $_OSX_KEYCHAIN_AGENT_SOCKETS"
end

function test_agent_socket
	set -l SOCKET $argv[1]; set -l result ""; set -l _KEY_COUNT ""
	#echo "===In : Sock[$SOCKET] SSH_AUTH_SOCK[$SSH_AUTH_SOCK]=="
	set -gx SSH_AUTH_SOCK $SOCKET
		ssh-add -l >/dev/null 2>/dev/null
		set result $status
		#echo "===Mid: Sock[$SOCKET] SSH_AUTH_SOCK[$SSH_AUTH_SOCK]=="
	set -e SSH_AUTH_SOCK
	#echo "===Out: Sock[$SOCKET] SSH_AUTH_SOCK[$SSH_AUTH_SOCK]=="
	_debug_print "status of `ssh-add -l` $result"
	if test $result -eq 0     # contactible and has keys loaded
		set -gx SSH_AUTH_SOCK $SOCKET
			set _KEY_COUNT (ssh-add -l | wc -l | tr -d ' ')
		set -e SSH_AUTH_SOCK
	end
	if test $result -eq 1     # contactible but no keys loaded
		set _KEY_COUNT 0
	end
	if test $result -eq 0 -o $result -eq 1
		if test -n "$_LIVE_AGENT_LIST"
			set _LIVE_AGENT_LIST "$_LIVE_AGENT_LIST $SOCKET:$_KEY_COUNT"
			#echo "===AgentList:AddedSocket[$SOCKET]=="
		else
			set _LIVE_AGENT_LIST "$SOCKET:$_KEY_COUNT"
			#echo "===AgentList:FirstSocket[$SOCKET]=="
		end
		return 0
	end
	return 1
end

function find_live_ssh_agents
	for i in $_SSH_AGENT_SOCKETS
		test_agent_socket $i
	end
end
function find_live_gpg_agents
	for i in $_GPG_AGENT_SOCKETS
		test_agent_socket $i
	end
end
function find_live_gnome_keyring_agents
	for i in $_GNOME_KEYRING_AGENT_SOCKETS
		test_agent_socket $i
	end
end
function find_live_osx_keychain_agents
	for i in $_OSX_KEYCHAIN_AGENT_SOCKETS
		test_agent_socket $i
	end
end

function find_all_agent_sockets
	set -l _SHOW_IDENTITY 0
	if test (count $argv) -gt 0
		if test $argv[1] = "-i"
			set _SHOW_IDENTITY 1
		end
	end
	set _LIVE_AGENT_LIST ""
	find_all_ssh_agent_sockets
	find_all_gpg_agent_sockets
	find_all_gnome_keyring_agent_sockets
	find_all_osx_keychain_agent_sockets
	find_live_ssh_agents
	find_live_gpg_agents
	find_live_gnome_keyring_agents
	find_live_osx_keychain_agents
	_debug_print "Live agents: $_LIVE_AGENT_LIST"
	set _LIVE_AGENT_LIST (echo $_LIVE_AGENT_LIST | tr ' ' '\n' | sort -n -t: -k 2 -k 1)
	set _LIVE_AGENT_SOCK_LIST ""
	if test $_SHOW_IDENTITY -gt 0
		for i in (seq (count $_LIVE_AGENT_LIST))
			set sock (echo $_LIVE_AGENT_LIST[$i] | sed -e 's/:.*//')
			if test -z "$_LIVE_AGENT_SOCK_LIST"
				set _LIVE_AGENT_SOCK_LIST $sock
			else
				set _LIVE_AGENT_SOCK_LIST $_LIVE_AGENT_SOCK_LIST $sock
			end
			set -gx SSH_AUTH_SOCK $sock; set akeys (ssh-add -l); set -e SSH_AUTH_SOCK
			printf "%s) %s\n%s\n" "$i" "$_LIVE_AGENT_LIST[$i]" $akeys
		end
	else
		printf "%s\n" "$_LIVE_AGENT_LIST" | sed -e 's/ /\n/g' | sort -n -t: -k 2 -k 1
	end
end

function set_ssh_agent_socket
	if test (count $argv) -gt 0
		if begin test $argv[1] = "-c"; or test $argv[1] = "--choose"; end
			find_all_agent_sockets -i
			if test -z "$_LIVE_AGENT_LIST"
				echo "No agents found"
				return
			end
			set -l count4echo (count $_LIVE_AGENT_SOCK_LIST)
			echo -n "Choose (1-$count4echo)? "
			read choice
			if test -n "$choice"
				set n $choice
				if test $n -lt 1 -o $n -gt $count4echo
					echo "Invalid choice"
					return
				else if test -z "$_LIVE_AGENT_SOCK_LIST[$n]"
					echo "Invalid choice"
					return
				end
				echo "Setting SSH_AUTH_SOCK to [$_LIVE_AGENT_SOCK_LIST[$n]]"
				set -Ux SSH_AUTH_SOCK $_LIVE_AGENT_SOCK_LIST[$n]
			end
		end
	else
		# Choose the first available
		set -l SSH_AUTH_SOCK_LOC (find_all_agent_sockets|tail -n 1|awk -F: '{print $argv[1]}')
		if test -n "$SSH_AUTH_SOCK_LOC"
			set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK_LOC
		end
	end
end

function ssh-find-agent
  if test (count $argv) -gt 0
		if begin test $argv[1] = "-c"; or test $argv[1] = "--choose"; end
			set_ssh_agent_socket -c
		else if begin test $argv[1] = "-a"; or test $argv[1] = "--auto"; end
			set_ssh_agent_socket
		end
	else
		find_all_agent_sockets -i
	end
end
