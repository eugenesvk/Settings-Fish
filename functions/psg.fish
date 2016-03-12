function psg -d "Details on a given process with table headers retained (ps aux | grep $argv"
  ps axu | grep 'COMMAND\|'$argv                # show detailed table of processes matching description
	# -a: all users, no group leaders (1st member of a group of related processes), no processes without controlling terminal
	# -x: adds processes without controlling terminal, such as daemons (launched during boot and run in the background)
	# -u: detailed information about each process
end
