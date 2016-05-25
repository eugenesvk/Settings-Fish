function psg -d "Details on a given process with table headers retained (ps aux | grep $argv); use [a]rgv to avoid showing grep command"
  ps axu | grep '[C]OMMAND\|'$argv                # show detailed table of processes matching description; [] avoids catching COMMAND in self, you'd still have to enclose relevant $argv part in [] to avoid catching self by your argument. Grep would trip over [] in self
	# -a: all users, no group leaders (1st member of a group of related processes), no processes without controlling terminal
	# -x: adds processes without controlling terminal, such as daemons (launched during boot and run in the background)
	# -u: detailed information about each process
end
